module Executors
  module Posts
    class Update < Executors::Base
      def perform
        return false unless update_attributes || post.valid?

        post.save!
      end

      private

      def update_attributes
        post.assign_attributes(**attributes)
      end

      def post
        @post ||= object
      end

      def attributes
        form_attributes.except(*excepted_attributes)
      end

      def excepted_attributes
        [].tap do |attrs|
          attrs << :image if form_attributes[:image].blank?
          attrs << :pictures if form_attributes[:pictures] == ['']
        end
      end
    end
  end
end
