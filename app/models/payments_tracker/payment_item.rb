#SchoolClass.class_eval do
#  alias_attribute :group_members, :pupils
#end

module PaymentsTracker
  # The base payment item
  # Uses STI; the 'type' attribute is required, thereby preventing instantiation of this base class.  
  # Making this class abstract would prevent use of STI?
  class PaymentItem < ActiveRecord::Base
    attr_accessible :title, :expires_at, :due_at

    validates_presence_of :type # nasty way to prevent instantiation of this class?  Don't want to make it abstract though; I want to use STI
    validates_presence_of :grouping_type, :owner_type, :grouping_id, :owner_id
    validates_date :expires_at, :on_or_after => lambda { Date.current }, :unless => Proc.new{|p| p.expires_at.nil?}
    validates_date :due_at,     :on_or_after => lambda { Date.current }, :unless => Proc.new{|p| p.due_at.nil?}

    belongs_to :grouping, :polymorphic => true
    belongs_to :owner, :polymorphic => true

    has_many :payer_payments
    has_many :payment_installments, :through => :payer_payments

    #after_update :check_if_can_be_closed
    after_update :close_if_closable!
    after_create :create_payer_payment_records

    # @return [String] the abbreviated name associated with this sub-class, used for View code
    def type_name
      type_name = type.sub('PaymentItem','')
      type_name.sub(/.*::/,'')
    end

    # @return [Boolean] whether this payment item has an 'expires_at' time set
    def expirable?
      !expires_at.nil?
    end

    # @return [Boolean] whether the 'expires_at' time on this payment item has past
    def expired?
      expirable? and expires_at.past?
    end

    # @return [Boolean] returns TRUE for open items that have expired or for which there are no outstanding payments. Returns false for closed items.
    def closable?
      !closed? and (expired? or 0 == outstanding_payments.size)
    end

    # @return [Boolean] whether this payment item is still open
    def open?
      !closed?
    end

    # @return [Boolean] whether this payment item is closed
    def closed?
      closed
    end

    # Forcibly closes this payment item
    def close!
      update_column(:closed, true)
    end
    
    # Closes this payment item if it is closable
    def close_if_closable!
      close! if closable?
    end

    private

    def create_payer_payment_records
      get_grouping.group_members.each do |member|
        payer_payments.create(:payer => member)
      end
    end 

    def get_grouping
      grouping_type.constantize.find(grouping_id)
    end

  end
end
