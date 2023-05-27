class CreateListItems < ActiveRecord::Migration[7.0]
  def change
    create_table :list_items do |t|
      t.references :list, null: false, foreign_key: { on_delete: :cascade }
      t.string :external_api_identifier, null: false
      t.string :title, null: false
      t.integer :rank, null: false
      t.string :user_comment

      t.json :metadata

      t.timestamps
    end
  end
end
