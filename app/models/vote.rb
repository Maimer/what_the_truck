class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :review

  validates :user_id, presence: true
  validates :review_id, presence: true
  validates :vote, inclusion: { in: ["none", "up", "down"] }

  def after_create
    count = 0
    self.vote == "up" ? count = 1 : count = -1
    self.review.votes_count += count
    self.review.save
  end

  def after_update
    count = 0
    self.vote == "up" ? count = 2 : count = -2
    self.review.votes_count += count
    self.review.save
  end

  def before_destroy
    count = 0
    self.vote == "up" ? count = 1 : count = -1
    self.review.votes_count -= count
    self.review.save
  end
end
