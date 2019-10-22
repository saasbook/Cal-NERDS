class SessionsController < ApplicationController
  def create
    @auth = env["omniauth.auth"]
    @user = User.from_omniauth(@auth)
    session[:user_id] = @user.id
    redirect_to root_path
  end
end
