class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
      t.boolean :is_proper_noun

      t.timestamps null: false
    end
  end
end
