class Message < ApplicationRecord
  belongs_to :chat

  validates :number, presence: true, uniqueness: { scope: :chat_id }
  validates :body, presence: true

  after_commit :index_document, on: [:create, :update]

  ELASTICSEARCH_INDEX = 'messages'

  # -------------------------------
  # Elasticsearch index definition
  # -------------------------------
  def self.create_es_index
    return if ELASTICSEARCH_CLIENT.indices.exists?(index: ELASTICSEARCH_INDEX)

    ELASTICSEARCH_CLIENT.indices.create(
      index: ELASTICSEARCH_INDEX,
      body: {
        mappings: {
          properties: {
            chat_id:    { type: 'keyword' },
            body:       { type: 'text', analyzer: 'standard' },
            created_at: { type: 'date' }
          }
        }
      }
    )
  end

  # -------------------------------
  # Custom JSON representation for Elasticsearch
  # -------------------------------
  def as_indexed_json(_options = {})
    {
      chat_id: chat_id,
      body: body,
      created_at: created_at
    }
  end

  # -------------------------------
  # Index a record in Elasticsearch
  # -------------------------------
  def index_document
    self.class.create_es_index
    ELASTICSEARCH_CLIENT.index(
      index: ELASTICSEARCH_INDEX,
      id: id,
      body: as_indexed_json
    )
  end

  # -------------------------------
  # Search messages inside a chat
  # -------------------------------
  # chat_id: ID of the chat
  # query: string to search in message body
  # options: hash for additional options like limit/size
  # Returns array of message hashes
  def self.search_in_chat(chat_id, query, options = {})
    create_es_index unless ELASTICSEARCH_CLIENT.indices.exists?(index: ELASTICSEARCH_INDEX)
    size = options[:size] || 20

    response = ELASTICSEARCH_CLIENT.search(
      index: ELASTICSEARCH_INDEX,
      body: {
        query: {
          bool: {
            must: [
              { term: { chat_id: chat_id } },
              {
                wildcard: {
                  body: {
                    value: "*#{query}*",
                    case_insensitive: true
                  }
                }
              }
            ]
          }
        },
        sort: [
          { created_at: { order: 'desc' } }
        ],
        size: size
      }
    )
    # Map hits to simple hashes
    response.dig('hits', 'hits')&.map { |hit| hit['_source'] } || []
  end
end
