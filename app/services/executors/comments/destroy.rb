module Executors
  module Comments
    class Destroy < Executors::Base
      def perform
        comment.destroy!
      end

      private

      def performable?
        object.user_id == current_user.id || nested_subject.user_id == current_user.id
      end

      def comment
        object
      end

      def subject_author?

      end

      def nested_subject(object)
        return object unless object.is_a?(Comment)

        nested_subject(object.subject)
      end
    end
  end
end
