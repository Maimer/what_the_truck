class ReviewsController < ApplicationController

  before_action :authenticate_user!

  def new
    @food_truck = FoodTruck.find(params[:food_truck_id])
    if !@food_truck.reviews.where(user: current_user)
      @review = Review.new
    else
      flash[:notice] = "You have already reviewed this food truck!"
      redirect_to @food_truck
    end
  end

  def create
    @review = Review.new(review_params)
    @food_truck = FoodTruck.find(params[:food_truck_id])
    @review.food_truck = @food_truck
    @review.user = current_user

    if @review.save
      redirect_to @food_truck
    else
      flash.now[:notice] = "Your review was not succesfully submitted."
      render 'food_trucks/new'
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end
end
