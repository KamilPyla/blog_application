module ActivityLogs
  class Creator
    extend ::Performable

    def initialize(user:, action:, ip_address:)
      @user = user
      @action = action
      @ip_address = ip_address
    end

    def perform
      ::ActivityLog.create!(user:, action:, ip_address:)
    end

    private

    attr_reader :user, :action, :ip_address
  end
end
