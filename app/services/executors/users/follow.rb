module Executors
  module Users
    class Follow < Executors::Base
      def perform
        return false if already_exists?

        observation.save!
      end

      private

      def action_user
        object
      end

      def already_exists?
        Observation.where(follower: user, followed: action_user).any?
      end

      def observation
        Observation.new(follower: user, followed: action_user)
      end
    end
  end
end
