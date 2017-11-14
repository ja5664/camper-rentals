class AddReferencesToReview < ActiveRecord::Migration[5.1]
  def change
    add_reference :reviews, :user, foreign_key: true
    add_reference :reviews, :van, foreign_key: true
  end
end
