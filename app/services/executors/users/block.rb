module Executors
  module Users
    class Block < Executors::Base
      def perform
        block.save!
      end

      private

      def block
        Block.new(blocker: user, blocked: action_user)
      end

      def action_user
        object
      end
    end
  end
end
