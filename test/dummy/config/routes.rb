Rails.application.routes.draw do

  mount PaymentsTracker::Engine => "/payments_tracker"
end
