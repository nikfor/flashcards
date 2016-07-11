require 'rails_helper'

describe CardsController, type: :controller do

  let!(:user) { FactoryGirl.create(:user, email: "example@abcd.ru") }
  let!(:pack) { FactoryGirl.create(:pack, user: user) }
  let!(:test_card) { FactoryGirl.create(:card, pack: pack) }
  let!(:another_user) { FactoryGirl.create(:user, email: "another@abcd.ru") }
  let!(:another_pack) { FactoryGirl.create(:pack, user: another_user) }
  let!(:another_card) { FactoryGirl.create(:card, pack: another_pack  ) }

  before :each do
    login_user(user)
  end

  describe '#create' do

    it 'redirect to cards_path if arguments is valid' do
      post :create, pack_id: pack.id, card: { original_text: "Invoke", translated_text: "Призывать" }
      expect(response).to redirect_to(pack_cards_path)
    end

    it 'render to back page if translation is equal to the original' do
      post :create, pack_id: pack.id, card: { original_text: "Invoke", translated_text: "Invoke"}
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
      patch :update, id: test_card.id, pack_id: test_card.pack_id, card: { original_text: "Invoke", translated_text: "Призывать" }
      expect(response).to redirect_to(pack_cards_path)
    end

    it 'render edit page again if arguments is invalid' do
      patch :update, id: test_card.id, pack_id: test_card.pack_id, card: { original_text: "Invoke", translated_text: "invoke" }
      expect(response).to render_template('edit')
    end

    it 'render 404 page if card not found' do
      patch :update, id: 687, pack_id: test_card.pack_id, card: { original_text: "Invoke", translated_text: "Призывать" }
      expect(response.status).to be(404)
    end

    it 'render 404 page if updated card doesnt belong to current user' do
      patch :update, id: another_card.id, pack_id: pack.id, card: { original_text: "Invoke", translated_text: "Призывать" }
      expect(response.status).to be(404)
    end

  end

  describe '#destroy' do

    it 'redirect to cards_path if card found' do
      delete :destroy, pack_id: test_card.pack_id, id: test_card.id
      expect(response).to redirect_to(pack_cards_path)
    end

    it 'render 404 page if card not found' do
      delete :destroy, pack_id: test_card.pack_id, id: 9879
      expect(response.status).to be(404)
    end

    it 'render 404 page if deleted card doesnt belong to current user' do
      delete :destroy, pack_id: pack.id, id: another_card.id
      expect(response.status).to be(404)
    end

  end


end
