class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  	def set_current_user
  		begin
  			if !session[:user_id].nil?
		  		@current_user ||= User.find(session[:user_id])
		  	end
	  	rescue ActiveRecord::RecordNotFound
	  		@current_user = nil
	  		redirect_to root_path, notice: 'User not found.'
	  	end
  	end
end
