require 'rails_helper'

describe "check word page", type: :feature do
    
    before :each do
      card = FactoryGirl.create(:card)
      card2 = FactoryGirl.create(:card)
      card.update_column(:review_date, 4.days.ago)
      card2.update_column(:review_date, 4.days.ago)
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

  end
