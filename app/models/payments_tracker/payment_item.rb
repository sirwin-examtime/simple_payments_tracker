#SchoolClass.class_eval do
#  alias_attribute :group_members, :pupils
#end

module PaymentsTracker
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

    after_save :check_if_can_be_closed
    after_create :create_payer_payment_records

    def expirable?
      !expires_at.nil?
    end

    def expired?
      expirable? and expires_at.past?
    end

    def closable?
      !closed? and expired?
    end

    def open?
      !closed?
    end

    def closed?
      closed
    end

    def close!
      update_attribute(:closed, true)
    end
    
    def completed?
      closed?
    end

    private

    def check_if_can_be_closed
      if closable?
        close!
      end
    end

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
