class UpdatesController < ApplicationController

  before_action :confirm_logged_in, :except => [:logout]

  def index
    
    @new_update = Update.new 
    @updates = Update.order('created_at DESC')
    @current_user = current_user

  end

  def create

    @new_update = Update.new(update_params)
    @new_update.user_id = current_user.id

    if @new_update.save
      # redirect insures update text area will be blank and this update is added to update list
      redirect_to(:controller => 'updates', :action => 'index')
    else
      @current_user = current_user
      # used to populate @updates list in the render called directly bellow
      @updates = Update.order('created_at DESC')
      # render insures status update text area will still contain last attempt
      render( :action => 'index' ) 
    end
  end

  def edit
    @updates = Update.order('created_at DESC')
    @current_user = current_user

    @edit_update = Update.find(params[:data][:edited_update_id].to_i)
    # Prevents someone else editing the update by passing alternative 
    # paramaters by checking user id agains current user id originally 
    # confirmed in session data via login 
    if current_user.id == @edit_update.user_id
      render(:action => 'edit')
    else
      @new_update = Update.new 
      render(:action => 'index')
    end 
  end

  def update
    @edit_update = Update.find(params[:update][:id].to_i)
    
    #Prevents someone else form updating by passing in alternative params
    if current_user.id == @edit_update.user_id
      # satizes input so SQL injection isn't a concern
      @edit_update.status = update_params[:status] 
      if @edit_update.save
        redirect_to(:controller => 'updates', :action => 'index')
      else
        @current_user = current_user
        @updates = Update.order('created_at DESC')
        render('edit')
      end
    else 
      redirect_to('index')  
    end
  end

  def delete
    @edit_update = Update.find(params[:data][:edited_update_id].to_i)
    if current_user.id == @edit_update.user_id
      @edit_update.destroy
      redirect_to(:controller => 'updates', :action => 'index')
    else 
      redirect_to(:controller => 'updates', :action => 'index')
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



