module Payments
  module Tracker
    class PaymentInstallment < ActiveRecord::Base
      validates_presence_of :receiver_type, :receiver_id
      validates :amount, :numericality => { :greater_than => 0.0 }

      belongs_to :receiver, :polymorphic => true

      before_create :set_time

      private

      def set_time
        self.received_at = Time.now
      end

    end
  end
end
