class CommentsController < CommonActionController
  include ::ActivityLogs::Loggable
  include ::Toasts::Broadcaster
  include ::PolymorphicLoader

  before_action :load_object, only: [:create, :new]
  before_action :load_comment, only: :destroy
  before_action :load_action_context, only: [:create, :destroy]
  after_action :create_log, only: [:create, :destroy]

  def new; end

  def create
    respond_to do |format|
      if @action_context.perform
        format.html { redirect_to nested_subject(@object), notice: notice }
        broadcast_notice
      else
        broadcast_alert
      end
    end
  end

  def destroy
    respond_to do |format|
      if @action_context.perform
        format.html { redirect_to nested_subject(@object), notice: notice }
        broadcast_notice
      else
        broadcast_alert
      end
    end
  end

  private

  def action_subject
    :comment
  end

  def load_comment
    @object ||= Comment.find_by(id: params[:id])
  end

  def permitted_params
    params.permit!
  end
end
