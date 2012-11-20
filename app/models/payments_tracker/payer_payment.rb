module PaymentsTracker
  class PayerPayment < ActiveRecord::Base
    attr_accessible :payer
    belongs_to :payment_item
    belongs_to :payer, :polymorphic => true
    has_many :payment_installments

    def paid_up?
      payment_installments.map(&:amount).sum >= payment_item.amount
    end

    def outstanding_amount
      [0.0, payment_item.amount - payment_installments.map(&:amount).sum].max
    end

  end
end
