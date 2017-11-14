class Review < ApplicationRecord
  validates :score, :description, :photo, presence: true
end
