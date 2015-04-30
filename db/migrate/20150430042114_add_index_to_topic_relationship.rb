class AddIndexToTopicRelationship < ActiveRecord::Migration
  def change
  	add_index :topic_relationships, [:topic_id, :highlight_id, :article_id, :user_id], :unique => true, :name => 'topic_relationship_uniqueness_index'
  end
end
