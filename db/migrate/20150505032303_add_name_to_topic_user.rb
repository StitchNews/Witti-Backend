class AddNameToTopicUser < ActiveRecord::Migration
  def change
  	add_column :topic_users, :user_name, :string
  end
end
