class DropTables < ActiveRecord::Migration
  def change
	  	drop_table :topic_users
		drop_table :topic_highlights
		drop_table :topic_articles
  end
end
