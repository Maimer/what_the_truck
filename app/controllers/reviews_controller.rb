class ReviewsController < ApplicationController

  before_action :authenticate_user!

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

  def destroy
    review = Review.find(params[:id])
    food_truck = review.food_truck
    if current_user.admin || current_user.id == review.user_id
      if review.destroy
        flash[:notice] = "Successfully deleted review."
      end
    else
      flash[:alert] = "Failed to remove review."
    end
    redirect_to food_truck
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end
end
