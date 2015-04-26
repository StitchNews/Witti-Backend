class AddAuthorToHighlight < ActiveRecord::Migration
  def change
  	add_column :highlights, :author, :string
  end
end
