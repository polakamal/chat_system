# app/jobs/update_counters_job.rb
module Chats
  class UpdateCountersJob
    include Sidekiq::Worker
    sidekiq_options queue: :default
    
    def perform  
      # Update chats messages_count
      Chat.find_each do |chat|
        messages_count = Message.where(chat_id: chat.id).count
        chat.update_columns(messages_count: messages_count)
      end
    end
  end
end