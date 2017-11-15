class Van < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  validates :location, :description, :photo, :make, :model, :bed, :sleep, :price, presence: true

  # Enables photo uploads
  mount_uploader :photo, PhotoUploader

  # Enables geocoder
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end

