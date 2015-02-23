class User < ActiveRecord::Base
	has_secure_password
	has_many :updates

    attr_accessor :password_confirmation, :confirm_email

    # note validates pressnce of password automatically handled by has_secure_password
	validates :user_name, :email, :confirm_email, :password_confirmation, presence: true

	validates :user_name, uniqueness: true
	validates :email, uniqueness: { case_sensitive: false }

	validates :email, :password, confirmation: true

	validates :email, format: { with: /\A[A-Z0-9._%+-]+@[a-z9-9.-]+\.[a-z]{2,4}\Z/i, message: "invalid email"}
	
	validates :email, length: {maximum: 100}
	validates :user_name, length: {in: 5..25}

end
