class Article < ActiveRecord::Base
	has_many :highlights
	has_many :tags
	has_many :images
	has_many :topic_articles, :class_name => 'TopicArticle'
	has_many :topics, :through => :topic_articles

	validates :url, :presence => true, uniqueness: true
	validates :title, :presence => true

	scope :most_recent, -> { order(created_at: :desc).limit(10) }
	scope :condensed, -> { order(created_at: :desc).select([:id,:author,:title,:url]).limit(10) }
	
end
