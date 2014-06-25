class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :review

  validates :user_id, presence: true
  validates :review_id, presence: true
  validates :vote, inclusion: { in: ["none", "up", "down"] }

  after_create do
    count = 0
    self.vote == "up" ? count = 1 : count = -1
    self.review.votes_count += count
    self.review.save
  end

  after_update do
    count = 0
    self.vote == "up" ? count = 2 : count = -2
    self.review.votes_count += count
    self.review.save
  end

  before_destroy do
    count = 0
    self.vote == "up" ? count = 1 : count = -1
    self.review.votes_count -= count
    self.review.save
  end
end
