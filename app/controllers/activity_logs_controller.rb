class ActivityLogsController < ApplicationController
  def index
    @activity_logs ||= current_user.activity_logs.order(created_at: :desc)
                                   .page(params[:page]).per(17)
  end

  def action_subject
    @activity_logs ||= current_user.activity_logs.where(action_subject: kind).order(created_at: :desc)
                                   .page(params[:page]).per(17)
  end

  private

  def kind
    @kind ||= params[:action_subject].to_sym
  end
end
