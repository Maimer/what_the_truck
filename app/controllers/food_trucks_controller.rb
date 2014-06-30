class FoodTrucksController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:search]
      @food_trucks = FoodTruck.includes(reviews: :user).search(params[:search][:query]).page params[:page]
    else
      @food_trucks = FoodTruck.includes(reviews: :user).order(average_rating: :desc).page params[:page]
    end
  end

  def show
    @food_truck = FoodTruck.find(params[:id])
    @reviews = @food_truck.reviews.order(votes_count: :desc).page params[:page]
  end

  def new
    @food_truck = FoodTruck.new
  end

  def create
    @food_truck = FoodTruck.new(food_truck_params)

    @food_truck.user_id = current_user.id

    if @food_truck.save
      redirect_to @food_truck
    else
      if @food_truck.errors.messages[:name][0] == "can't be blank"
        flash.now[:notice] = "Your food truck was not succesfully submitted."
      elsif @food_truck.errors.messages[:name][0] == "has already been taken"
        flash.now[:notice] = "This food truck already exists."
      end
      render :new
    end
  end

  private

  def food_truck_params
    params.require(:food_truck).permit(:name, :website, :description, :truck_photo)
  end
end
