FactoryGirl.define do 
  factory :card  do 
    original_text "Provide"
    translated_text "Обеспечивать"
    association :user, factory: :user
  end
end
