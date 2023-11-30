module Executors
  module Posts
    class Destroy < Executors::Base
      def perform
        post.destroy!
      end

      private

      def post
        @post ||= object
      end
    end
  end
end
