class User < ActiveRecord::Base
	has_secure_pasword
	has_many :status_updates

end
