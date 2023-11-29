class EventsController < CommonActionController
  include ::ActivityLogs::Loggable

  before_action :set_object, only: %i[show edit update destroy]
  after_action :create_log, only: %i[create update destroy]
  before_action :load_action_context, only: %i[create update destroy]
  before_action :verify_params, only: %i[create update]
  before_action :check_ability, only: %i[new edit create update destroy]

  def index
    @events = Event.all
  end

  def show; end

  def new
    @object = Event.new
  end

  def edit; end

  def create
    respond_to do |format|
      if @action_context.perform
        format.html { redirect_to events_path, notice: 'Dodano wydarzenie' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @action_context.perform
        format.html { redirect_to events_path, notice: 'Edytowano wydarzenie' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /objects/1 or /objects/1.json
  def destroy
    respond_to do |format|
      if @action_context.perform
        format.html { redirect_to events_path, notice: 'Usunięto wydarzenie' }
      else
        format.html { render status: :unprocessable_entity }
      end
    end
  end

  private

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