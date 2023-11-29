module Executors
  module Posts
    class Destroy < Executors::Base
      def perform
        binding.pry
        post.destroy!
      end

      private

      def post
        @post ||= object
      end
    end
  end
end
