require 'spec_helper'

describe PaymentsTracker do

  #include Payments::Tracker

  before :all do
    @group = FactoryGirl.create(:group_with_members, :n => 3)
    @gpi = FactoryGirl.create(:general_payment_item, :amount => 10.00, :grouping => @group)
  end

  context "assignment of grouping to new payment item" do

    it "should assign the grouping to a general payment item" do
      assert ( @gpi.grouping_id == @group.id )
    end

    it "should create payment records for each member of the group" do
      assert( @group.members.count == 3 )
      assert( @group.members.count == @gpi.payer_payments.count )
    end

  end

end
