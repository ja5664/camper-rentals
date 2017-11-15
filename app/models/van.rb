class Van < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy

  validates :location, :description, :photo, :make, :model, :bed, :sleep, :price, presence: true

  mount_uploader :photo, PhotoUploader
  # has_attachments :photos
end

