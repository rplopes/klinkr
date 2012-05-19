class CreateKlinks < ActiveRecord::Migration
  def change
    create_table :klinks do |t|
      t.integer :user_id
      t.text :description
      t.string :picture_uri
      t.string :latitude
      t.string :longitude
      t.string :country
      t.string :location

      t.timestamps
    end
    add_index :klinks, [:user_id, :created_at]
  end
end
