module ActivityLogs
  module Message
    class User < Base
      private

      def action_mapper
        {
          update: 'Edytowano profil',
          block: "Zablokowano użytkowika o emailu: #{email}",
          unblock: "Odblokowano użytkowika o emailu: #{email}",
          follow: "Dodano do obserwowanych użytkownika o emailu: #{email}",
          unfollow: "Usunięto z obserwowanych użytkownika o emailu: #{email}"
        }
      end

      def email
        @object.email
      end
    end
  end
end
