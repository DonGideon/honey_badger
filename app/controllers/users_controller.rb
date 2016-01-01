class UsersController < ApplicationController
	skip_before_filter :verify_authenticity_token, :only => [:can_create]
	def sign_in
	end

	def can_create
		name =  params["name"]
		success = false 
		if name
			user = User.find_or_create_by(name: params["name"])
			cookies[:twitter_user_id] = user.id
			success = true
		end
		render json: {success: success, url: twitter_tomato_url}
	end

	def log_out
		cookies.delete :twitter_user_id
		redirect_to users_sign_in_path
	end
end
