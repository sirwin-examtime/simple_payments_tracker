module PaymentsTracker
  # This is the Rails engine to establish the Payments Tracker functionality in its own namespace
  class Engine < ::Rails::Engine
    isolate_namespace PaymentsTracker
  end
end
