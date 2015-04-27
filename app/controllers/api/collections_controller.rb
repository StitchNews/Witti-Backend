class Api::CollectionsController < ApplicationController
	def create
		collection = Collection.new(collection_params)
		if collection.save
			render status: 200, json: {
		        message:"New Collection Created",
		        response: {
		          name: collection.name,
		          id: collection.id
		        }
		        
		    }.to_json
		else 
			render status: 500, json: {
        		errors: collection.errors
      		}.to_json
		end 
	end 
	#update name
	def update
		collection = Collection.find_by_id(params[:id])
		if collection 
			if collection.update_attributes(collection_params)
				render status: 200, json: {
			        message:"Collection Updated",
			        response: {
			          name: collection.name,
			          id: collection.id
			        }
			        
			    }.to_json
			else 
				render status: 500, json: {
	        		errors: collection.errors
	      		}.to_json
			end 
		else 
			render status: 500, json: {
		        message:"Collection Not Found",
		    }.to_json
		end 
	end 

	def destroy
		collection = Collection.find_by_id(params[:id])
		if collection.destroy
			render status: 200, json: {
		        message:"Collection Destroyed",
		    }.to_json
		else 
			render status: 500, json: {
		        message:"Collection Not Found",
		    }.to_json
		end 

	end 

	def show
		collection = Collection.find_by_id(params[:id])
		if collection
			render status: 200, json: {
				status: 200,
		        message:"Found Collection",
		        response: collection
		    }.to_json(:include => :highlights)
		else
			render status: 500 , json: {
		        message:"Collection Doesn't Exist",
		        response: []
		      }.to_json

		end 
	end 

	def get_collection_highlights 
		collection = Collection.find_by_id(params[:id])
		if collection
			render status: 200, json: {
		        message:"Found Collection",
		        response: collection.highlights
		    }.to_json
		else
			render status: 500 , json: {
		        message:"Collection Doesn't Exist",
		        response: []
		      }.to_json

		end 
	end 


	private

		def collection_params
			params.require("collection").permit(:name,:user_id)
		end 

end
