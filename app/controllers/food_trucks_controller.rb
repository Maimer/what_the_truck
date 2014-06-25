class FoodTrucksController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index
    @food_trucks = FoodTruck.order(average_rating: :desc)
  end

  def show
    @food_truck = FoodTruck.find(params[:id])
    @review = Review.new
    @reviews = @food_truck.reviews.order(votes_count: :desc)
  end

  def new
    @food_truck = FoodTruck.new
  end

  def create
    @food_truck = FoodTruck.new(food_truck_params)

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

  def destroy
    food_truck = FoodTruck.find(params[:id])
    if current_user.admin || current_user.id == food_truck.user_id
      if food_truck.destroy
        flash[:notice] = "Successfully deleted food truck."
        redirect_to root_path
      end
    else
      flash[:alert] = "Failed to remove food truck."
      render :show
    end
  end

  private

  def food_truck_params
    params.require(:food_truck).permit(:name, :description)
  end
end
