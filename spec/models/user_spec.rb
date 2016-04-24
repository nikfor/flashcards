require 'rails_helper'

describe User, type: :model do

  let!(:card) { FactoryGirl.create(:card) }
  #let!(:user) { FactoryGirl.create(:user) } 


  context "associations" do
    it "should have many cards" do
      #user.cards << card
       #is_expected.to have_many(:card)
    end
  end

end
