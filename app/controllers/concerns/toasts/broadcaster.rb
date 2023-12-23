module Toasts
  module Broadcaster
    extend ActiveSupport::Concern

    private

    def broadcast_alert(optional_alert = nil)
      Turbo::StreamsChannel.broadcast_append_to :"dynamic_toast_#{current_user.uuid}",
                                                 target: "toast_#{current_user.uuid}",
                                                 partial: 'layouts/notice_message',
                                                 locals: { alert: optional_alert || alert }
    end

    def broadcast_notice(optional_notice = nil)
      Turbo::StreamsChannel.broadcast_append_to :"dynamic_toast_#{current_user.uuid}",
                                                 target: "toast_#{current_user.uuid}",
                                                 partial: 'layouts/notice_message',
                                                 locals: { notice: optional_notice || notice }
    end

    def notice
      ::I18n.t(notice_key)
    end

    def alert
      ::I18n.t(alert_key)
    end

    def notice_key
      :"toasts.#{action_subject}.#{action_name}.notice"
    end

    def alert_key
      :"toasts.#{action_subject}.#{action_name}.alert"
    end
  end
end
