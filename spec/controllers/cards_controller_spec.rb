require 'rails_helper'

describe CardsController, type: :controller do

  let!(:user) { FactoryGirl.create(:user, email: "example@abcd.ru") }
  let!(:test_card) { FactoryGirl.create(:card, user_id: user.id) }
  let!(:another_user) { FactoryGirl.create(:user, email: "another@abcd.ru") }
  let!(:another_card) { FactoryGirl.create(:card, user_id: another_user.id) }

  before :each do
    login_user(user)
  end

  describe '#create' do

    it 'redirect to cards_path if arguments is valid' do

      post :create, card: { original_text: "Invoke", translated_text: "Призывать", user_id: user.id }
      expect(response).to redirect_to(cards_path)
    end

    it 'render to back page if translation is equal to the original' do
      post :create, card: { original_text: "Invoke", translated_text: "Invoke", user_id: user.id }
      expect(response).to render_template('new')
    end

    context 'image of cards tests' do
      it { expect(test_card).to have_attached_file(:avatar) }
      it { expect(test_card).to validate_attachment_content_type(:avatar).
                allowing('image/png', 'image/gif', 'image/jpg', 'image/jpeg').
                rejecting('text/plain', 'text/xml')
          }
    end

  end

  describe '#update' do

    it 'redirect to cards_path if arguments is valid' do
      patch :update, id: test_card.id, card: { original_text: "Invoke", translated_text: "Призывать" }
      expect(response).to redirect_to(cards_path)
    end

    it 'render edit page again if arguments is invalid' do
      patch :update, id: test_card.id, card: { original_text: "Invoke", translated_text: "invoke" }
      expect(response).to render_template('edit')
    end

    it 'render 404 page if card not found' do
      patch :update, id: 687, card: { original_text: "Invoke", translated_text: "Призывать" }
      expect(response.status).to be(404)
    end

    it 'render 404 page if updated card doesnt belong to current user' do
      patch :update, id: another_card.id, card: { original_text: "Invoke", translated_text: "Призывать" }
      expect(response.status).to be(404)
    end

  end

  describe '#destroy' do

    it 'redirect to cards_path if card found' do
       delete :destroy, id: test_card.id
       expect(response).to redirect_to(cards_path)
    end

    it 'render 404 page if card not found' do
      delete :destroy, id: 9879
      expect(response.status).to be(404)
    end

    it 'render 404 page if deleted card doesnt belong to current user' do
      delete :destroy, id: another_card.id
      expect(response.status).to be(404)
    end

  end


end
