class Article < ActiveRecord::Base
	has_many :highlights
	has_many :tags
	has_many :images
	validates :url, :presence => true, uniqueness: true
	validates :title, :presence => true
end
