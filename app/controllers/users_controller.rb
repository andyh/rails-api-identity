class UsersController < ApplicationController
  include ActionController::MimeResponds

  respond_to :json

  def index
    respond_with User.all
  end

  def create
    respond_with User.create(user_params)
  end
  end

  def authenticate
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      render :json => user.token
    else
      render :json => "Authentication failed", :status => 401
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
