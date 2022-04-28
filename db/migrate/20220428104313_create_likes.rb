class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :target_id
      t.string :emoji
      t.string :target_type

      t.timestamps
    end
  end
end
