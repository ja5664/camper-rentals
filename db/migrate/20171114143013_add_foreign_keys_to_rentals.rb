class AddForeignKeysToRentals < ActiveRecord::Migration[5.1]
  def change
    add_reference :rentals, :user, foreign_key: true, index: true
    add_reference :rentals, :van, foreign_key: true, index: true
  end
end
