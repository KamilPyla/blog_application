module ActivityLogs
  class Creator
    extend ::Performable

    def initialize(user:, action_message:, action_subject:, ip_address:)
      @user = user
      @action = action_message
      @ip_address = ip_address
      @action_subject = action_subject
    end

    def perform
      ::ActivityLog.create!(user:, action:, ip_address:, action_subject:)
    end

    private

    attr_reader :user, :action, :ip_address, :action_subject
  end
end
