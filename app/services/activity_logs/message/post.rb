module ActivityLogs
  module Message
    class Post < Base
      private

      def action_mapper
        {
          create: 'Dodano post',
          update: 'Edytowano post',
          destroy: destory_action
        }
      end

      def destory_action
        object ? "Usunięto post o nazwie: #{object.title}" : 'Usunięto post.'
      end
    end
  end
end
