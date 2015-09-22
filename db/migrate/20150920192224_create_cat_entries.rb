class CreateCatEntries < ActiveRecord::Migration
  def change
    create_table :cat_entries do |t|
      t.integer :user_id, :null => false
      t.string :breed, :null => false
      t.string :color, :null => false
      t.string :longitude, :null => false
      t.string :latitude, :null => false
      t.string :contact_phone, :null => false
      t.string :contact_email, :null => false
      t.date :event_date, :null => false
      t.string :entry_type, :null => false
      t.boolean :resolved
      t.string :chip
      t.text :photo_url, :null => false

      t.timestamps null: false
    end

    add_index :cat_entries, :user_id
    add_index :cat_entries, :event_date
    add_index :cat_entries, :entry_type
    add_index :cat_entries, :resolved
    add_index :cat_entries, :chip
  end
end
