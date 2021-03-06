class Api::HighlightsController < Api::ApiController
	def create
		
		dict = params[:highlight] 
		new_highlight = Highlight.new
		new_highlight.text = dict[:text]
		new_highlight.article_id = dict[:article_id]
		new_highlight.article_url = dict[:article_url]
		new_highlight.article_title = dict[:article_title]
		new_highlight.author = dict[:author]
		new_highlight.user_id = @current_user.id
		new_highlight.user_name = @current_user.name
		if new_highlight.save
			collections = dict[:collection_ids]
			if !(collections.nil?)
				collections.each do |collection_id|
					relationship = CollectionHighlight.new
					relationship.collection_id = collection_id
					relationship.highlight_id = new_highlight.id
					relationship.save
				end
			end 
			create_topics(new_highlight)
			render status: 200, json: {
				status: 200,
				message:"Successfully Added Highlight to Collections",
				response:new_highlight
			}.to_json(:include => { :collections => { :only => [:id, :name] }})
		else
			render status: 201, json: {
				status: 201,
				errors: new_highlight.errors
			}.to_json
			return 
				
		end 
	end 

	def show
		highlight = Highlight.find_by(params[:id])
		render status: 200, json: {
				status: 200,
				message:"Successfully Found Highlight",
				response:highlight
			}.to_json
	end 

	def create_topics(highlight)
		keywords = parse_string(highlight.text)
		keywords.each do |word|
			topic = Topic.new
			topic.name = word
			if topic.name.capitalize == topic.name
				topic.is_proper_noun = true
			else
				topic.is_proper_noun = false
			end 
			topic_id = -1
			if topic.save
				topic_id = topic.id
			else 
				old_topic = Topic.where(name:topic.name).first
				topic_id = old_topic.id
			end 
			
			topic_highlight = TopicHighlight.new
			topic_highlight.topic_id = topic_id
			topic_highlight.highlight_id = highlight.id
			topic_highlight.save

			topic_article = TopicArticle.new
			topic_article.topic_id = topic_id
			topic_article.article_id = highlight.article_id
			topic_article.save

			topic_user = TopicUser.new
			topic_user.user_id = @current_user.id
			topic_user.user_name = @current_user.name
			topic_user.topic_id = topic_id
			topic_user.score = 1
			if ! topic_user.save
				old_topic_user = TopicUser.where("user_id = ? AND topic_id = ?",@current_user.id , topic_id).first
				old_topic_user.increment!(:score, by = 1)
			end 

		end 
	end 

	def get_highlight_topics 
		highlight = Highlight.find_by_id(params[:id])
		if highlight
	      topics = highlight.topics
	      render status: 200, json: {
	        message:"Retrieved Topics",
	        response: topics,
	      }.to_json
	    else 
	      render status: 500 , json: {
	        message:"Highlight Doesn't Exist",
	        response: []
	      }.to_json
	    end 
	end 

	def parse_string(text)

		names = parse_names(text)
		tgr = EngTagger.new
		# Add part-of-speech tags to text
		tagged = tgr.add_tags(text)
		nouns = tgr.get_nouns(tagged).keys
		verbs1 = tgr.get_past_tense_verbs(tagged).keys
		verbs2 = tgr.get_infinitive_verbs(tagged).keys

		result = names + nouns + verbs1 + verbs2
		return result

	end 

	def parse_names(text)

		names = Array.new
		name_string = ""
		text.split.each_with_index {|word, index| 
			 if word.capitalize == word
			 	if name_string.length > 0
			 		name_string +=" "
			 	end 
			 	name_string += word
			 elsif name_string.length > 0
			 	names.push(name_string)
                name_string = ""
             else
			 	name_string = ""
			 end 
		}

		if name_string.length > 0
			names.push(name_string)
		end 
        
        return names
    end 


	private
		def highlight_params
			params.require("highlight").permit(:text,:article_id,:user_id, :article_url, :collection_id)
		end

end
