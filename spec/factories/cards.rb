FactoryGirl.define do
  factory :card  do
    original_text "Provide"
    translated_text "Обеспечивать"
    avatar { File.new("#{Rails.root}/spec/support/fixtures/image.jpg") }
    association :user, factory: :user
  end
end
