class Article < ActiveRecord::Base
	has_many :highlights
	has_many :tags
	has_many :images
	has_many :topic_relationships, :class_name => 'TopicRelationship'
	has_many :topics, :through => :topic_relationships

	validates :url, :presence => true, uniqueness: true
	validates :title, :presence => true

	scope :most_recent, -> { order(created_at: :desc).limit(10) }
	scope :condensed, -> { order(created_at: :desc).select([:id,:author,:title,:url]).limit(10) }
	
end
