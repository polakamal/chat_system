module Services
  module Messages
    class Show
      def initialize(options = {})
        @application_token = options[:application_token]
        @chat_number = options[:chat_number]
        @message_number = options[:message_number]
      end
      
      def to_hash  
        MessageSerializer.new(message).as_json
      end
      
      #-------#
      private
      #-------#
      def chat
        @chat ||= Chat.joins(:application).find_by!(applications: { token: @application_token }, number: @chat_number)
      end

      def message
        @message ||= chat.messages.find_by!(number: @message_number)
      end
    end
  end
end
      