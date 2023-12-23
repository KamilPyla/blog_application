class CommentsController < CommonActionController
  include ::ActivityLogs::Loggable
  include ::Toasts::Broadcaster

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

  def nested_subject(object)
    return object unless object.is_a?(Comment)
    
    nested_subject(object.subject)
  end

  def load_object
    return if klass == :empty

    @object ||= klass.find_by(id: params[:id])
  end

  def load_comment
    @object ||= current_user.comments.find_by(id: params[:id])
  end

  def permitted_params
    params.permit!
  end

  def klass
    params[:kind].classify.constantize

  rescue NameError
    :empty
  end
end
