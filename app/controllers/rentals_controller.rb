class RentalsController < ApplicationController
    before_action :set_rental, only: [:show, :edit, :update, :destroy]
  def index
    @rentals = Rental.all
  end

  def new
    @rental = Rental.new
  end

  def create
    @rental = Rental.new(rental_params)
    if @rental.save
      redirect_to rental_path(@rental)
    else
      render :new
  end

  def show
  end

  def edit
  end

  def update
    if @rental.update(rental_path)
      redierct_to rental_path(@rental)
    else
      render :edit
    end
  end

  def destroy
    @rental.destroy
    redirect_to rental_path
  end

  private

  def rental_params
    params.require(:rental).permit(:start_date, :end_date, :photo, :price, :status)
  end

  def set_rental
    @rental = Rental.find(params[:id])
  end
end
