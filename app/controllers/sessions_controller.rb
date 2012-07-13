
class SessionsController < ApplicationController
  def new
    #don't need to do anything here, it will render /sessions/new.html.erb by default
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if (user && user.authenticate(params[:session][:password]))
      flash[:success] = "Welcome " + user.email
      sign_in user
      redirect_to root_path
    else
      flash[:error] = "Invalid user/password combination"
      render "new"
    end
  end

  def destroy
    sign_out
  end
end
