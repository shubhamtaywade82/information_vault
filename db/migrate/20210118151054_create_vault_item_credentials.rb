class CreateVaultItemCredentials < ActiveRecord::Migration[5.0]
  def change
    create_table :vault_item_credentials do |t|
      # refers to the vault_item => vault_item_id
      t.references :vault_item, foreign_key: true
      # refers vault_item_credentials attributes => credential_attr_id
      t.references :credential_attr, foreign_key: true
      # Will be in encrypted form
      # The credentials to store in the table
      t.string :value, null: false
      # to keep track of creation and updates of the value
      t.timestamps
    end
  end
end
