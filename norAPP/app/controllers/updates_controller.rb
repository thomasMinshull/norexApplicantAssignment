class UpdatesController < ApplicationController
  
  before_action :confirm_logged_in, :except => [:logout]

  def index
    # To Do Pragination to make this more managable
    @update = Update.new
    
    #@update_list = Update.order('created_at ASC')
  end

  def create

    @update = Update.new(update_params)
    @update.users_id = current_user.id

    if @update.save
      # status update text area will be blank and this update will be added to @update_list
      redirect_to(:controller => 'updates', :action => 'index')
    else
      # status update text area will still contain last attempted update for editing
      render( :action => 'index' )
    end

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



