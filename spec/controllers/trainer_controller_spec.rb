require 'rails_helper'

describe TrainerController, type: :controller do

  let(:test_card) { FactoryGirl.create(:card) }

  it 'redirect to back_page if card found and expected text is right' do
     request.env["HTTP_REFERER"] = "/flashcard"
     post :review, id: test_card.id, expected_card: {expected_text: 'Provide'}
     expect(response).to redirect_to('/flashcard')
  end

  it 'call touch_review_date! if card found and expected text is right' do
    request.env["HTTP_REFERER"] = "/flashcard"
    post :review, id: test_card.id, expected_card: {expected_text: 'provide'} 
    expect_any_instance_of(Card).to receive(:touch_review_date!)
  end

  it 'render 404 page if card not found' do
    post :review, id: 9879, expected_card: {expected_text: 'lskdjl'}
    expect(response.status).to be(404)
  end

end
