module Executors
  module Messages
    class Destroy < Executors::Base
      def perform
        return unless performable?

        message.destroy!
      end

      private

      def performable?
        object.user_id == user.id
      end

      def message
        object
      end
    end
  end
end
