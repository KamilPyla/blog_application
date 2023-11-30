class ActivityLogsController < ApplicationController
  def index
    @activity_logs ||= current_user.activity_logs
  end

  def action_subject
    @activity_logs ||= current_user.activity_logs.where(action_subject: kind)
  end

  private

  def kind
    @kind ||= params[:action_subject].to_sym
  end
end
