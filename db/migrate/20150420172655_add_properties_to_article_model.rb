class AddPropertiesToArticleModel < ActiveRecord::Migration
  def change
  	add_column :articles, :html, :text
  	add_column :articles, :date_published, :datetime
  	remove_column :articles, :tags
  end
end
