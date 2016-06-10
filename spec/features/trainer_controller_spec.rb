require 'rails_helper'

describe "check word page", type: :feature do

    let!(:user) { FactoryGirl.create(:user, email: "example@abcd.ru") }
    let!(:pack) { FactoryGirl.create(:pack, user_id: user.id) }
    let!(:card) { FactoryGirl.create(:card, review_date: 4.days.ago, pack_id: pack.id) }
    let!(:card2) { FactoryGirl.create(:card, review_date: 4.days.ago, pack_id: pack.id) }
    let!(:pack2) { FactoryGirl.create(:pack, name: "Travel", user_id: user.id) }

    before :each do
      visit('/sign_in')
      fill_in 'Почта', :with => 'example@abcd.ru'
      fill_in 'Пароль', :with => '12345678'
      click_button 'Войти'
      click_link 'Все колоды'
      find(:xpath, "//tr[td[contains(.,'Transport')]]/td/a", :text => 'Текущая').click
      click_link 'Тренироваться'
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
      expect(page.find('.alert-info')).to have_content I18n.t("alert.not_have_actual_card")
    end

    it 'view one of all user cards if current pack doesnt chosen' do
      user.packs.update_all(current: false)
      click_link 'Тренироваться'
      expect(page.find('.alert')).to have_content I18n.t("alert.choose_current_pack")
    end

  end
