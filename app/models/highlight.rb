class Highlight < ActiveRecord::Base
	belongs_to :articles
	belongs_to :users, :dependent => :destroy
	validates :article_url, :presence => true
	validates :text, :presence => true
end
