module ActivityLogs
  module Loggable
    extend ::Transactionable

    def create_log
      ActiveRecord::Base.transaction do
        ::ActivityLogs::Creator.perform(user: current_user, action:, ip_address:)
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
      raise NotImplementedError, 'action_name_map'
    end
  end
end
