class Van < ApplicationRecord
  belongs_to :user
  validates :location, :description, :make, :model, :bed, :sleep, :price, presence: true
end
