class Api::UsersController < Api::ApiController
  skip_before_filter :authenticate_user_from_token!, :only => [:create, :sign_in]  #skip checking token when creating user

  def index 
    render json: User.all
  end 

  def create
    new_user = User.new(user_params)
    if new_user.save
      render status: 200, json: {
        message:"New User Created",
        response: {
          name: new_user.name,
          email: new_user.email,
          id: new_user.id,
          authentication_token: new_user.authentication_token
        }
        
      }.to_json
    else
      render status: 500, json: {
        errors: new_user.errors
      }.to_json
    end
  end

  def sign_in 
    @current_user = User.find()
  end 

  #get user by id
  def show 
    user = User.find_by(id: params[:id])
    if !user.blank?
      render status: 200, json: {
        message:"Found User",
        response: {
          name: user.name,
          email: user.email,
          id: user.id
        }
      }.to_json
    else 
      render status: 500, json: {
        errors: "Can't Find User"
      }.to_json
    end 

  end 


  private

    def user_params 
      params.require("user").permit(:name,:password,:email)
    end 


end
