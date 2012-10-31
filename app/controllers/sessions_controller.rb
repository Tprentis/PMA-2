class SessionsController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
    @email = params[:session][:email]
    @password = params[:session][:password]
        
    @user = User.find_by_email(@email)

    if @user && @user.authenticate(@password)
      session[:user_id] = @user.id
      redirect_to root_url
    else 
      redirect_to login_url, alert: "Either email or password just isn\'t cutting it.  Want to try again?" if current_user.nil?
    end
    
  end
  
  def destroy
    reset_session
    redirect_to root_url
  end
end
