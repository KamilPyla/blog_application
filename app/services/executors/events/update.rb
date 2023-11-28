module Executors
  module Events
    class Update < Executors::Base
      def perform
        return false unless update_attributes || event.valid?

        event.save!
      end

      private

      def update_attributes
        event.assign_attributes(**form_attributes)
      end

      def event
        @event ||= object
      end
    end
  end
end
