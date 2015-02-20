class UpdatesController < ApplicationController

  before_action :confirm_logged_in, :except => [:logout]

  def index
    # To Do Pragination to make this more managable
    @new_update = Update.new 
    # would be more efficient to use join with User table to reduce the # of queries for user_name in the partial
    @updates = Update.order('created_at DESC')
    @current_user = current_user

  end

  def create

    @new_update = Update.new(update_params)
    @new_update.user_id = current_user.id

    if @new_update.save
      # status update text area will be blank and this update will be added to @updates list
      redirect_to(:controller => 'updates', :action => 'index')
    else
      # used to populate @updates list in the render called directly bellow
      # would be more efficient to use join with User table to reduce the # of queries for user_name in the partial
      @current_user = current_user
      @updates = Update.order('created_at DESC')
      # status update text area will still contain last attempted update for editing
      render( :action => 'index' ) 
    end

  end

  def edit
    @updates = Update.order('created_at DESC')
    @current_user = current_user

    if current_user.id != params[:data][:edit_updated_user_id].to_i
      
      @edit_update = Update.find(params[:data][:edited_update_id].to_i)
      render(:action => 'edit')
    else
      @new_update = Update.new 
      render(:action => 'index')
    end 
  end

  def update
    @edit_update = Update.find(params[:update][:id])
    @edit_update.status = params[:update][:status] #This is suseptible to SQL injection must correct this 
    if @edit_update.save
      redirect_to(:controller => 'updates', :action => 'index')
    else
      @current_user = current_user
      @updates = Update.order('created_at DESC')
      render('edit')
    end
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



