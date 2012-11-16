module PaymentsTracker
  class PayerPayment < ActiveRecord::Base
    attr_accessible :payer
    belongs_to :payment_item
    belongs_to :payer, :polymorphic => true
    has_many :payment_installments

  end
end
