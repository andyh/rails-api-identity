class UsersController < ApplicationController
  include ActionController::MimeResponds

  respond_to :json

  def index
    respond_with User.all
  end

  def create
    @user = User.build(params[:user])
	@user.save
    respond_with @user
  end

  def authenticate
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      render :json => user.token
    else
      render :json => "Authentication failed", :status => 401
    end
  end

end
