require 'test_helper'

module PaymentsTracker
  class PaymentsControllerTest < ActionController::TestCase
    test "should get index" do
      get :index
      assert_response :success
    end
  
  end
end
