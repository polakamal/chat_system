# app/jobs/update_counters_job.rb
module Applications
  class UpdateCountersJob
    include Sidekiq::Worker
    sidekiq_options queue: :default

    def perform  
      # Update Applications messages_count
      Application.find_each do |application|
        chats_count = Chat.where(application_id: application.id).count
        application.update_columns(chats_count: chats_count)
      end
    end
  end
end
