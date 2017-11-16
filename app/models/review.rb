class Review < ApplicationRecord
  validates :score, :description, presence: true
  belongs_to :van
  mount_uploader :photo, PhotoUploader
end
