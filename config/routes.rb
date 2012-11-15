PaymentsTracker::Engine.routes.draw do
  root :to => 'payment_items#index'
end
