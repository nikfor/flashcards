require 'rails_helper'

describe CardsController, type: :controller do

  let(:test_card) { FactoryGirl.create(:card) }

  describe '#create' do

    it 'redirect to cards_path if arguments is valid' do
      post :create, card: { original_text: "Invoke", translated_text: "Призывать" }
      expect(response).to redirect_to(cards_path)
    end

    it 'render to back page if translation is equal to the original' do
      post :create, card: { original_text: "Invoke", translated_text: "Invoke" }
      expect(response).to render_template('new')
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

  end


end
