class VansController < ApplicationController
  before_action :set_van, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :new, :create]

  def index
    @vans = policy_scope(Van).where.not(latitude: nil, longitude: nil).order(created_at: :desc)

    @hash = Gmaps4rails.build_markers(@vans) do |van, marker|
      marker.lat van.latitude
      marker.lng van.longitude
    end
    @results = params[:query].present? ? Van.global_search(params[:query]) : Van.all
  end

  def show
    authorize @van
    @rental = Rental.new
    @van = Van.find(params[:id])

    @hash = Gmaps4rails.build_markers(@van) do |van, marker|
      marker.lat van.latitude
      marker.lng van.longitude
    end
  end

  def new
    @van = Van.new
    authorize @van
  end

  def create
    @van = Van.new(van_params)
    @van.user = current_user
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

  def destroy
    authorize @van
    @van.destroy
    redirect_to vans_path
  end

  private

  def van_params
    params.require(:van).permit(:location, :availability, :description, :make, :model, :bed, :sleep, :bathroom, :kitchen, :price, :photo)
  end

  def set_van
    @van = Van.find(params[:id])
  end
end
