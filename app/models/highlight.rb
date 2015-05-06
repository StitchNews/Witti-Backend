class Highlight < ActiveRecord::Base
	belongs_to :articles
	belongs_to :users, :dependent => :destroy

	has_many :collection_highlights, :class_name => 'CollectionHighlight'
	has_many :collections, :through => :collection_highlights

	has_many :topic_relationships, :class_name => 'TopicRelationship'
	has_many :topics, :through => :topic_relationships

	validates :article_url, :presence => true
	validates :text, :presence => true

	scope :most_recent, -> { order(created_at: :desc).limit(10) }
	
	#validates :collection_id, :presence => true
end
