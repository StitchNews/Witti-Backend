class AddCollectionIdToHighlight < ActiveRecord::Migration
  def change
  	add_column :highlights, :collection_id, :integer
  end
end
