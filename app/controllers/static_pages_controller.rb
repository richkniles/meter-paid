class StaticPagesController < ApplicationController
  

  def home
    @upcoming_schedules = current_user.upcoming_schedules if signed_in?
  end

  def help
  end

  def about
  end
end
