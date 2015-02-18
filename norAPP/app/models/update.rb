class Update < ActiveRecord::Base
	belongs_to :user

	validates :status, presence: true
	validates :status, length: {maximum: 500}
end
