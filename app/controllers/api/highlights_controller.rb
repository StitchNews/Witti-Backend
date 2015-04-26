class Api::HighlightsController < ApplicationController
	def create
		collections = params[:highlight][:collection_ids]
		collections.each do |collection_id|
			dict = params[:highlight] 
			new_highlight = Highlight.new()
			new_highlight.text = dict[:text]
			new_highlight.article_id = dict[:article_id]
			new_highlight.article_url = dict[:article_url]
			new_highlight.user_id = dict[:user_id]
			new_highlight.collection_id = collection_id
			if new_highlight.save
				relationship = CollectionHighlight.new
				relationship.collection_id = collection_id
				relationship.highlight_id = new_highlight.id
				relationship.save
			else
				render status: 200, json: {
					errors: new_highlight.errors
				}.to_json
				return 
			end	
		end 
			render status: 200, json: {
				status: 200,
				message:"Successfully Added Highlight to Collections"
			}.to_json
			return


	end 


	private
		def highlight_params
			params.require("highlight").permit(:text,:article_id,:user_id, :article_url, :collection_id)
		end

end
