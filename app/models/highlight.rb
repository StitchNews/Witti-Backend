class Highlight < ActiveRecord::Base
	belongs_to :articles
	belongs_to :users, :dependent => :destroy
	has_many :collection_highlights, :class_name => 'CollectionHighlight'
	has_many :collections, :through => :collection_highlights
	validates :article_url, :presence => true
	validates :text, :presence => true
	#validates :collection_id, :presence => true
end
