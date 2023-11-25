module ActivityLogs
  class Creator
    extend ::Performable

    def initialize(user:, action:, action_subject:, ip_address:)
      @user = user
      @action = action
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
