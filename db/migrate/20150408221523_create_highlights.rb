class CreateHighlights < ActiveRecord::Migration
  def change
    create_table :highlights do |t|
      t.string :article_url
      t.string :article_title
      t.string :text
      t.integer :user_id
      t.integer :article_id
      t.timestamps null: false
    end
  end
end
