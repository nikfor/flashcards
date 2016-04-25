require 'rails_helper'

describe User, type: :model do


  let!(:user) { FactoryGirl.create(:user) } 
  let!(:card) { FactoryGirl.create(:card) } 


  context "associations" do
    it "should have many cards" do
      is_expected.to have_many(:cards)
    end
  end

end
