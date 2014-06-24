class ReviewsController < ApplicationController

  before_action :authenticate_user!

  def create
    @review = Review.new(review_params)
    @food_truck = FoodTruck.find(params[:food_truck_id])
    @review.food_truck_id = @food_truck.id

    if @review.save
      redirect_to @food_truck
    else
      flash.now[:notice] = "Your review was not succesfully submitted."
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end
end
