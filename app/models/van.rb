class Van < ApplicationRecord
  belongs_to :user
  has_many :reviews

  validates :location, :description, :make, :model, :bed, :sleep, :price, presence: true

  mount_uploader :photo, PhotoUploader
end

