class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :url
      t.string :title
      t.float :width
      t.float :height
      t.integer :article_id
      t.timestamps null: false
    end
  end
end
