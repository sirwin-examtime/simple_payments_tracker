module PaymentsTracker
  # This class implements the join table between a PaymentItem and its PaymentInstallments.
  #
  # The 'payer' attribute is a polymorphic type, allowing any class to make payments.  
  # Each payer can make many installments against the payment item.  The PaymentItem 
  # sub-classes may enforce restrictions on the amount of the installment.
  class PayerPayment < ActiveRecord::Base
    attr_accessible :payer
    belongs_to :payment_item
    belongs_to :payer, :polymorphic => true
    has_many :payment_installments

    # Only applies to GeneralPaymentItem (so far)
    # @return [Boolean] whether this Payer has made sufficient installments to cover the amount of the GeneralPaymentItem
    def paid_up?
      if payment_item.is_a? GeneralPaymentItem
        outstanding_amount <= 0.0
      else
        nil
      end
    end

    # Only applies to GeneralPaymentItem (so far)
    # If this method returns 0.00, then no more installments are required (nor can be made) and 'paid_up?' will return TRUE
    # @return [Decimal] amount of money outstanding for this Payer Payment i.e. the amount needed to fully pay for the GeneralPaymentItem
    def outstanding_amount
      if payment_item.is_a? GeneralPaymentItem
        [0.0, payment_item.amount - payment_installments.map(&:amount).sum].max
      else
        nil
      end
    end

  end
end
