module ActivityLogs
  module Message
    class Post < Base
      private

      def action_mapper
        {
          create: 'Dodano post',
          update: 'Edytowano post',
          destroy: 'Usunięto post'
        }
      end
    end
  end
end
