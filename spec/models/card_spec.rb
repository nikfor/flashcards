require 'rails_helper'

describe Card, type: :model  do

  let!(:card) { FactoryGirl.create(:card) } 
                                           
  describe "#eql_translation?" do
    context "when invalid" do
      it { expect(card.eql_translation?("abrvalg!?")).to be false }
    end
    context "when valid" do
      it { expect(card.eql_translation?("Provide")).to be true }
      it { expect(card.eql_translation?("provide")).to be true }
    end
  end

  describe "#touch_review_date!" do
    it "has to update review_date for 3 days from now" do
      expect(card.review_date.end_of_minute).to eql 3.days.from_now.end_of_minute
    end
  end

end