class TopicRelationship < ActiveRecord::Base
	belongs_to :highlight
	belongs_to :user
	belongs_to :article
	belongs_to :topic
	validates :topic_id, :uniqueness => {:scope => [:article_id, :user_id]}
end
