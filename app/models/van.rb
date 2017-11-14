class Van < ApplicationRecord
  belongs_to :user
  validates :location, :description, :photo, :make, :model, :bed, :sleep, :bathroom, :kitchen, :price, presence: true
end

