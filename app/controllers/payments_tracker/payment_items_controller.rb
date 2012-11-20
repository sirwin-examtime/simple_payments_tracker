require_dependency "payments_tracker/application_controller"

module PaymentsTracker
  class PaymentItemsController < ApplicationController

    def index
      @payment_items = PaymentItem.all
    end

    def new
      @payment_item = get_class.new
    end

    private 

    def get_class
      @@item_classes ||= {}
      return @@item_classes[params[:kind]] if @@item_classes.has_key? params[:kind]

      @@namespace ||= self.class.name.split('::').first
      @@base_class ||= controller_name.classify

      @@item_classes[params[:kind]] = "#{@@namespace}::#{params[:kind].capitalize}#{@@base_class}".constantize
    end

  end
end
