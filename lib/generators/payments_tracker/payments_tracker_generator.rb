require 'rails/generators/migration'

class PaymentsTrackerGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  def self.source_root
    @_payments_trackers_source_root ||= File.expand_path("../templates", __FILE__)
  end

  def self.next_migration_number(path)
    Time.now.utc.strftime("%Y%m%d%H%M%S")
  end

  def create_model_file
    template "general_payment_item.rb", "app/models/general_payment_item.rb"
    template "payer_payment.rb", "app/models/payer_payment.rb"
    template "payment_installment.rb", "app/models/payment_installment.rb"
    template "payment_item.rb", "app/models/payment_item.rb"

    migration_template "create_payments_tracker_schema.rb", "db/migrate/create_payments_tracker_schema.rb"
  end
end
