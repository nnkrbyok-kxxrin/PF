class EventsController < ApplicationController

  # 以下はsimple_calendar用の記述

  def index
    @event = Event.new
    @events = Event.all
  end

  def create
    @event = Event.new(event_params)
    @event.admin_id = current_admin.id
    if @event.save
       redirect_to events_path
    else
       render :index
    end
  end

  def show
  end

  def edit
  end

  def update
    @event = Event.find_by(params[:id])
    if @event.update(event_params)
       redirect_to events_path
    else
       render :index
    end
  end

  def destroy
    @event = Event.find_by(params[:id])
    @event.destroy
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:title, :body, :start_time, :admin_id)
  end

    # 以下はfullcalendar用の記述

    # def index
    #   @event = Event.new
    #   @events = Event.all
    #   @admin = Admin.find_by(params[:id])

    #   respond_to do |format|
    #     format.html
    #     format.json { render json: @events }
    #   end
    # end

    # def create
    #   @event = Event.new(event_params)
    #   @event.admin_id = current_admin.id
    #   if @event.save!
    #     flash[:success] = 'Save completed!'
    #     redirect_to events_path
    #   else
    #     flash.now[:danger] = 'Save failed!'
    #     render :index
    #   end
    # end

    # def update
    #   @event = Event.find(params[:id])
    #   if @event.update(event_params)
    #     flash[:success] = 'Save completed!'
    #     redirect_to events_path
    #   else
    #     flash.now[:danger] = 'Save failed!'
    #     render :index
    #   end
    # end

    # def destroy
    #   @event = Event.find(params[:id])
    #   @event.destroy
    #   flash[:success] = 'Deletion completed!'
    #   redirect_to events_path
    # end

    # private

    # def event_params
    #   params.require(:event).permit(:title, :body, :start, :end, :admin_id)
    # end

end