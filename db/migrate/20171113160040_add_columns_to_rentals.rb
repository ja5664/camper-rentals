class AddColumnsToRentals < ActiveRecord::Migration[5.1]
  def change
    add_column :rentals, :start_date, :datetime
    add_column :rentals, :end_date, :datetime
    add_column :rentals, :photo, :string
    add_column :rentals, :price, :integer
    add_column :rentals, :status, :string
  end
end
