module ActivityLogs
  module Message
    class Base
      extend ::Performable

      def initialize(action)
        @action = action.to_sym
      end

      def perform
        action_mapper.fetch(action, 'Nierozpoznana akcja')
      end

      private

      attr_reader :action

      def action_mapper
        raise NotImplementedError, __method__
      end
    end
  end
end
