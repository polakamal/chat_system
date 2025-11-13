module Services
  module Applications
    class Index
      DEFAULT_PAGE = 1
      DEFAULT_PER_PAGE = 20

      def initialize(options = {})
        @page = options.fetch(:page, DEFAULT_PAGE).to_i
        @per_page = options.fetch(:per_page, DEFAULT_PER_PAGE).to_i
      end

      def to_hash
        apps = applications
        {
          current_page: apps.current_page,
          per_page: apps.limit_value,
          total_pages: apps.total_pages,
          total_count: apps.total_count,
          applications: apps.as_json(except: [:id])
        }
      end
      #-------#
      private
      #-------#

      def applications
        Application.page(@page).per(@per_page)
      end
    end
  end
end