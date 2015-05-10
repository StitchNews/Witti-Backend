class Api::ArticlesController < Api::ApiController
	def index 
		render json: Article.all
	end 

	def create 
		new_article = Article.new(article_params)
		tags = params["article"]["tags"]
		images = params["article"]["images"]
		if new_article.save 
			if !tags
				tags = []
			end 
			if !images
				images = []
			end 
			tags.each do |tag_name|
				tag = Tag.new
				tag.name = tag_name
				tag.article_id = new_article.id
				tag.save
			end 
			images.each do |image|
				new_image = Image.new
				new_image.url = image["url"]
				new_image.title = image["title"]
				new_image.article_id = new_article.id
				new_image.save
			end 

			render status: 200, json: {
				message:"Success",
				response: new_article,
				tags: new_article.tags.as_json(:only => [:name]),
				images: new_article.images.as_json(:only => [:title,:url])
			}.to_json
		else 
			old_article = Article.where(url:params["article"]["url"]).first
			if old_article 
				render status: 200, json: {
					message:"Found Old Article",
					response: old_article,
					tags: old_article.tags.as_json(:only => [:name]),
					images: old_article.images.as_json(:only => [:title,:url])
				}.to_json

			else 
				render status: 500, json: {
					errors: old_article.errors
				}.to_json
			end 
		end
	end 

	def show
		article = Article.find_by_id(params[:id])
		if article 
			render status: 200, json: {
				message:"Retrieved Article",
				response: article,
			}.to_json( :include => [
				{:highlights => { :only => [:id, :text,:user_name, :user_id] }},
				{:topics => { :only => [:id, :name] }},
				{:tags => { :only => [:name] }},
				{:images => { :only => [:title, :url] }}
			])
		else 
			render status: 500 , json: {
				message:"Article Doesn't Exist",
				response: []
			}.to_json

		end 
	end 

	def show_article_highlights
		article = Article.find_by_id(params[:id])
		if article 
			highlights = article.highlights
			render status: 200, json: {
				message:"Retrieved Highlights",
				response: highlights,
			}.to_json
		else 
			render status: 500 , json: {
				message:"Article Doesn't Exist",
				response: []
			}.to_json

		end 
	end 

	def get_article_topics 
		article = Article.find_by_id(params[:id])
		if article
	      topics = article.topics
	      result = render_topics_json(topics)
	      render status: 200, json: {
	        message:"Retrieved Topics",
	        response: result,
	      }.to_json
	    else 
	      render status: 500 , json: {
	        message:"Article Doesn't Exist",
	        response: []
	      }.to_json
	    end 
	end 


	private

		def article_params 
			params.require("article").permit(:title,:url,:author, :date_published,  :text, :html)
		end 

		def render_topics_json(topics)
	      result = Array.new
	      topics.each do |topic|
	        dict = {name:topic.name,id:topic.id, created_at:topic.created_at}
	        result.push dict
	      end 
	      return result
	    end 
		
end
