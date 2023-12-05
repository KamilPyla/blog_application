module Executors
  module Users
    class Block < Executors::Base
      def perform
        return false if already_exists?

        block.save!
      end

      private

      def already_exists?
        Blockade.where(blocker: user, blocked: action_user).any?
      end

      def block
        Blockade.new(blocker: user, blocked: action_user)
      end

      def action_user
        object
      end
    end
  end
end
