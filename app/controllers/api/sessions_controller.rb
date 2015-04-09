class Api::SessionsController < Api::ApiController
	skip_before_filter :authenticate_user_from_token!, :only => :create #skip checking token when creating signing in

	def create
    	inputted_password = params[:session][:password]
    	user_email = params[:session][:email]
    	user = user_email.present? && User.find_by(email: user_email)
	    if user.salt && BCrypt::Engine.hash_secret(inputted_password, user.salt) == user.encrypted_password
	    	render status: 200, json: {
		        message:"Successfully Logged In",
		        response: {
		          name: user.name,
		          email: user.email,
		          id: user.id,
		          authentication_token: user.authentication_token
		        }
		        
		      }.to_json
	    else
	    	render json: { errors: "Invalid email or password" }, status: 422
	    end
  	end

end
