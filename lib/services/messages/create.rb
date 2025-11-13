module Services
  module Messages
    class Create
      def initialize(options = {})
        @application_token = options[:application_token]
        @chat_number = options[:chat_number]
        @params = options[:params]
      end
    
      # Step 1: process the creation asynchronously
      def process!
        @number = next_message_number
        ::Messages::CreateJob.perform_async(chat.id, @number, @params[:body])
      end
    
       # Step 2: return the allocated number
      def number
        @number
      end
    
      #-------#
      private
      #-------#
    
      def chat
        @chat ||= Chat.joins(:application).find_by!(applications: { token: @application_token }, number: @chat_number)
      end
    
      def next_message_number
        Counters::MessageCounter.next(chat.id)
      end

    end
  end
end
    