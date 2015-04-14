class Api::HighlightsController < ApplicationController
	def create
		new_highlight = Highlight.new(highlight_params)
		if new_highlight.save 
			render status: 200, json: {
				message:"Success",
				response: new_highlight,
			}.to_json
		else 
			render status: 200, json: {
				errors: new_highlight.errors
			}.to_json
		end
	end 


	private
		def highlight_params
			params.require("highlight").permit(:text,:article_id,:user_id, :article_url, :collection_id)
		end

end
