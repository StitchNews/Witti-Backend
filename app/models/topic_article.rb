class TopicArticle < ActiveRecord::Base
	belongs_to :topic
	belongs_to :article
	validates :topic_id, :uniqueness => {:scope => [:article_id]}
end
