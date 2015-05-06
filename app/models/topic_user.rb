class TopicUser < ActiveRecord::Base
	belongs_to :topic
	belongs_to :user
	validates :topic_id, :uniqueness => {:scope => [:user_id]}

	scope :most_recent, -> { order(created_at: :desc).limit(10) }


end
