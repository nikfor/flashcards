FactoryGirl.define do 

  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do 

    email
    password "12345678"

    factory :user_with_cards do
      transient do
        cards_count 5
      end

    end

  end
end
