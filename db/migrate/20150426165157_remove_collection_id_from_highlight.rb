class RemoveCollectionIdFromHighlight < ActiveRecord::Migration
  def change
  	remove_column :highlights, :collection_id
  end
end
