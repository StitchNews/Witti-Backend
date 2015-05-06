class CreateTopicHighlights < ActiveRecord::Migration
  def change
    create_table :topic_highlights do |t|
      t.integer :highlight_id
      t.integer :topic_id

      t.timestamps null: false
    end
  end
end
