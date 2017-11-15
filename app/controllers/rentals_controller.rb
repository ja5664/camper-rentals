class RentalsController < ApplicationController
    before_action :set_rental, only: [:show, :edit, :update, :destroy]
    before_action :set_van, only: [:new, :create]

  def index
    @rentals = policy_scope(Rental).order(created_at: :desc)
  end

  def new
    @rental = Rental.new
    authorize @rental
  end

  def create
    @rental = Rental.new(rental_params)
    authorize @rental
    # binding.pry
    if @rental.save
      redirect_to van_rentals_path
    else
      render :new
    end
  end

  def show
    authorize @rental
    @van = Van.find(@rental.van_id)
    @renter = User.find(@rental.user_id)
    @owner = User.find(@van.user_id)
  end

  def edit
    authorize @rental
  end

  def update
    authorize @rental
    if @rental.update(rental_path)
      redirect_to rental_path(@rental)
    else
      render :edit
    end
  end

  def destroy
    authorize @rental
    @rental.destroy
    redirect_to root_path
  end

  private

  def rental_params
    params.require(:rental).permit(:start_date, :end_date, :photo, :price, :status)
  end

  def set_van
    @van = Van.find(params[:van_id])
  end

  def set_rental
    @rental = Rental.find(params[:id])
  end
end
