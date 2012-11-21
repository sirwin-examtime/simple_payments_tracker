module PaymentsTracker
  # This class supports simple payment items.  Most of the functionality is supplied by the base class.
  # 
  # The 'amount' attribute may only be set to 1 as it is redundant for a GeneralPaymentItem.
  class GeneralPaymentItem < PaymentItem

    validates :quantity, :numericality => { :equal_to => 1 }
    # Should move this alias out to a decorator in a separate edvance_payments_tracker gem!
    alias_attribute :per_pupil_amount, :amount

    # Should we disable the "amount" accessor?  Is there a clean way to do that?
    
    # @return [Array] returns an array of PayerPayment records for which there are outstanding installments
    def outstanding_payments
      payer_payments.select { |pp| !pp.paid_up? }
    end

  end
end
