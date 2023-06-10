class AddCreatedAtIndexToLists < ActiveRecord::Migration[7.0]
  def change
    add_index :lists, :created_at
  end
end
