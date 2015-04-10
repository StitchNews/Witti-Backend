class Api::CategoriesController < ApplicationController

	def create
		category = Category.new(category_params)
		if category.save
			render status: 200, json: {
		        message:"New Category Created",
		        response: {
		          name: category.name,
		          id: category.id
		        }
		        
		    }.to_json
		else 
			render status: 500, json: {
        		errors: category.errors
      		}.to_json
		end 
	end 


	private

		def category_params
			params.require("category").permit(:name,:user_id)
		end 

end
