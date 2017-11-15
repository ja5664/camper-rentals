class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :van
  validates :start_date, :end_date, presence: true
  # validates :start_date, :end_date, :price, :status, :photo, presence: true

  mount_uploader :photo, PhotoUploader
end

