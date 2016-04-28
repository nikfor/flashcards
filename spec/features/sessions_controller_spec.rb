require 'rails_helper'

describe "check sign_in and logout ", type: :feature do
  let!(:user) { FactoryGirl.create(:user, email: "example@abcd.ru") }
  let!(:card) { FactoryGirl.create(:card, review_date: 4.days.ago) }

  before :each do
    visit('/sign_in')
    fill_in 'Почта', :with => 'example@abcd.ru'
    fill_in 'Пароль', :with => '12345678'
    click_button 'Войти'
  end

  it 'is sign in with valid email and password' do
    expect(page.find('.alert')).to have_content I18n.t('user.hello')
    expect(page).to have_content I18n.t('user.log_out')
    expect(page).not_to have_content I18n.t('user.sign_in')
    expect(page).not_to have_content I18n.t('user.sign_up')
  end

  it 'is log out' do
    click_link 'Выйти'
    expect(page.find('.alert')).to have_content I18n.t('user.bye')
    expect(page).not_to have_content I18n.t('user.log_out')
  end

end
