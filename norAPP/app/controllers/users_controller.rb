class UsersController < ApplicationController

	def index 
	@user = User.new

	end

	def attempt_login
		@user = User.new(user_params) 
		if params[:user][:user_name].present? && params[:user][:password].present?
			found_user = User.where(:user_name => params[:user][:user_name]).first

			if found_user
				authorized_user = found_user.authenticate(params[:user][:password])
				if authorized_user
				# mark user as logged in
				session[:user_id] = authorized_user.id 
				session[:user_name] = authorized_user.user_name
				redirect_to(:controller => 'updates', :action => 'index')
				# insures we do not call final flash notice and final redirect
				return true 
				end
			end
		end
		# calls function in model which sets an "Invalid username and / or password." error
		@user.errors[:base] << "Invalid username and / or password."

		#flash[:notice] = "Invalid username and / or password."
		
		render(:action => 'index')
	end	

	def sign_up

		@user = User.new(user_params) 
		if @user.save
			# mark user as logged in
			session[:user_id] = @user.id #will this access the ID from the DB? 
			session[:user_name] = @user.user_name # will this work??
				
			redirect_to(:controller => 'updates', :action => 'index')
		elsif
			render(:action => 'index') 
		end
	end

private 

	def user_params
		params.require(:user).permit(:user_name, :email, :confirm_email, :password, :password_confirmation)
	end
end
