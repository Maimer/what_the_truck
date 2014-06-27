class ReviewMailer < ActionMailer::Base
  default from: "from@example.com"

  def new_review_email(review)
    @user = User.find(review.food_truck.user_id)
    @food_truck = review.food_truck
    mail(to: @user.email, subject: "New review on #{review.food_truck.name}!")
  end


  def your_review_email(review, user)
    @user = user
    @food_truck = review.food_truck
    mail(to: @user.email, subject: "Your review on #{review.food_truck.name}")
  end
end
