module ActivityLogs
  module Message
    class Event < Base
      private

      def action_mapper
        {
          create: 'Dodano wydarzenie',
          update: 'Edytowano wydarzenie',
          destroy: destory_action,
          buy_ticket: 'Kupiono bilet'
        }
      end

      def destory_action
        object ? "Usunięto wydarzenie o nazwie: #{object.title}" : 'Usunięto wydarzenie.'
      end
    end
  end
end
