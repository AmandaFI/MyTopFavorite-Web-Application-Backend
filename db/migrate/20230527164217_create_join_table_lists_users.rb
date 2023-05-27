class CreateJoinTableListsUsers < ActiveRecord::Migration[7.0]
  def change
    create_join_table :lists, :users do |t|
      t.index [:list_id, :user_id], unique: true
      t.index :user_id
    end

    add_foreign_key :lists_users, :lists
    add_foreign_key :lists_users, :users
  end
end
