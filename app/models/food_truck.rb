class FoodTruck < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  belongs_to :user

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

  def self.search(query)
    where("to_tsvector(name) || ' ' || to_tsvector(description) @@ plainto_tsquery(?)", query)
  end

  def update_average_rating(rating)
    total_ratings = self.average_rating * (self.reviews.count - 1)
    total_ratings += rating
    self.average_rating = total_ratings / self.reviews.count
    self.save
  end
end
