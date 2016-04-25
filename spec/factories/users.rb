FactoryGirl.define do 

  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do 
    email
    password "12345678"

    # factory :user_with_cards do
    #   transient do
    #     cards_count 5
    #   end
    #   after(:create) do |user, evaluator|
    #     create_list(:card, evaluator.cards_count, user: user)
    #   end
    # end

  end
  
end
