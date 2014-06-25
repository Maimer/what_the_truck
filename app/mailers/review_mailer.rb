class ReviewMailer < ActionMailer::Base
  default from: "from@example.com"

  def new_review_email(review)
    @review = review
    @food_truck = @review.food_truck
    @user = @food_truck.user

    mail(to: @user.email, subject: "New review on #{@food_truck.name}!")
  end
end
