module Executors
  module Posts
    class Update < Executors::Base
      def perform
        return false unless update_attributes || post.valid?

        post.save!
      end

      private

      def update_attributes
        post.assign_attributes(**form_attributes)
      end

      def post
        @post ||= object
      end
    end
  end
end
