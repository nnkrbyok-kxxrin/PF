class EventsController < ApplicationController

  # 以下はsimple_calendar用の記述

  def index
    @event = Event.new
    # @events = Event.all
    # ログインしている人に基づくものしか表示させないため、上記を下記に変更
    @event = current_admin.events.all
  end

  def create
    @event = Event.new(event_params)
    @event.admin_id = current_admin.id
    if @event.save
       redirect_to events_path
    else
       @events = Event.all
       render :index
    end
  end

  def show
    # @event = Event.find(params[:id])
    # ログインしている人に基づくものしか表示させないため、上記を下記に変更
    @event = current_admin.events.find(params[:id])
  end

  def update
    # @event = Event.find(params[:id])
    # ログインしている人に基づくものしか表示させないため、上記を下記に変更
    @event = current_admin.events.find(params[:id])
    if @event.update(event_params)
       redirect_to events_path
    else
       @event.update(event_params)
       render :show
    end
  end

  def destroy
    # @event = Event.find(params[:id])
    # ログインしている人に基づくものしか表示させないため、上記を下記に変更
    @event = current_admin.events.find(params[:id])
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