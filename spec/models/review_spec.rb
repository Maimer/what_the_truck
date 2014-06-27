require 'rails_helper'
require 'spec_helper'


describe Review do
  let(:user) { FactoryGirl.create(:user) }
  let(:review) { FactoryGirl.create(:review) }

  it "sends an email" do
    expect { review.send_email}.to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
