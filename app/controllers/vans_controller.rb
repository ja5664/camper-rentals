class VansController < ApplicationController
  before_action :set_van, only: [:show, :edit, :update, :destroy]

  skip_before_action :authenticate_user!, only: [:index, :new, :create]

  def index
    @vans = Van.all
  end

  def new
    @van = Van.new
    authorize @van
  end

  def create
    @van = Van.new(van_params)
    authorize @van
    if @van.save
      redirect_to van_path(@van)
    else
      render :new
    end
  end

  def edit
    authorize @van
  end

  def update
    authorize @van
    if @van.update(van_params)
      redirect_to van_path(@van)
    else
      render :edit
    end
  end

  def show
    authorize @van
  end

  def destroy
    authorize @van
    @van.destroy
    redirect_to vans_path
  end

  private

  def van_params
    params.require(:van).permit(:location, :availability, :description, :photo, :make, :model, :bed, :sleep, :bathroom, :kitchen, :price)
  end

  def set_van
    @van = Van.find(params[:id])
  end
end
