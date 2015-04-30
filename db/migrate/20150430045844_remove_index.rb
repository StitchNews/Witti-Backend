class RemoveIndex < ActiveRecord::Migration
  def change
  	remove_index(:topic_relationships, :name => 'topic_relationship_uniqueness_index')
  end
end
