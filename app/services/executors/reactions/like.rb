module Executors
  module Reactions
    class Like < Executors::Base
      def perform
        reaction
      end

      private

      def reaction
        object.reactions.find_or_create_by(user: user)
      end
    end
  end
end
