module Chats
  class CreateJob
    include Sidekiq::Worker
    sidekiq_options queue: :default

    def perform(application_id, chat_number, attributes = {})
      # Ensure no duplicates
      chat = Chat.find_or_initialize_by(application_id: application_id, number: chat_number)
      # Assign attributes (symbolized keys for safety)
      chat.assign_attributes(attributes.symbolize_keys)
      # Save the chat
      chat.save!  # triggers after_commit callbacks if you have them (e.g., ES indexing)
    end
  end
end