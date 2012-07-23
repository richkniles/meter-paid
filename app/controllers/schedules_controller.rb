class SchedulesController < ApplicationController

  include SchedulesHelper

  before_filter :signed_in_user
  skip_before_filter :signed_in_user, only: :tickle

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

  def tickle
    Schedule.where("status = #{Schedule::PENDING} and time < ?", Time.zone.now).each do |schedule|
      if (schedule)
        call_meter_company(schedule)
        schedule.status = Schedule::COMPLETED_SUCCESSFULLY
        schedule.save :validate => false
        Rails.logger.info "Scheduled #{schedule.time} minutes on meter ##{schedule.meter} at #{schedule.time}.\n"
      end
    end
    render nothing: true
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
    if (@schedule.update_attributes(params[:schedule]))
      flash[:success] = "Scheduled feed updated."
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    schedule = Schedule.find(params[:id])
    schedule.destroy
    flash[:success] = "Scheduled feed canceled"
    redirect_to root_path
  end
  
  
end
