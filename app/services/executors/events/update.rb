module Executors
  module Events
    class Update < Executors::Base
      def perform
        return false unless update_attributes || event.valid?

        event.save!
      end

      private

      def update_attributes
        event.assign_attributes(**attributes)
      end

      def event
        @event ||= object
      end

      def attributes
        form_attributes.except(*excepted_attributes)
      end

      def excepted_attributes
        [].tap do |attrs|
          attrs << :image if form_attributes[:image].blank?
        end
      end
    end
  end
end
