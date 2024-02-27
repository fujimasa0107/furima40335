class CreateDestinations < ActiveRecord::Migration[7.0]
  def change
    create_table :destinations do |t|
      t.references :buyer, null: false, foreign_key: true
      t.string :postal_code, null: false
      t.integer :prefecture_id, null: false
      t.string :city, null: false
      t.string :address, null: false
      t.string :building
      t.string :phone_number, null: false
      
      t.timestamps
    end
  end
end
