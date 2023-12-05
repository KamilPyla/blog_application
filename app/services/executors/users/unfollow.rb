module Executors
  module Users
    class Unfollow < Executors::Base
      def perform
        return false if observation.blank?

        observation.destroy!
      end

      private

      def action_user
        object
      end

      def observation
        Observation.find_by(follower: user, followed: action_user)
      end
    end
  end
end
