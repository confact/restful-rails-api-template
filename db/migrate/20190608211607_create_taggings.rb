class CreateTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :taggings do |t|
      t.integer :member_id
      t.integer :tag_id

      t.timestamps
    end
    add_index :taggings, :member_id
    add_index :taggings, :tag_id
  end
end
