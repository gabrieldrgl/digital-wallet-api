FactoryBot.define do
  factory :transaction do
    association :user
    transaction_type { :deposit }
    amount { 100.0 }
  end
end
