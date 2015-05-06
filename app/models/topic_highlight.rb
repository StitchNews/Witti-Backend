class TopicHighlight < ActiveRecord::Base
	belongs_to :topic
	belongs_to :highlight
	validates :topic_id, :uniqueness => {:scope => [:highlight_id]}
end
