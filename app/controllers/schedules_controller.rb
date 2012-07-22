class SchedulesController < ApplicationController

  include SchedulesHelper

  before_filter :signed_in_user
  skip_before_filter :signed_in_user, only: :show

  def new
    @schedule = current_user.schedules.new
    #@schedule.time = 10.minutes.from_now.getlocal
  end

  def create
    @schedule = current_user.schedules.build(params[:schedule])
    if @schedule.save     
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    render text: test_twilio_ml(params[:id])
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
    if (@schedule.update_attributes(params[:schedule]))
      flash[:success] = "Scheduled feed updated."
      redirect_to root_path
    end
    
  end

  def destroy
    schedule = Schedule.find(params[:id])
    schedule.destroy
    flash[:success] = "Scheduled feed canceled"
    redirect_to root_path
  end
  
  
end
