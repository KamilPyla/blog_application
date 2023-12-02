module Executors
  module Events
    class Create < Executors::Base
      def perform
        create_event!
      end

      private

      def create_event!
        user.events.create!(form_attributes)
      end
    end
  end
end
