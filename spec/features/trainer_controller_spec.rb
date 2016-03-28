require 'rails_helper'

describe "check word page", type: :feature do
    
    let!(:card) { FactoryGirl.create(:card, review_date: 4.days.ago) }
    let!(:card2) { FactoryGirl.create(:card, review_date: 4.days.ago) }

    before :each do
      visit root_path
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
