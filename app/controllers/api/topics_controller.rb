class Api::TopicsController < Api::ApiController
	def create_topics
		text = params[:text]
		keywords = parse_string(text)
		keywords.each do |word|
			topic = Topic.new
			topic.name = word
			if topic.name.capitalize == topic.name
				topic.is_proper_noun = true
			else
				topic.is_proper_noun = false
			end 
			topic.save
		end 

		render status: 200, json: {
	        message:"Topics Uploaded Successfully",
	        topics: keywords
      	}.to_json

	end 

	def show
		topic = Topic.find_by(id:params[:id])
		result = render_topic_json(topic)
		render status: 200, json: {
	        message:"Found Topic",
	        status: 200,
	        response: result
	        
	      }.to_json
	end 

	def get_users
		topic = Topic.find_by(id:params[:id])
		users = topic.users
		render status: 200, json: {
	        message:"Found Users",
	        status: 200,
	        response: topic
	        
	      }.to_json(:include => { :topic_users => { :only => [:user_id,:score, :user_name] }})
	end

	def search
		search_string = "%" + params[:search] + "%"
	    topics = Topic.all
	    result = topics.where('name LIKE ?',search_string)
	    render status: 200, json: {
	          message:"Successfully Found Topics",
	          status: 200,
	          response: result
	     }.to_json(:include => { :topic_users => { :only => [:user_id,:score, :user_name] }})
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
    	def render_topic_json(topic)
    		hash = topic.attributes
    		hash["highlights"] = topic.highlights.condensed
    		hash["articles"] = topic.articles.condensed
    		hash["users"] = topic.topic_users.condensed

    		return hash

    	end 


end
