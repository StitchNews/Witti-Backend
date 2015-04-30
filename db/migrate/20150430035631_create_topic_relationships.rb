class CreateTopicRelationships < ActiveRecord::Migration
  def change
    create_table :topic_relationships do |t|
      t.integer :topic_id
      t.integer :user_id
      t.integer :highlight_id
      t.string :article_id

      t.timestamps null: false
    end
  end
end
