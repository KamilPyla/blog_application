module Executors
  module Reactions
    class Dislike < Executors::Base
      def perform
        reaction.destroy! if reaction
      end

      private

      def reaction
        object.reactions.find_by(user: user)
      end
    end
  end
end
