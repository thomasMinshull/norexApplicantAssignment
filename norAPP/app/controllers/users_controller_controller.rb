class UsersControllerController < ApplicationController

	def index 
	@user = User.new

	end

	def attempt_login
		if params[:user][:user_name].present? && params[:user][:password].present?
			found_user = User.where(:user_name => params[:user_name]).first
			params.inspect
			if found_user
				authorized_user = found_user.authenticate(params[:password])
				
				if authorized_user
				# mark user as logged in
				session[:user_id] = @user.id 
				session[:user_name] = @user.username
				redirect_to(:controller => 'status_updates', :action => 'index')
				end
			end
		end
		
		flash[:notice] = "Invalid username and / or password."
				redirect_to(:action => 'index')
	end	

	def sign_up

		@user = User.new(user_params) 
		if @user.save
			# mark user as logged in
			session[:user_id] = @user.id #will this access the ID from the DB? 
			session[:user_name] = @user.user_name # will this work??
				
			redirect_to(:controller => 'status_updates_controller', :action => 'index')
		elsif
			render(:action => 'index') #should this be redirect or render?? 
		end
	end

private 

	def user_params
		params.require(:user).permit(:user_name, :email, :confirm_email, :password, :password_confirmation)
	end
end
