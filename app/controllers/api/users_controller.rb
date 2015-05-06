class Api::UsersController < Api::ApiController
  skip_before_filter :authenticate_user_from_token!, :only => :create #skip checking token when creating user

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
      render status: 404, json: {
        errors: new_user.errors
      }.to_json
    end
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
      render status: 404, json: {
        errors: "Can't Find User"
      }.to_json
    end 
  end 

  def get_user_highlights
    user = User.find_by(id: params[:id])
    if user 
      highlights = user.highlights
      render status: 200, json: {
        message:"Retrieved Highlights",
        response: highlights,
      }.to_json
    else 
      render status: 500 , json: {
        message:"User Doesn't Exist",
        response: []
      }.to_json
    end 
  end 

  def get_user_collections
    user = User.find_by(id: params[:id])
    if user 
      collections = user.collections
      render status: 200, json: {
        message:"Retrieved Collections",
        response: collections,
      }.to_json
    else 
      render status: 500 , json: {
        message:"User Doesn't Exist",
        response: []
      }.to_json
    end 
  end 

  def get_user_topics
    user = User.find_by(id:params[:id])
    if user 
      topics = user.topics
      result = render_topics_json(topics)
      render status: 200, json: {
        message:"Retrieved Collections",
        response: result,
      }.to_json
    else 
      render status: 500 , json: {
        message:"User Doesn't Exist",
        response: []
      }.to_json
    end 

  end 


  private

    def user_params 
      params.require("user").permit(:name,:password,:email)
    end 

    def render_topics_json(topics)
      result = Array.new
      topics.each do |topic|
        dict = {name:topic.name,id:topic.id, score: topic.topic_users.first.score, created_at:topic.created_at, updated_at:topic.updated_at}
        
        result.push dict
      end 
      return result
    end 


end
