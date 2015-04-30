class Topic < ActiveRecord::Base
	has_many :users, :through => :topic_users
	has_many :articles, :through => :topic_relationships
	has_many :highlights, :through => :topic_relationships
	has_many :topic_relationships, :class_name => 'TopicRelationship'
	has_many :topic_users, :class_name => 'TopicUser'
	has_many :topics, :through => :topic_relationships

	validates :name, :presence => true, :uniqueness => true, :case_sensitive => false

end
