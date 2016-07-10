require 'rails_helper'

describe ReviewCardService, type: :service  do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:pack) { FactoryGirl.create(:pack, user: user) }
  let!(:test_card) { FactoryGirl.create(:card, pack: pack, review_date: Time.current) }
  let!(:correctly_translate_service) { ReviewCardService.new(test_card, 'Provide') }
  let!(:typo_correctly_translate_service) { ReviewCardService.new(test_card, 'Povide') }
  let!(:not_correctly_translate_service) { ReviewCardService.new(test_card, 'not correct translate text') }

  it "#review" do

    expect(correctly_translate_service.review[:success]).to eql true
    expect(test_card.count_success_attempts).to eql 1
    expect(test_card.review_date.end_of_minute).to eql 12.hours.from_now.end_of_minute

    correctly_translate_service.review
    expect(test_card.count_success_attempts).to eql 2
    expect(test_card.review_date.end_of_minute).to eql 3.days.from_now.end_of_minute

    correctly_translate_service.review
    expect(test_card.count_success_attempts).to eql 3
    expect(test_card.review_date.end_of_minute).to eql 7.days.from_now.end_of_minute

    not_correctly_translate_service.review
    expect(test_card.count_unsuccess_attempts).to eql 1
    expect(test_card.count_success_attempts).to eql 3

    correctly_translate_service.review
    expect(test_card.count_unsuccess_attempts).to eql 0
    expect(test_card.count_success_attempts).to eql 4
    expect(test_card.review_date.end_of_minute).to eql 14.days.from_now.end_of_minute

    correctly_translate_service.review
    expect(test_card.count_success_attempts).to eql 5
    expect(test_card.review_date.end_of_minute).to eql 1.months.from_now.end_of_minute

    expect(not_correctly_translate_service.review[:success]).to eql false
    not_correctly_translate_service.review
    not_correctly_translate_service.review
    expect(test_card.review_date.end_of_minute).to eql 12.hours.from_now.end_of_minute
    expect(test_card.count_unsuccess_attempts).to eql 0
    expect(test_card.count_success_attempts).to eql 1

    expect(typo_correctly_translate_service.review[:success]).to eql true
    expect(test_card.count_success_attempts).to eql 2
    expect(test_card.review_date.end_of_minute).to eql 3.days.from_now.end_of_minute
  end

end
