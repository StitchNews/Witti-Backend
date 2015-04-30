class Article < ActiveRecord::Base
	has_many :highlights
	has_many :tags
	has_many :images
	has_many :topic_articles, :class_name => 'TopicArticle'
	has_many :topics, :through => :topic_articles

	validates :url, :presence => true, uniqueness: true
	validates :title, :presence => true
end
