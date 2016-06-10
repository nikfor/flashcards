require 'rails_helper'

describe PacksController, type: :controller do

  let!(:user) { FactoryGirl.create(:user, email: "example@abcd.ru") }
  let!(:pack) { FactoryGirl.create(:pack, user: user) }
  let!(:mike) { FactoryGirl.create(:user, email: "mike@abcd.ru") }
  let!(:another_pack) { FactoryGirl.create(:pack, user: mike) }

  before :each do
    login_user(user)
  end


  describe '#create' do

    it 'redirect to packs_path if pack successfully create' do
      post :create, pack: { name: "Test", user: user }
      expect(response).to redirect_to(packs_path)
    end

  end

  describe '#update' do

    it 'redirect to packs_path if pack successfully update' do
      patch :update, id: pack.id, pack: { name: "Food" }
      expect(response).to redirect_to(packs_path)
    end

    it 'render 404 page if pack not found' do
      patch :update, id: 99999, pack: { name: "Food" }
      expect(response.status).to be(404)
    end

    it 'render 404 page if updated pack doesnt belong to current user' do
      patch :update, id: another_pack.id, pack: { name: "Food" }
      expect(response.status).to be(404)
    end

  end

  describe '#destroy' do

    it 'redirect to packs_path if pack successfully deleted' do
       delete :destroy, id: pack.id
       expect(response).to redirect_to(packs_path)
    end

    it 'render 404 page if pack not found' do
      delete :destroy, id: 99879
      expect(response.status).to be(404)
    end

    it 'render 404 page if deleted pack doesnt belong to current user' do
      delete :destroy, id: another_pack.id
      expect(response.status).to be(404)
    end
  end

  describe '#current_pack' do

    it 'redirect to packs_path if pack successfully do current' do
      get :current_pack, id: pack.id
      expect(response).to redirect_to(packs_path)
    end

    it 'render 404 page if pack doesnt belong to current user' do
      get :current_pack, id: another_pack.id
      expect(response.status).to be(404)
    end

  end


end
