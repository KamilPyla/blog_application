module ActivityLogs
  module Message
    class User < Base
      private

      def action_mapper
        {
          update: 'Edytowano profil',
          block: "Zablokowano użytkowika o emailu: #{email}",
          following: "Dodano do obserwowanych użytkownika o emailu: #{email}"
        }
      end

      def destory_action
        object ? "Usunięto post o nazwie: #{object.title}" : 'Usunięto post.'
      end

      def email
        @object.email
      end
    end
  end
end
