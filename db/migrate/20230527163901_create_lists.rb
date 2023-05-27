class CreateLists < ActiveRecord::Migration[7.0]
  def change
    create_table :lists do |t|
      t.string :title, null: false, limit: 128
      t.integer :likes_count, null: false, default: 0
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.references :category, null: false, foreign_key: { on_delete: :restrict } 

      t.timestamps
    end
  end
end
