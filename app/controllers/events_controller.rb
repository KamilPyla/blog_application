class EventsController < CommonActionController
  include ::ActivityLogs::Loggable

  before_action :user_log_in?, except: [:index, :show]  
  before_action :set_object, only: %i[show edit update destroy buy_ticket]
  after_action :create_log, only: %i[create update destroy buy_ticket]
  before_action :load_action_context, only: %i[create update destroy buy_ticket]
  before_action :verify_params, only: %i[create update]
  before_action :check_ability, only: %i[new edit create update destroy]
  before_action :set_user, only: :users_events

  def index
    @events = events_scope
  end

  def show; end

  def show_tickets
    @tickets = current_user.tickets.includes(:event)
  end

  def users_events
    @events = @user.events.includes(image_attachment: :blob).order(start_at: :desc)
  end

  def new
    @object = Event.new
  end

  def edit; end

  def create
    respond_to do |format|
      if @action_context.perform
        format.html { redirect_to events_path, notice: notice }
        broadcast_notice 
      else
        format.html { render :new, status: :unprocessable_entity }
        broadcast_alert
      end
    end
  end

  def update
    respond_to do |format|
      if @action_context.perform
        format.html { redirect_to events_path, notice: notice }
        broadcast_notice
      else
        format.html { render :edit, status: :unprocessable_entity }
        broadcast_alert
      end
    end
  end

  def destroy
    respond_to do |format|
      if @action_context.perform
        format.html { redirect_to events_path, notice: notice }
        broadcast_notice
      else
        format.html { render status: :unprocessable_entity }
        broadcast_alert
      end
    end
  end

  def buy_ticket
    respond_to do |format|
      if @action_context.perform
        format.html { redirect_to @object, notice: notice }
        broadcast_notice
      else
        format.html { render status: :unprocessable_entity }
        broadcast_alert
      end
    end
  end

  private

  def events_scope
    if admin_signed_in?
      Event.includes(image_attachment: :blob).order(start_at: :desc)
    else
      Event.active.followers(current_user).includes(image_attachment: :blob).order(start_at: :desc)
    end
  end

  def set_user
    @user ||= User.find_by uuid: params[:uuid]
  end

  def set_object
    @object = Event.find(params[:id])
  end

  def permitted_params
    params.fetch(:event, params).permit!
  end

  def action_subject
    :event
  end
end
