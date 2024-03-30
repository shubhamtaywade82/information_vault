class CreateVaultItemAccesses < ActiveRecord::Migration[5.0]
  def change
    create_table :vault_item_accesses do |t|
      # refers the vault_items table (vault_item_id)
      t.references :vault_item, foreign_key: true
      # User#id to vault owner id
      t.references :granted_by, index: true, foreign_key: { to_table: :users }
      # User#id to whom access is provided
      t.references :accessor, index: true, foreign_key: { to_table: :users }
      # Expiry date and time of the access given to the user
      t.datetime :expire_at
      # to keep track of creation and updates of the access given to the user
      t.timestamps
    end
  end
end
