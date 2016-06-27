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
      example_card = build( :card, original_text: "Sister", translated_text: "Сестра", pack_id: nil)
      expect( example_card.valid? ).to be false
      expect( example_card.errors.messages[:pack_id].first ).to eql "translation missing: ru.activerecord.errors.models.card.attributes.pack_id.blank"
    end

  end


end
