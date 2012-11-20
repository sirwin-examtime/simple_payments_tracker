require 'spec_helper'

describe PaymentsTracker do

  context "basic validation of expiry of general payment items" do

    it "should detect when an item expires" do
      gpi = FactoryGirl.create(:general_payment_item)

      gpi.update_attribute(:expires_at, nil)
      assert( false == gpi.expired? )

      gpi.update_attribute(:expires_at, Time.now + 1.day)
      assert( false == gpi.expired? )

      gpi.update_attribute(:expires_at, Time.now - 1.day)
      assert( true == gpi.expired? )
    end

  end

  context "validation of general payment items" do

    before :all do
      @gpi = FactoryGirl.create(:general_payment_item)
    end

    it "should have correct inheritance for a general payment item" do
      assert ( true == (@gpi.is_a? PaymentsTracker::PaymentItem) )
      assert ( true == (@gpi.is_a? PaymentsTracker::GeneralPaymentItem) )
    end

    it "should define the per_pupil_amount attribute for General Payment Items" do
      assert( @gpi.amount == @gpi.per_pupil_amount )
      @gpi.update_attribute(:per_pupil_amount, 12.99)
      assert( @gpi.amount == @gpi.per_pupil_amount )
    end

    it "should prevent creation of a payment item with a blank due/expiry date" do
      pi = FactoryGirl.build(:general_payment_item, :due_at => "", :expires_at => "")
      assert( true == pi.expires_at.nil? )
      assert( true == pi.due_at.nil? )
    end

    it "should prevent creation of a payment item with a due date in the past" do
      FactoryGirl.build(:general_payment_item, :due_at => (Date.current - 1.day)).should_not be_valid
      FactoryGirl.build(:general_payment_item, :due_at => (Date.current)).should be_valid
      FactoryGirl.build(:general_payment_item, :due_at => (Date.current + 1.day)).should be_valid
    end

    it "should prevent creation of a payment item with an expiry date in the past" do
      FactoryGirl.build(:general_payment_item, :expires_at => (Date.current - 1.day)).should_not be_valid
      FactoryGirl.build(:general_payment_item, :expires_at => (Date.current)).should be_valid
      FactoryGirl.build(:general_payment_item, :expires_at => (Date.current + 1.day)).should be_valid
    end

    it "should have helper to detect when a payment item is closed" do
      assert( false == @gpi.completed? )
      @gpi.update_attribute(:closed, true)
      assert( true == @gpi.completed? )
    end

    it "should not allow a quantity > 1 to be set for a general payment item" do
      FactoryGirl.build(:general_payment_item, :quantity => 2).should_not be_valid
    end

  end

  context "validation of auto-closing of payment items" do

    before :all do
      @gpi = FactoryGirl.create(:general_payment_item)
    end

    it "should automatically close when the expiry date is reached" do
      assert( false == @gpi.completed? )
      assert( false == @gpi.expired? )
      assert( true == @gpi.open? )

      # Bit of a hack to set the expiry to a date in the past; timeliness gem didn't seem to skip validations even if 
      # model.save(:validations => false) is used?
      @gpi.update_attribute(:expires_at, Time.now - 1.day)

      assert( true == @gpi.expired? )
      assert( true == @gpi.completed? )
      assert( true == @gpi.closed? )
    end

  end

  context "assignment of grouping to new payment item" do

    before :each do
      @group = FactoryGirl.create(:group_with_members, :n => 3)
      @gpi = FactoryGirl.create(:general_payment_item, :amount => 10.00, :grouping => @group)
    end

    it "should assign the grouping to a general payment item" do assert ( @gpi.grouping_id == @group.id )
    end

    it "should create payment records for each member of the group" do
      assert( @group.members.count == 3 )
      assert( @group.members.count == @gpi.payer_payments.count )
    end

  end

end
