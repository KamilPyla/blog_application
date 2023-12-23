module Executors
  module Comments
    class Destroy < Executors::Base
      def perform
        comment.destroy!
      end

      private

      def comment
        object
      end
    end
  end
end
