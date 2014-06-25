class Review < ActiveRecord::Base
  belongs_to :food_truck
  belongs_to :user
  has_many :votes

  validates :rating, presence: true, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5
    }, allow_nil: false

  def upvote_count
    votes.where(vote: 'up').count
  end

  def downvote_count
    votes.where(vote: 'down').count
  end

  def cache_vote_count
    self.votes_count = upvote_count - downvote_count
    save
  end
end
