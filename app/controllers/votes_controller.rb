class VotesController < ApplicationController

  before_action :authenticate_user!

  def create
    review = Review.find(params[:review_id])
    vote = Vote.find_by(review: review, user: current_user)
    vote ||= Vote.new(review: review, user: current_user)
    vote.assign_attributes(vote_params)
    vote.save

    redirect_to review.food_truck
  end

  private

  def vote_params
    params.require(:vote).permit(:vote)
  end
end
