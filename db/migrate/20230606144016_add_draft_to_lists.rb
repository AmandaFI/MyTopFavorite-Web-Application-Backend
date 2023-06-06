class AddDraftToLists < ActiveRecord::Migration[7.0]
  def change
    add_column :lists, :draft, :boolean, default: true, null: false
  end
end
