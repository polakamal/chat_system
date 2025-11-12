module Services
  module Applications
    class Show
      def initialize(options = {})
        @token = options[:token]
      end
  
      def to_hash  
        raise ActiveRecord::RecordNotFound, "Application not found" unless application
        {
          token: application.token,
          name: application.name,
          chats_count: application.chats_count,
          created_at: application.created_at,
          updated_at: application.updated_at
        }
      end
  
      #-------#
       private
      #-------#
  
      def application
        @application ||= Application.find_by(token: @token)
      end
    end
  end
end
  