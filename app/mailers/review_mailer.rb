class ReviewMailer < ActionMailer::Base
  default from: "from@example.com"

  def new_review_email(review)
    @review = review
    @food_truck = @review.food_truck
    @user = User.find(@food_truck.user_id)

    mail(to: @user.email, subject: "New review on #{@food_truck.name}!")
  end
end
