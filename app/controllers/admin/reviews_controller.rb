class Admin::ReviewsController < ApplicationController

  before_action :authorize_user

  def destroy

  end

  def authorize_user
    unless user_signed_in? and current_user.admin
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end

