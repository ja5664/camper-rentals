class ReviewController < ApplicationController
  before_action :set_van

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.van = @van
    if @review.save
      redirect_to van_path(@van)











end
