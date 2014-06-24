class FoodTrucksController < ApplicationController
  def index
    @food_trucks = FoodTruck.all
  end

  def show
    @food_truck = FoodTruck.find(params[:id])
    @review = Review.new
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

  private

  def food_truck_params
    params.require(:food_truck).permit(:name, :description)
  end
end
