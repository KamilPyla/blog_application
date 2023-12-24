class ReactionsController < CommonActionController
  include ::ActivityLogs::Loggable
  include ::PolymorphicLoader

  before_action :load_object, only: [:like, :dislike]
  before_action :load_action_context, only: [:like, :dislike]
  after_action :create_log, only: [:like, :dislike]

  def like
    if @action_context.perform
      redirect_to nested_subject(@object), notice: notice
      broadcast_notice
    else
      broadcast_alert
    end
  end

  def dislike
    if @action_context.perform
      redirect_to nested_subject(@object), notice: notice
      broadcast_notice
    else
      broadcast_alert
    end
  end

  private

  def action_subject
    :reaction
  end

  def permitted_params
    params.permit!
  end
end
