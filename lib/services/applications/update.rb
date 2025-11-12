module Services
  module Applications
    class Update
      def initialize(options = {})
        @token = options[:token]
        @params = options[:params]
      end
  
      def process!
        find_application
        persist!
      end
  
      #-------#
       private
      #-------#
  
      # Assign attributes
      def find_application
        @application = Application.lock.find_by!(token: @token)
      end
  
      def persist!
        @application.update!(@params)
      end
    end
  end
end