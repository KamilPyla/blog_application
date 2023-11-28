module ActivityLogs
  module Message
    class Login < Base
      private

      def action_mapper
        {
          create: 'Zalogowano',
          destroy: 'Wylogowano'
        }
      end
    end
  end
end
