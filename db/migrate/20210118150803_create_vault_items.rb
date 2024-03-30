class CreateVaultItems < ActiveRecord::Migration[5.0]
  def change
    create_table :vault_items do |t|
      # Title of the vault item to be Stored
      t.string :title, null: false
      # refers the users table (owner of he vault_item)
      t.references :user, foreign_key: true
      # refers the vault_item_type enumerator key
      t.integer :item_type, null: false
      # to keep track of creation and updates of the vault items
      t.timestamps
    end
  end
end
