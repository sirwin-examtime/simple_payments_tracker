require 'spec_helper'

describe PaymentsTracker do

  context "validation of payment item creation" do

    it "should prevent creation of a base payment item" do
      FactoryGirl.build(:payment_item).should_not be_valid
    end

    it "should allow creation of a general payment item" do
      FactoryGirl.build(:general_payment_item).should be_valid
    end

    it "should allow creation of a multiple-quantity payment item" do
      pending "NYI"
    end

    it "should allow creation of an open-ended payment item" do
      pending "NYI"
    end

  end

end
