class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :review

  validates :user_id, presence: true
  validates :review_id, presence: true
  validates :vote, inclusion: { in: ["none", "up", "down"] }

  after_save do
    review.cache_vote_count
  end
end
