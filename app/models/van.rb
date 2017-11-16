class Van < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :rentals
  validates :location, :description, :photo, :make, :model, :bed, :sleep, :price, presence: true

  # Enables photo uploads
  mount_uploader :photo, PhotoUploader

  # Enables geocoder
  geocoded_by :location
  after_validation :geocode, if: :location_changed?

  include PgSearch
  pg_search_scope :global_search,
    against: [ :location ],
    associated_against: {
      rentals: [ :start_date, :end_date ]
    }

end

