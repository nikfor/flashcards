  require 'rails_helper'

describe TrainerController, type: :controller do

  let!(:user) { FactoryGirl.create(:user, email: "example@abcd.ru") }
  let!(:pack) {FactoryGirl.create(:pack_with_cards, user: user)}
  let!(:test_card) { FactoryGirl.create(:card, pack: pack) }


  before :each do
    login_user(user)
  end


  context "if card found and expected text is right" do
    it 'redirect to back_page' do
       request.env["HTTP_REFERER"] = "/flashcard"
       post :review, id: test_card.id, expected_card: {expected_text: 'Provide'}
       expect(response).to redirect_to('/flashcard')
    end

    it 'call review method of ReviewCardService' do
      request.env["HTTP_REFERER"] = "/flashcard"
      result = Struct.new(:status, :message) do
        def success?
          status ? true : false
        end
      end
      expect_any_instance_of(ReviewCardService).to receive(:review).and_return(result.new(true, 'Верно'))
      post :review, id: test_card.id, expected_card: {expected_text: 'provide'}
    end
  end


  it 'render 404 page if card not found' do
    post :review, id: 9879, expected_card: {expected_text: 'lskdjl'}
    expect(response.status).to be(404)
  end

end
