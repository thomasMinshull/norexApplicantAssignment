class StatusUpdatesControllerController < ApplicationController
  
  before_action :confirm_logged_in, :except => [:logout]

  def index
    # To Do Pragination to make this more managable
    @new_status = StatusUpdate.new
    @status_list = StatusUpdate.order('created_at ASC')
  	render('index')
  end

  def create

    status_update = StatusUpdate.new
    status_update.users_id = current_user.id
    status_update.status = status_params
    status_update.save
    redirect_to( :action => 'index' )
  end

  def edit
    
  end

  def logout 
    #mark user as logged out
    session[:user_id] = nil 
    session[:user_name] = nil
    flash[:notice] = "logged out"
    redirect_to(:action => "index")

  end

  
private 

  def current_user
   User.find(session[:user_id])
  end

  def status_params
  	params.require(:status_update).permit(:status)
  end
end



