class Van < ApplicationRecord
  belongs_to :user
  has_many :reviews

  validates :location, :description, :photo, :make, :model, :bed, :sleep, :price, presence: true
end

