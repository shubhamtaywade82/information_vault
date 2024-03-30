class CreateCredentialAttrs < ActiveRecord::Migration[5.0]
  def change
    create_table :credential_attrs do |t|
      # Will store the attribute name ex: email, password, urls, portnumbers, usernames, etc
      t.string :name
      # id of the user who added the attribute
      t.references :user, null: true

      t.timestamps
    end
  end
end
