module ActivityLogs
  module Loggable
    extend ::Transactionable

    def create_log
      ActiveRecord::Base.transaction do
        ::ActivityLogs::Creator.perform(user: current_user, action:, action_subject:, ip_address:)
      end
    end

    private

    def ip_address
      request.ip
    end

    def action
      action_name_map.fetch(action_name.to_sym, 'Nierozpoznana akcja')
    end

    def action_name_map
      raise NotImplementedError, __method__
    end

    def action_subject
      raise NotImplementedError, __method__
    end
  end
end
