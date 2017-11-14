class Review < ApplicationRecord
  validates :score, :description, presence: true
end
