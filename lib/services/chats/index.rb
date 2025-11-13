module Services
  module Chats
    class Index
      DEFAULT_PAGE = 1
      DEFAULT_PER_PAGE = 20
  
      def initialize(options = {})
        @application_token = options[:application_token]
        @page = options.fetch(:page, DEFAULT_PAGE).to_i
        @per_page = options.fetch(:per_page, DEFAULT_PER_PAGE).to_i
      end
  
      def to_hash
        {
          current_page: chats.current_page,
          per_page: chats.limit_value,
          total_pages: chats.total_pages,
          total_count: chats.total_count,
          chats: chats.as_json(except: [:id])
        }
      end
      
      #-------#
      private
      #-------#
  
      def chats
        @chats ||= Chat.joins(:application).where(applications: { token: @application_token })
         .page(@page).per(@per_page)
      end
      
    end
  end
end