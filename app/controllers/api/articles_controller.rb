class Api::ArticlesController < Api::ApiController
	def index 
		render json: Article.all
	end 

	def create 
		new_article = Article.new(article_params)
		if new_article.save 
			render status: 200, json: {
				message:"Success",
				response: new_article,
			}.to_json
		else 
			render status: 500, json: {
				errors: new_article.errors
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
				message:"User Doesn't Exist",
				response: []
			}.to_json

		end 
	end 


	private

		def article_params 
			params.require("article").permit(:title,:url)
		end 
		
end
