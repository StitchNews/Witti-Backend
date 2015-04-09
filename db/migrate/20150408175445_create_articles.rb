class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :text
      t.string :url
      t.string :author
      t.string :date
      t.string :tags

      t.timestamps null: false
    end
  end
end
