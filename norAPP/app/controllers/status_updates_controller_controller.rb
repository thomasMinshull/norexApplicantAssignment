class StatusUpdatesControllerController < ApplicationController
  
  def index
  	render('index')
  	#set to get all statuses in order they were created
  	# later look into Pragination to make this more managable
  	@status_updates = StatusUpdate.order('created_at ASC')

  end

  def create
  	#Instanitate a new object using form parammeters
  	#@status = SubjectUpdate.new(status_params])
  	#save the object
  	if @status.save
  	#If save succes, prepend @status to Statusses, & redirect to index 
  		# @statuses.insert(0,@status)
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

  def status_params
  	params.require(:status).permit(:status)
  end

end
