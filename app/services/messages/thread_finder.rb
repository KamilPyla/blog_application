module Messages
  class ThreadFinder
    extend ::Performable

    def initialize(current_user: nil, other_user: nil, uuid: nil)
      @current_user = current_user
      @other_user = other_user
      @uuid = uuid
    end

    def perform
      find_thread || MessageThread.create!(sender: current_user, adressee: other_user)
    end

    private

    attr_reader :current_user, :other_user, :uuid

    def find_thread
      case
      when uuid.present?
        MessageThread.find_by(uuid: uuid)
      else
        MessageThread.find_by(sender: current_user, adressee: other_user) || MessageThread.find_by(adressee: current_user, sender: other_user)
      end
    end
  end
end
