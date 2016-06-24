FactoryGirl.define do
  factory :pack  do
    name "Transport"
    association :user, factory: :user

    factory :pack_with_cards do
      transient do
        cards_count 5
      end
      after(:create) do |pack, evaluator|
        create_list(:card, evaluator.cards_count, pack: pack)
      end
    end

  end
end
