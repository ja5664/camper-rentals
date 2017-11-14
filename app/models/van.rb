class Van < ApplicationRecord
  belongs_to :user
  has_many :reviews

  validates :location, :availability, :description, :photo, :make, :model, :bed, :sleep, :bathroom, :kitchen, :price, presence: true
end

