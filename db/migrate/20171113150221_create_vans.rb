class CreateVans < ActiveRecord::Migration[5.1]
  def change
    create_table :vans do |t|
      t.references :user, foreign_key: true
      t.string :location
      t.boolean :availability
      t.text :description
      t.string :photo
      t.string :make
      t.string :model
      t.integer :bed
      t.integer :sleep
      t.boolean :bathroom
      t.boolean :kitchen
      t.integer :price

      t.timestamps
    end
  end
end
