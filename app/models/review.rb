class Review < ActiveRecord::Base
  belongs_to :food_truck
  belongs_to :user
  has_many :votes, dependent: :destroy

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

  after_create do
    self.food_truck.update_average_rating(self.rating)
  end

  def send_email
    ReviewMailer.new_review_email(self).deliver
  end
end
