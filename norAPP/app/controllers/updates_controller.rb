class UpdatesController < ApplicationController
  
  before_action :confirm_logged_in, :except => [:logout]

  def index
    # To Do Pragination to make this more managable
    @new_status = Update.new
    @status_list = Update.order('created_at ASC')
  	render('index')
  end

  def create

    update = Update.new
    update.users_id = current_user.id
    update.status = update_params
    update.save
    redirect_to( :action => 'index' )
  end

  def edit
    
  end

  def logout 
    #mark user as logged out
    session[:user_id] = nil 
    session[:user_name] = nil
    flash[:notice] = "logged out"
    redirect_to(:controller => 'users', :action => "index")

  end

  
private 

  def current_user
   User.find(session[:user_id])
  end

  def update_params
  	params.require(:update).permit(:status)
  end
end



