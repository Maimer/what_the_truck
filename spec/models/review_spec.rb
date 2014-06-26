require 'rails_helper'
require 'spec_helper'

# RSpec.describe Review, :type => :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end


describe Review do
  user = FactoryGirl.create(:user, id: 1)
  review = FactoryGirl.create(:review)

  it "sends an email" do
    expect { review.send_email}.to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
