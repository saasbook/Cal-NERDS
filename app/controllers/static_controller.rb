class StaticController < ApplicationController
  def index
  end

  private
  	def set_current_user
  		@current_user ||= User.find(session[:user_id])
  	end
end
