class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash.now.alert = "Either email or password just isn\'t cutting it.  Want to try again?"
      render "new"
    end
  end
  
  def destroy
    reset_session
    redirect_to root_url
  end
end