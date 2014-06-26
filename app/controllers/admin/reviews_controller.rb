class Admin::ReviewsController < ApplicationController

  before_action :authorize_user

  def destroy
    if Review.find(params[:id]).destroy
      flash[:notice] = "Successfully deleted review."
    else
      flash[:alert] = "Failed to remove review."
    end
    redirect_to admin_root_path
  end

  def authorize_user
    unless user_signed_in? and current_user.admin
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end

