class FoodTruck < ActiveRecord::Base
  has_many :reviews, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :user_id, presence: true

  def average_rating
    if reviews.size > 0
      (reviews.pluck(:rating).sum / reviews.size.to_f).round(0).to_i
    else
      0
    end
  end
end
