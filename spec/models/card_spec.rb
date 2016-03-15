require 'rails_helper'

describe Card, type: :model  do

  let!(:card) { FactoryGirl.create(:card) } # не понял почему не работает просто create хоть и config.include FactoryGirl::Syntax::Methods добавлял 
                                            # и в rails_helper и в spec_helper    
  describe :eql_translation? do
    it { expect(card.eql_translation?("abrvalg!?")).to be false }
    it { expect(card.eql_translation?("Provide")).to be true }
    it { expect(card.eql_translation?("provide")).to be true }
  end

  describe :touch_review_date! do
    it { expect(card.review_date.end_of_minute).to eql 3.days.from_now.end_of_minute }
  end

  # describe :translate_should_not_be_eql_original do
  #   card = Card.new(original_text: 'allow', translated_text: 'allow')
  #   card.valid?
  #   expect(card.errors[:original_text]).not_to be_empty
  # end

end
