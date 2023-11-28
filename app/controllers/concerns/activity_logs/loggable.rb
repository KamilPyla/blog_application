module ActivityLogs
  module Loggable
    extend ::Transactionable

    def create_log
      ActiveRecord::Base.transaction do
        ::ActivityLogs::Creator.perform(user: current_user, action_message:, action_subject:, ip_address:)
      end
    end

    private

    def ip_address
      request.ip
    end

    def action_message
      ::NameConvention.klass_name(:activity_logs_message, action_subject).perform(action_name)
    end

    def action_subject
      raise NotImplementedError, __method__
    end
  end
end
