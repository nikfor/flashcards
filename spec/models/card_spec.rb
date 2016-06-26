require 'rails_helper'

describe Card, type: :model  do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:pack) { FactoryGirl.create(:pack, user: user) }
  let!(:card) { FactoryGirl.create(:card, pack: pack) }

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

  context "associations" do
    it "should belong to pack" do
      expect(card).to belong_to(:pack)
    end

    it "should belong to user" do
      expect(pack).to belong_to(:user)
    end

    it "dont create card without pack" do
      # expect( build( :card, original_text: "Sister", translated_text: "Сестра", pack_id: nil) ).not_to be_valid
      expect{Card.create(original_text: "Sister", translated_text: "Сестра")}.not_to allow_value(nil).for(:pack_id)
    end

  end


end
