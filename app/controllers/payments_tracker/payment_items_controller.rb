require_dependency "payments_tracker/application_controller"

module PaymentsTracker
  class PaymentItemsController < ApplicationController
    def index
      @payment_items = PaymentItem.all
    end
  end
end
