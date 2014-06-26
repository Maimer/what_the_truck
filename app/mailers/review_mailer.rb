class ReviewMailer < ActionMailer::Base
  default from: "from@example.com"

  def new_review_email(review)
    @review = review
    @food_truck = FoodTruck.find(@review.food_truck_id)
    @user = User.find(@food_truck.user_id)

    mail(to: @user.email, subject: "New review on #{@food_truck.name}!")
  end
end
