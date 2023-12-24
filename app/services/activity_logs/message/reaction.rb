module ActivityLogs
  module Message
    class Reaction < Base
      private

      def action_mapper
        {
          like: 'Polubiono wpis',
          dislike: 'Usunięto polubienie'
        }
      end
    end
  end
end
