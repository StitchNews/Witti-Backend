class CreateTopicUsers < ActiveRecord::Migration
  def change
    create_table :topic_users do |t|
      t.integer :user_id
      t.integer :topic_id
      t.integer :score

      t.timestamps null: false
    end
    remove_column :topic_relationships, :user_id

  end
end
