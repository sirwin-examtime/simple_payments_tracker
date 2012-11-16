module PaymentsTracker
  class GeneralPaymentItem < PaymentItem
    validates :quantity, :numericality => { :equal_to => 1 }
    alias_attribute :per_pupil_amount, :amount

    # Should we disable the "amount" accessor?  Is there a clean way to do that?
    
  end
end
