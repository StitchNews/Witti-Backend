class Highlight < ActiveRecord::Base
	belongs_to :articles
	belongs_to :users, :dependent => :destroy
	belongs_to :collections
	validates :article_url, :presence => true
	validates :text, :presence => true
	validates :collection_id, :presence => true
end
