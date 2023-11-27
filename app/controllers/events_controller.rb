class EventsController < ApplicationController
  include ::ActivityLogs::Loggable

  before_action :set_event, only: %i[show edit update destroy]
  after_action :create_log, only: %i[create update destroy]

  def index
    @events = Event.all
  end

  def show; end

  def new
    @event = Event.new
  end

  def edit; end

  def create
    @event = current_user.events.build(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to event_url(@event), notice: "Event was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: "Event was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy!

    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def permitted_params
    %i[title city max_tickets price street date start_at content image max_tictets ]
  end


  def event_params
    params.fetch(:event, {}).permit(*permitted_params).compact
  end

  def action_subject
    :event
  end

  def action_name_map
    {
      create: 'Dodano wydarzenie',
      update: 'Edytowano wydarzenie',
      destroy: "Usunięto wydarzenie o tytule: #{@event.try(:title)}"
    }
  end
end
