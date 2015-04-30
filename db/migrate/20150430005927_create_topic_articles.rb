class CreateTopicArticles < ActiveRecord::Migration
  def change
    create_table :topic_articles do |t|
      t.integer :topic_id
      t.integer :article_id

      t.timestamps null: false
    end
  end
end
