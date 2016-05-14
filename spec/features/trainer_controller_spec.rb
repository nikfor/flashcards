require 'rails_helper'

describe "check word page", type: :feature do

    let!(:user) { FactoryGirl.create(:user, email: "example@abcd.ru") }
    let!(:card) { FactoryGirl.create(:card, review_date: 4.days.ago, user_id: user.id) }
    let!(:card2) { FactoryGirl.create(:card, review_date: 4.days.ago, user_id: user.id) }

    before :each do
      visit('/sign_in')
      fill_in 'Почта', :with => 'example@abcd.ru'
      fill_in 'Пароль', :with => '12345678'
      click_button 'Войти'
      click_link "Тренироваться"
    end

    it 'translates incorrectly' do
      fill_in 'expected_original_text', :with => 'foo'
      click_button 'Проверить'
      expect(page.find('.alert')).to have_content I18n.t("alert.not_right")
    end

    it 'translates correctly' do
      fill_in 'expected_original_text', :with => 'Provide'
      click_button 'Проверить'
      expect(page.find('.alert')).to have_content I18n.t("alert.right")
    end

    it 'has no actual cards in base' do
      fill_in 'expected_original_text', :with => 'Provide'
      click_button 'Проверить'
      fill_in 'expected_original_text', :with => 'Provide'
      click_button 'Проверить'
      expect(page.find('.alert')).to have_content I18n.t("alert.not_have_actual_card")
    end

  end
