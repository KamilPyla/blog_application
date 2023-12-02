module Executors
  module Users
    class Following < Executors::Base
      def perform
        observation.save!
      end

      private

      def action_user
        object
      end

      def observation
        Observation.new(follower: user, followed: action_user)
      end
    end
  end
end
