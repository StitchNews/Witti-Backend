class Article < ActiveRecord::Base
	has_many :highlights
	validates :url, :presence => true, uniqueness: true
	validates :title, :presence => true
end
