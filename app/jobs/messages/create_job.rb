module Messages
  class CreateJob
    include Sidekiq::Worker
    sidekiq_options queue: :default

    def perform(chat_id, number, body)
      # Avoid creating duplicates
      message = Message.find_or_initialize_by(chat_id: chat_id, number: number)
      message.body = body
      message.save!   # triggers after_commit to index in ES
    end
  end
end
    