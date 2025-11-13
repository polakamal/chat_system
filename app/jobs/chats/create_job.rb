module Chats
  class CreateJob
    include Sidekiq::Worker
    sidekiq_options queue: :default

    def perform(application_id, chat_number, attributes = {})
      Chat.create!(
        application_id: application_id,
        number: chat_number,
        **attributes.symbolize_keys
      )
    end
  end
end