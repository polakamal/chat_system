module Services
  module Applications
    class Show
      def initialize(options = {})
        @token = options[:token]
      end
  
      def to_hash  
        ApplicationSerializer.new(application).as_json
      end
  
      #-------#
       private
      #-------#
  
      def application
        @application ||= Application.find_by!(token: @token)
      end
    end
  end
end
  