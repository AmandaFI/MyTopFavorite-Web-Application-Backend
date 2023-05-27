class RemoveLikesCountFromLists < ActiveRecord::Migration[7.0]
  def change
    remove_column :lists, :likes_count
  end
end
