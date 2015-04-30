class TopicHighlight < ActiveRecord::Base
	belongs_to :highlight
	belongs_to :topic
end
