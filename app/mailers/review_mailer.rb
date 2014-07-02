class ReviewMailer < ActionMailer::Base
  default from: "from@example.com"

  def new_review_email(review)
    @user = User.find(review.food_truck.user_id)
    @food_truck = review.food_truck
    attachments.inline['title.png'] = File.read(Rails.root.join("app/assets/images/title.png"))
    # attachments.inline['photo.png'] = File.read("#{@food_truck.truck_photo.url(:thumb)}")
    # mail(to: @user.email, subject: "New review on #{review.food_truck.name}!")
  end


  def your_review_email(review, user)
    @user = user
    @food_truck = review.food_truck
    attachments.inline['title.png'] = File.read(Rails.root.join("app/assets/images/title.png"))
    # attachments.inline['photo.png'] = File.read("#{@food_truck.truck_photo.url(:thumb)}")
    # mail(to: @user.email, subject: "Your review on #{review.food_truck.name}")
  end
end
