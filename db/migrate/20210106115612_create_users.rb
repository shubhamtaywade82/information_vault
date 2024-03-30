class CreateUsers < ActiveRecord::Migration[5.0]

  def change
    create_table :users do |t|
      # Database authenticable
      t.string :username, null: false
      t.string :email, null: false
      t.string :password_digest, null: false

      # Confirmations
      t.string :confirmation_token
      t.datetime :confirmed_at

      t.timestamps
    end
  end

end
