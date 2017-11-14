class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :van
  belongs_to :review

  validates :start_date, :end_date, :photo, :price, :status, presence: true
end
