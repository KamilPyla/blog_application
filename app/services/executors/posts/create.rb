module Executors
  module Posts
    class Create < Executors::Base
      def perform
        create_post!
      end

      private

      def create_post!
        user.posts.create!(form_attributes)
      end
    end
  end
end
