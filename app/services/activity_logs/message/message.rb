module ActivityLogs
  module Message
    class Message < Base
      private

      def action_mapper
        {
          create: 'Dodano wiadomość',
          destroy: 'Usunięto wiadomość'
        }
      end
    end
  end
end
