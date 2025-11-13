module Services
  module Chats
    class Create
      def initialize(options = {})
        @application_token = options[:application_token]
      end
  
      # Step 1: process the creation asynchronously
      def process!
        @number = next_chat_number
        ::Chats::CreateJob.perform_async(application.id, @number)
      end
  
      # Step 2: return the allocated number
      def number
        @number
      end
  
      #-------#
      private
      #-------#
  
      def application
        @application ||= Application.find_by!(token: @application_token)
      end
  
      def next_chat_number
        Counters::ChatCounter.next(application.id)
      end
    end
  end
end
  