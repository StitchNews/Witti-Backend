class TopicUser < ActiveRecord::Base
	belongs_to :topic
	belongs_to :user
	validates :topic_id, :uniqueness => {:scope => [:user_id]}

#	after_validation :update_score, :unless => lambda { errors.empty? }	#update score if relationship already exists


end
