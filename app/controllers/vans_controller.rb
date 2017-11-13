class VansController < ApplicationController
  before_action :set_van, only: [:show, :edit, :update, :destroy]

  def index
    @vans = Van.all
  end

  def new
    @van = Van.new
  end

  def create
    @van = Van.new(van_params)
    if @van.save
      redirect_to van_path(@cocktail)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @van.update(van_params)
    if @van.save
      redirect_to van_path(@van)
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @van.destroy
    redirect_to vans_path
  end

  private

  def van_params
    params.require(:van).permit(:location, :availability, :make, :photo, :model, :bed, :sleep, :bathroom, :kitchen, :price)
  end

  def set_van
    @van = Van.find(params[:id])
  end
end
