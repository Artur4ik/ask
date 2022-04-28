class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.text :body
      t.boolean :solved, default: false
      t.integer :user_id, index = true

      t.timestamps
    end
  end
end
