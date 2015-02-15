class StatusUpdatesControllerController < ApplicationController
  
  before_action #:confirm_logged_in, :except => [:logout]

  def index
    #set to get all statuses in order they were created
    # later look into Pragination to make this more managable
    StatusUpdate.new
    @status_updates = StatusUpdate.order('created_at ASC')
  	render('index')
  end

  def create
  	#Instanitate a new object using form parammeters
  	@status = SubjectUpdate.new(status_params) #do I have to worry about SQL injection here??
  	#save the object
  	if @status.save
  	#If save succes, prepend @status to Statusses, & redirect to index 
  		@statuses.insert(0,@status)
  		redirect_to(:action => 'index')
  	#If save fails, redisplay the form so user can fix problems
  	else
  	# this needs to updated database then render('index') which will pull
  	# from the data base again but this time it will include the new 
  	# status update
  	redirect_to action: 'index'
  	end
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


  def status_params
  	params.require(:new_status).permit(:new_status)
  end
end