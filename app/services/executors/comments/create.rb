module Executors
  module Comments
    class Create < Executors::Base
      def perform
        build_comment.save!
      end

      private

      def build_comment
        object.comments.new( user: user, **form_attributes)
      end
    end
  end
end
