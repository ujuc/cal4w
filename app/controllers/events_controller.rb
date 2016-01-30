class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :join, :update, :destroy]
  before_action :permission_check, only: [:edit, :update, :destroy]

  respond_to :html, :json

  def index
    @events = Event.all
    respond_with(@events)
  end

  def show
    @user = current_user
    respond_with(@event)
  end

  def join
    @event.members << current_user
  end

  def new
    @event = Event.new
    respond_with(@event)
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    @event.save
    respond_with(@event)
  end

  def update
    @event.update(event_params)
    respond_with(@event)
  end

  def destroy
    @event.destroy
    respond_with(@event)
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:subject, :place, :description, :start_time, :finish_time)
  end

  def permission_check
    fail User::NoPermission unless @event.editable? current_user
  end
end
