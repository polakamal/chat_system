module Services
  module Chats
    class Show
      def initialize(options = {})
        @application_token = options[:application_token]
        @number = options[:number]
      end
    
      def to_hash  
        ChatSerializer.new(chat).as_json
      end
    
      #-------#
        private
      #-------#
    
      def chat
        @chat ||= Chat.joins(:application).find_by!(applications: { token: @application_token }, number: @number)
      end
    end
  end
end
    