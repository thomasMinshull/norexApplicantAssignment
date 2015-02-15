class StatusUpdate < ActiveRecord::Base
	belongs_to :user

	validates_presence_of :status
	validates_length_of :status, :maximum => 500
end
