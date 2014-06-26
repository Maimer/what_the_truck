class Admin::ReviewsController < ApplicationController

  before_action :authorize_user

  def destroy
    review = Review.find(params[:id])
    food_truck = review.food_truck
    if review.destroy
      flash[:notice] = "Successfully deleted review."
    else
      flash[:alert] = "Failed to remove review."
    end
    redirect_to admin_food_truck_path(food_truck)
  end

  def authorize_user
    unless user_signed_in? and current_user.admin
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end

