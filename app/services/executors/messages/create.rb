module Executors
  module Messages
    class Create < Executors::Base
      def perform
        return if thread.blocked?

        build_message.save!
      end

      private

      def thread
        @object
      end

      def build_message
        thread.messages.new(user: user, **form_attributes)
      end
    end
  end
end
