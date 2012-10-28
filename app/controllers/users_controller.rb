class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Thank you for signing up!"
    else
      render "new"
    end
  end
  
  # app/controllers/contacts_controller.rb
  def validate
    if params[:field].blank? || params[:value].blank?
      render :nothing => true
    else
       @valid = User.validate_field(params[:field], params[:value])
       render :json => @valid
    end
  end
  
end
