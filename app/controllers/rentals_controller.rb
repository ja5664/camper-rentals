class RentalsController < ApplicationController
    before_action :set_rental, only: [:show, :edit, :update, :destroy]
    before_action :set_van, only: [:new, :create]
    before_action :set_user, only: [:index]
    helper_method :weather_forecast

  def index
    @rentals = policy_scope(Rental).order(created_at: :desc)
    @user_name = @user.first_name
    weather_forecast

    # Setting message based on trip count
    if @rentals.count == 0
      @status = "No trips booked yet - why not book one?"
    elsif @rentals.count == 1
      @status = "You have #{@rentals.count} trip booked!"
    else
      @status = "You have #{@rentals.count} trips booked!"
    end

    # Setting status for van owners
    if Van.where(user_id: @user)
      @user_owns_a_van = true
    end

    if @user_owns_a_van && Rental.where(user_id: @user).count > 0
      @rented_message_one = "Your vans are rented #{Rental.where(user_id: @user).count} times"
      @rented_message_two = "Superb - with the money from those you can have some beers!"
    else
      @rented_message_one = "No rentals just yet why edit your van description to make it even better!"
      @rented_message_two = "Or on second thoughts take it on a road trip!"
    end
  end

  def new
    @rental = Rental.new
    authorize @rental
  end

  def create
    @rental = Rental.new(rental_params)
    @rental.van = @van
    @rental.user = current_user
    authorize @rental
    if @rental.save
      redirect_to rentals_path
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

  def set_user
    @user = current_user
  end

  def weather_forecast
    # require 'json'
    # require 'open-uri'
    # key = ENV['OPEN_WEATHER_KEY']
    # latitude = 20
    # longitude = 20
    # url = "http://api.openweathermap.org/data/2.5/forecast?lat=#{latitude}&lon=#{longitude}&APPID=#{key}"
    # weather_serialized = open(url).read
    # @forecast = JSON.parse(weather_serialized)
    # @weather = ["#{@forecast["list"][7]["weather"][0]["main"]}","#{@forecast["list"][15]["weather"][0]["main"]}",
    # "#{@forecast["list"][23]["weather"][0]["main"]}","#{@forecast["list"][31]["weather"][0]["main"]}",
    # "#{@forecast["list"][39]["weather"][0]["main"]}"]
    @weather = "sunny"
  end
end
