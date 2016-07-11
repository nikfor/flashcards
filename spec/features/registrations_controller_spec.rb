require 'rails_helper'

describe "check registration page", type: :feature do
    let!(:user) { FactoryGirl.create(:user, email: "example@abcd.ru") }
    let!(:card) { FactoryGirl.create(:card, review_date: 4.days.ago) }

    before :each do
      visit('/registration')
    end

    it 'is registred with valid email and password' do
      fill_in 'Почта', :with => 'abcd@abcd.com'
      fill_in 'Пароль', :with => 'marat'
      fill_in 'Подтверждение пароля', :with => 'marat'
      click_button 'Создать'
      expect(page.find('.alert')).to have_content 'Успешная регистрация'
    end

  # it 'is registred with invalid email' do
  #   fill_in 'Почта', :with => 'abcdabcd.com'
  #   fill_in 'Пароль', :with => 'marat'
  #   fill_in 'Подтверждение пароля', :with => 'marat'
  #   click_button 'Создать'
  #   expect(page).to have_content I18n.t('user.invalid_email_message')
  # end

  it 'is registred with existing in base email' do
    fill_in 'Почта', :with => 'example@abcd.ru'
    fill_in 'Пароль', :with => 'marat'
    fill_in 'Подтверждение пароля', :with => 'marat'
    click_button 'Создать'
    expect(page).to have_content I18n.t('user.with_given_email_is_already_registered')
  end

  context "test with invalid password" do
    it 'is registred with short password' do
      fill_in 'Почта', :with => 'abcd@abcd.com'
      fill_in 'Пароль', :with => 'ma'
      fill_in 'Подтверждение пароля', :with => 'ma'
      click_button 'Создать'
      expect(page).to have_content I18n.t('user.password_has_to_be_more_than_3_char')
    end

    it 'is registred with incoincident confirmation to the password' do
      fill_in 'Почта', :with => 'abcd@abcd.com'
      fill_in 'Пароль', :with => 'marat'
      fill_in 'Подтверждение пароля', :with => 'ma'
      click_button 'Создать'
      expect(page).to have_content I18n.t('user.password_not_equal_confirmation')
    end

  end

end
