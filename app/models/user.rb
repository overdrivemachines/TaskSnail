class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :trackable, :validatable
	
	has_many :tasks, dependent: :destroy

	# Check is a user is either a "Soft User" or “Fully Registered” 
	# based on their email address.
	def soft_user?
		self.email.empty?
	end
end
