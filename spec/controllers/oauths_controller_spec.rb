require 'rails_helper'

describe OauthsController, type: :controller do

  let!(:adam) { FactoryGirl.create(:user) }

  it 'logs in a linked user' do
    allow_any_instance_of(OauthsController).to receive(:login_from).with('twitter').and_return(Authentication.new)
    session[:user_id] = adam.id
    get :callback, provider: 'twitter', code: '123'
    expect(flash[:alert]).to eq "Logged in from Twitter!"
  end

  it 'create and logs in a new user' do
    allow_any_instance_of(OauthsController).to receive(:login_from).with('twitter').and_return(false)
    allow_any_instance_of(OauthsController).to receive(:create_from).with('twitter').and_return(Authentication.new(user_id: '123', uid: '123', provider: 'twitter'))
    session[:user_id] = adam.id
    get :callback, provider: 'twitter', code: '123'
    expect(flash[:alert]).to eq "Create and logged in from Twitter!"
  end
end
