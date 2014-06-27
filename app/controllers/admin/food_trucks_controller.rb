class Admin::FoodTrucksController < ApplicationController

  before_action :authorize_user

  def index
    @food_trucks = FoodTruck.order(:created_at)
  end

  def show
    @food_truck = FoodTruck.find(params[:id])
    @reviews = @food_truck.reviews.order(:created_at)
  end

  def destroy
    if FoodTruck.find(params[:id]).destroy
      flash[:notice] = "Successfully deleted food truck."
    else
      flash[:alert] = "Failed to remove food truck."
    end
    redirect_to admin_root
  end

  def authorize_user
    unless user_signed_in? && current_user.admin
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end

