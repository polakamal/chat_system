module Services
  module Applications
    class Create
      def initialize(options = {})
        @params = options[:params]
      end

      def process!
        assign
        persist!
      end 

      #-------#
       private
      #-------#

      # Assign attributes
      def assign
        @application ||= ::Application.new(@params)
        @application.token = unique_token
      end

      def persist!
        @application.save!
      end

      # Simple token generator
      def unique_token
        SecureRandom.uuid
      end
    end
  end
end