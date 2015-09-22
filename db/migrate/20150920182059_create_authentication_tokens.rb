class CreateAuthenticationTokens < ActiveRecord::Migration
  def change
    create_table :authentication_tokens do |t|
      t.integer :user_id, :null => false
      t.string :token, :null => false
      t.datetime :expires_at, :null => false

      t.timestamps null: false
    end

    add_index :authentication_tokens, :token, :unique => true
    add_index :authentication_tokens, :user_id
    add_index :authentication_tokens, :expires_at
  end
end
