class RentalsController < ApplicationController
    before_action :set_rental, only: [:show, :edit, :update, :destroy]
    before_action :set_van, only: [:new, :create]
    before_action :set_user, only: [:index]
    helper_method :weather_forecast

  def index
    @rentals = policy_scope(Rental).order(created_at: :desc)
    @my_rentals = Rental.where(user_id: @user)
    @user_name = @user.first_name
    weather_forecast
    @counter = "col-xs-4"

    if @rentals.count == 1
      @counter = "col-xs-12"
    elsif @rentals.count == 2
      @counter = "col-xs-6"
    else
      @counter = "col-xs-4"
    end


    @next_trip = @my_rentals.order(start_date: :desc).limit(1)

    if @next_trip.exists?
    @next_van = @next_trip[0].van_id
    @latitude = Van.find(@next_trip[0].van_id).longitude
    @latitude = Van.find(@next_trip[0].van_id).latitude
    @next_trip_start =@next_trip[0].start_date
    @days_to_go = (@next_trip_start - Date.today + 1).to_i
    @next_location = Van.find(@next_van).location
    weather_forecast
    end


    # Setting message based on trip count
    if @my_rentals.count == 0
      @status = "No trips booked yet - why not book one?"
    elsif @my_rentals.count == 1
      @status = "You have #{@rentals.count} trip booked!"
      @status_two = "You are off to #{@next_location}"
      @days_to_go == 1 ? @status_three = "Only #{@days_to_go} day to go!" : @status_three = "Only #{@days_to_go} days to go!"
      @status_four = "The current weather there is #{@weather}"
    else
      @status = "You have #{@rentals.count} trips booked!"
      @status_two = "You are off to #{@next_location} next!"
      @days_to_go == 1 ? @status_three = "Only #{@days_to_go} day to go!" : @status_three = "Only #{@days_to_go} days to go!"
      @status_four = "The current weather there is #{@weather}"
    end

    owned_vans = Van.where(user_id: 1).ids
    no_of_rentals = Rental.where(van_id: owned_vans).count
    # Setting status for van owners
    @user_owns_a_van = Van.where(user_id: @user.id).exists?
    if @user_owns_a_van && no_of_rentals > 0
      no_of_rentals == 1 ? @rented_message_one = "You have one #{no_of_rentals} rental" : "Sweet you have one #{no_of_rentals} rentals"
      no_of_rentals == 1 ? @rented_message_two = "Superb - with the money from those you can have some beers!" : "Wow - with those rentals you will be a millionaire!"
    elsif @user_owns_a_van == true
      @rented_message_one = "No rentals just yet why edit your van description to make it even better!"
      @rented_message_two = "Or on second thoughts take it on a road trip!"
    else
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
    require 'json'
    require 'open-uri'
    key = ENV['OPEN_WEATHER_KEY']
    latitude = 20
    longitude = 20
    url = "http://api.openweathermap.org/data/2.5/forecast?lat=#{latitude}&lon=#{longitude}&APPID=#{key}"
    weather_serialized = open(url).read
    @forecast = JSON.parse(weather_serialized)
    @weather = ["#{@forecast["list"][7]["weather"][0]["main"]}"].join.downcase
  end
end
