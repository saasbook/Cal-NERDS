class StaticController < ApplicationController
	before_action :set_current_user

  def index
  end

  # private
  # 	def set_current_user
  # 		if !session[:user_id].nil?
	 #  		@current_user ||= User.find(session[:user_id])
	 #  	end
  # 	end
end
