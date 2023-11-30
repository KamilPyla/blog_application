module ActivityLogs
  module Message
    class Base
      extend ::Performable

      def initialize(action, object = nil)
        @action = action.to_sym
        @object = object
      end

      def perform
        action_mapper.fetch(action, 'Nierozpoznana akcja')
      end

      private

      attr_reader :action, :object

      def action_mapper
        raise NotImplementedError, __method__
      end
    end
  end
end
