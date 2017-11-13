class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :score
      t.text :description
      t.string :photo

      t.timestamps
    end
  end
end
