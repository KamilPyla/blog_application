module ActivityLogs
  module Message
    class Comment < Base
      private

      def action_mapper
        {
          create: 'Dodano komentarz',
          destroy: 'Usunięto komentarz'
        }
      end
    end
  end
end
