module Services
  module Messages
    class Index
      DEFAULT_PAGE = 1
      DEFAULT_PER_PAGE = 20
    
      def initialize(options = {})
        @application_token = options[:application_token]
        @chat_number = options[:chat_number]
        @page = options.fetch(:page, DEFAULT_PAGE).to_i
        @per_page = options.fetch(:per_page, DEFAULT_PER_PAGE).to_i
      end
    
      def to_hash
        {
          current_page: messages.current_page,
          per_page: messages.limit_value,
          total_pages: messages.total_pages,
          total_count: messages.total_count,
          messages: messages.as_json(except: [:id])
        }
      end
        
      #-------#
      private
      #-------#
    
      def chat
        @chat ||= Chat
          .joins(:application)
          .includes(:messages)
          .find_by!(applications: { token: @application_token }, number: @chat_number)
      end

      def messages
        chat.messages.page(@page).per(@per_page)
      end
    end
  end
end