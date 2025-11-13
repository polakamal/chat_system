module Messages
  class CreateJob
    include Sidekiq::Worker
    sidekiq_options queue: :default

    def perform(chat_id, message_number, body)
      Message.create!(
        chat_id: chat_id,
        number: message_number,
        body: body
      )
    end
  end
end
    