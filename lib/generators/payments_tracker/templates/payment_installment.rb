module PaymentsTracker
  # This class supports a basic payment installment model.  An installment instance should not be created directly; it should only be created through the owning PayerPayment model.
  class PaymentInstallment < ActiveRecord::Base
    attr_accessible :receiver, :amount

    belongs_to :receiver, :polymorphic => true
    belongs_to :payer_payment
    has_one :payment_item, :through => :payer_payment

    validates_presence_of :receiver_type, :receiver_id
    validates :amount, :numericality => { :greater_than => 0.0, :less_than_or_equal_to => Proc.new { |p| p.payer_payment.outstanding_amount } }

    before_create :set_time
    after_save :update_payment_item

    private

    def set_time
      self.received_at = Time.now
    end

    def update_payment_item
      payment_item.close_if_closable!
    end

  end
end
