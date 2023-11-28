module Executors
  module Events
    class Create < Executors::Base
      def perform
        return false unless event.valid?

        event.save!
      end

      private

      def event
        user.events.build(form_attributes)
      end
    end
  end
end
