class Collection < ActiveRecord::Base
	belongs_to :users
	has_many :highlights
	validates :name, :presence => true
end
