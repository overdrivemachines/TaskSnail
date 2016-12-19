class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception

	# Override the default method
	def authenticate_user!(*args)
		current_user.present? || super(*args)
	end

	# Override the default method
	# define our unregistered visitors, or Soft Users

	def current_user
		super || User.where(soft_token: soft_token).first_or_initialize
	end

	private

	def soft_token
	  session[:user_token] ||= SecureRandom.hex(8)
	end
end
