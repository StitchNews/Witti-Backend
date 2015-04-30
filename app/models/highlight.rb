class Highlight < ActiveRecord::Base
	belongs_to :articles
	belongs_to :users, :dependent => :destroy

	has_many :collection_highlights, :class_name => 'CollectionHighlight'
	has_many :collections, :through => :collection_highlights

	has_many :topic_highlights, :class_name => 'TopicHighlight'
	has_many :topics, :through => :topic_highlights

	validates :article_url, :presence => true
	validates :text, :presence => true
	#validates :collection_id, :presence => true
end
