class CollectionHighlight < ActiveRecord::Base
	belongs_to :highlight
	belongs_to :collection
end
