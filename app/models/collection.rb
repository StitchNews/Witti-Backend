class Collection < ActiveRecord::Base
	belongs_to :users
	has_many :collection_highlights, :class_name => 'CollectionHighlight'
	has_many :highlights, :through => :collection_highlights
	validates :name, :presence => true
end
