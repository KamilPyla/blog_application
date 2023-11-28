module Executors
  module Posts
    class Create < Executors::Base
      def perform
        return false unless post.valid?

        post.save!
      end

      private

      def post
        user.posts.build(form_attributes)
      end
    end
  end
end
