class Topic < ActiveRecord::Base
	has_many :users, :through => :topic_users
	has_many :articles, :through => :topic_articles
	has_many :highlights, :through => :topic_highlights
	has_many :topic_users, :class_name => 'TopicUser'
	has_many :topic_highlights, :class_name => 'TopicHighlight'
	has_many :topic_articles, :class_name => 'TopicArticle'

	validates :name, :presence => true, :uniqueness => true, :case_sensitive => false

end
