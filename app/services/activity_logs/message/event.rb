module ActivityLogs
  module Message
    class Event < Base
      private

      def action_mapper
        {
          create: 'Dodano wydarzenie',
          update: 'Edytowano wydarzenie',
          destroy: 'Usunięto wydarzenie.'
        }
      end
    end
  end
end
