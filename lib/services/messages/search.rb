module Services
  module Messages
    class Search
      def initialize(options = {})
        @application_token = options[:application_token]
        @chat_number = options[:chat_number]
        @message_number = options[:message_number]
        @query = options[:query]
      end
        
      def to_hash  
        messages.map { |m| m['body']  }
      end
        
      #-------#
      private
      #-------#
      def chat
        @chat ||= Chat.joins(:application).find_by!(applications: { token: @application_token }, number: @chat_number)
      end
  
      def messages
        @messages ||= Message.search_in_chat(chat.id, @query)
      end
    end
  end
end
        