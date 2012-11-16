FactoryGirl.define do
  factory :payment_item, :class => PaymentsTracker::PaymentItem do    
    sequence(:title) {|n| "PaymentItem#{n}"}
    description { Faker::Lorem.sentence(50) }
    amount 10.00
    owner { FactoryGirl.create(:admin_user) }
    grouping { FactoryGirl.create(:group_with_members) }
  end

  factory :general_payment_item, :class => PaymentsTracker::GeneralPaymentItem, :parent => :payment_item do    
    type "PaymentsTracker::GeneralPaymentItem"
  end

  factory :payer_payment, :class => PaymentsTracker::PayerPayment do    
    payment_item { FactoryGirl.create(:general_payment_item) }
    payer { FactoryGirl.create(:member) }
  end
end
