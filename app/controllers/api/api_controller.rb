module Api #what this module will be called
	class ApiController < ApplicationController 
		before_filter :authenticate_user_from_token!
		respond_to :json

		def authenticate_user_from_token!
		    user_auth_token = request.headers["API-TOKEN"].presence	#this will require tokens on headers
		    user = User.where(authentication_token: user_auth_token).first
		    if user && Devise.secure_compare(user.authentication_token, user_auth_token)
		      @current_user = user
		    else 
		    	render status: 500, json: {
        			errors: "Invalid Token"
      			}.to_json

		    end
		
		end 
	end 
end 
