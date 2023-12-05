module Executors
  module Users
    class Unblock < Executors::Base
      def perform
        return false if block.blank?

        block.destroy!
      end

      private

      def block
        Blockade.find_by(blocker: user, blocked: action_user)
      end

      def action_user
        object
      end
    end
  end
end
