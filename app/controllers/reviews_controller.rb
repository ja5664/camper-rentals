class ReviewsController < ApplicationController
  before_action :set_van, only: [:new, :create]

  def index
    @van = Van.find(params[:van_id])
    @reviews = policy_scope(@van.reviews).order(created_at: :desc)
  end

  def new
    @review = Review.new
    authorize @review
  end

  def create
    @review = Review.new(review_params)
    @review.van_id = @van.id
    @review.user_id = current_user.id
    authorize @review
    if @review.save
      redirect_to van_path(@van)
    else
      render :new
    end
  end

  def show
    @review = Review.find(params[:id])
    authorize @review
    @van = Van.find(@review.van_id)
  end

  def edit
    @review = Review.find(params[:id])
    authorize @review
  end

  def update
    @review = Review.find(params[:id])
    authorize @review
    @review.update(review_params)
    redirect_to review_path(@review)
  end

  def destroy
    @review = Review.find(params[:id])
    authorize @review
    @review.destroy
  end

  private

  def set_van
    @van = Van.find(params[:van_id])
  end

  def review_params
    params.require(:review).permit(:score, :description, :photo)
  end
end

