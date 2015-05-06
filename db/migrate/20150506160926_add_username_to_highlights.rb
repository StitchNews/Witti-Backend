class AddUsernameToHighlights < ActiveRecord::Migration
  def change
  	add_column :highlights, :user_name, :string
  end
end
