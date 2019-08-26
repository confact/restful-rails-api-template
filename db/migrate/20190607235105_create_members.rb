class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string :name
      t.integer :member_type, default: 1, null: false
      t.string :role
      t.integer :duration

      t.timestamps
    end
  end
end
