module Executors
  module Users
    class Update < Executors::Base
      def perform
        return false unless update_attributes || action_user.valid?

        action_user.save!
      end

      private

      def action_user
        @action_user ||= object
      end

      def update_attributes
        action_user.assign_attributes(**attributes)
      end

      def attributes
        form_attributes.except(*excepted_attributes)
      end

      def excepted_attributes
        [].tap do |attrs|
          attrs << :avatar if form_attributes[:avatar].blank?
          attrs << :login if action_user.login.present?
        end
      end
    end
  end
end
