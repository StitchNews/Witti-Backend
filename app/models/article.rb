class Article < ActiveRecord::Base
	validates :url, :presence => true, uniqueness: true
	validates :title, :presence => true
end
