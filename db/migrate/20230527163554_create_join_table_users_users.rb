class CreateJoinTableUsersUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users_users, id: false do |t|      
      t.references :follower, foreign_key: { to_table: :users, on_delete: :cascade }, null: false, index: false
      t.references :followed, foreign_key: { to_table: :users, on_delete: :cascade }, null: false 
    
      t.index [:follower_id, :followed_id], unique: true
    end
  end
end
