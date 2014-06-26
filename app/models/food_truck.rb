class FoodTruck < ActiveRecord::Base
  has_many :reviews, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :user_id, presence: true

  def self.search(query)
    where("to_tsvector(name) || ' ' || to_tsvector(description) @@ plainto_tsquery(?)", query)
  end

  def update_average_rating(rating)
    total_ratings = self.average_rating * (self.reviews.count - 1)
    total_ratings += rating
    self.average_rating = total_ratings.to_f / self.reviews.count
    self.save
  end
end
