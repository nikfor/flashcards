require 'rails_helper'

describe "check registration page", type: :feature do
    let!(:user) { FactoryGirl.create(:user, email: "example@abcd.ru") }
    let!(:user2) { FactoryGirl.create(:user, email: "example2@abcd.ru") }
    let!(:pack) { FactoryGirl.create(:pack, name: "Transport", user_id: user.id) }
    let!(:pack2) { FactoryGirl.create(:pack, name: "Food", user_id: user2.id) }
    let!(:card) { FactoryGirl.create(:card, review_date: 4.days.ago, pack_id: pack.id) }
    let!(:card2) { FactoryGirl.create(:card, original_text: "Invoke",
                                             translated_text: "Вызывать",
                                             review_date: 4.days.ago,
                                             pack_id: pack2.id) }

    before :each do
      visit('/sign_in')
      fill_in 'Почта', with: user.email
      fill_in 'Пароль', with: '12345678'
      click_button 'Войти'
    end

    it 'show user cards if user sign_in' do
      visit(pack_cards_path(pack))
      expect(page).to have_content "Provide"
      expect(page).not_to have_content "Invoke"
    end

    it 'is edits user password' do
      visit(edit_users_path)
      fill_in 'Старый пароль', with: '12345678'
      fill_in 'Новый пароль', with: 'another_password'
      fill_in 'Повторите новый пароль', with: 'another_password'
      click_button 'Сохранить'
      click_link 'Выйти'
      visit('/sign_in')
      fill_in 'Почта', with: user.email
      fill_in 'Пароль', with: 'another_password'
      click_button 'Войти'
      expect(page.find('.alert')).to have_content I18n.t('user.hello')
      expect(page).to have_content I18n.t('user.log_out')
    end
end
