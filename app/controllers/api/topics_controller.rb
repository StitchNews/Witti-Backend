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


end
