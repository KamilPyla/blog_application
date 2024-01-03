class MessagesController < CommonActionController
  include ::ActivityLogs::Loggable
  include ::Toasts::Broadcaster
  include ::PolymorphicLoader

  before_action :load_thread, only: [:create, :new]
  before_action :load_message, only: :destroy
  before_action :load_action_context, only: [:create, :destroy]
 
  def new
    @thread ||= Messages::ThreadFinder.perform(current_user: current_user, other_user: adressee)
    redirect_to conversation_show_path(@thread.uuid)
  end

  def show
    @thread ||= Messages::ThreadFinder.perform(uuid: params[:thread_uuid])
  end

  def index
    @message_threads = MessageThread.by_user(current_user)
  end

  def create
    respond_to do |format|
      if @action_context.perform
        format.html { redirect_to conversation_show_path(@object.uuid), notice: notice }
        broadcast_notice
      else
        broadcast_alert
      end
    end
  end

  def destroy
    respond_to do |format|
      if @action_context.perform
        format.html { redirect_to conversation_show_path(@object.message_thread.uuid), notice: notice }
        broadcast_notice
      else
        broadcast_alert
      end
    end
  end

  private

  def action_subject
    :message
  end

  def load_thread
    @object ||= Messages::ThreadFinder.perform(uuid: params[:thread_uuid])
  end

  def load_message
    @object ||= Message.find_by(id: params[:message_id])
  end

  def permitted_params
    params.permit!
  end

  def adressee
    User.find_by(id: adressee_id)
  end

  def adressee_id
    params[:adressee_id]
  end
end
