class FoodTruck < ActiveRecord::Base
  has_many :locations
  has_many :reviews, dependent: :destroy, counter_cache: true
  belongs_to :user

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :user_id, presence: true

  mount_uploader :truck_photo, TruckPhotoUploader

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
