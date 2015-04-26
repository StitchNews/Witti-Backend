class CreateCollectionHighlights < ActiveRecord::Migration
  def change
    create_table :collection_highlights do |t|
      t.integer :collection_id
      t.integer :highlight_id

      t.timestamps null: false
    end
  end
end
