class Review < ActiveRecord::Base
  belongs_to :food_truck
  belongs_to :user
  has_many :votes, dependent: :destroy

  validates :rating, presence: true, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5
    }, allow_nil: false

     paginates_per 10

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

  after_create do
    self.food_truck.update_average_rating(self.rating)
    current = self.food_truck.average_rating *
    (self.food_truck.reviews.count - 1)
    current += self.rating
    self.food_truck.average_rating = current /
    self.food_truck.reviews.count
    self.food_truck.save
  end

end
