class AddPasswordDigestToUser < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :password, :password_digest
    add_column :users, :recovery_password_digest, :string
  end
end
