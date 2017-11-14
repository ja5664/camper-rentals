class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :van
  validates :rental, :location, :description, :photo, :make, :model, :bed, :sleep, :bathroom, :kitchen, :price, presence: true
end
