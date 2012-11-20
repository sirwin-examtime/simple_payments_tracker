require 'spec_helper'

describe PaymentsTracker do

  before :all do
    @group = FactoryGirl.create(:group_with_members)
    @teacher = FactoryGirl.create(:teacher_user)
    @member = FactoryGirl.create(:member)
  end

  context "payment of installments for general payment items" do

    before :each do
      @gpi = FactoryGirl.create(:general_payment_item, :amount => 10.00, :grouping => @group)
    end

    it "should set the received_at time when the installment is saved" do
      ppr = FactoryGirl.create(:payer_payment, :payer => @member)
      ppr.payment_installments.new do |i|
        i.receiver = @teacher
        i.amount = 1.0
        i.save!

        assert( false == i.received_at.nil? )
        t = Time.now + 2.seconds
        assert( ((t-5.seconds)..t).cover? i.received_at )
      end
    end

    it "should prevent the payer model making installments" do
      pending "How do roles work?"
    end

    it "should disallow installments of 0.0" do
      @gpi.payer_payments.each do |pp|
        expect {
          pp.payment_installments.create!(:receiver => @teacher, :amount => 0.0)
        }.to raise_error
      end
    end

    it "should not close a payment item until all payers pay the necessary installments" do 
      assert( true == @gpi.open? )
      @gpi.payer_payments.each do |pp|
        pp.payment_installments.create(:receiver => @teacher, :amount => @gpi.amount / 2.0)
      end
      @gpi.reload
      assert( true == @gpi.open? )

      @gpi.payer_payments.each do |pp|
        pp.payment_installments.create(:receiver => @teacher, :amount => @gpi.amount / 2.0)
      end
      @gpi.reload
      assert( false == @gpi.open? )

    end

    it "should identify the outstanding amount for a payment item" do
      balance = 10.0
      9.times do 
        @gpi.payer_payments.each do |pp|
          pp.payment_installments.create(:receiver => @teacher, :amount => 1.0)
        end

        balance -= 1.0
        @gpi.payer_payments.each do |pp|
          assert( balance == pp.outstanding_amount )
        end
      end
      # Have paid 9.0 out of 10.0 for each payer
      @gpi.reload
      assert( true == @gpi.open? )

      @gpi.payer_payments.each do |pp|
        pp.payment_installments.create(:receiver => @teacher, :amount => 1.0)
      end
      @gpi.reload
      assert( false == @gpi.open? )
    end

    it "should not accept installment if it exceeds the total amount outstanding for this payer payment" do 
      assert( true == @gpi.open? )
      @gpi.payer_payments.each do |pp|
        expect {
          pp.payment_installments.create!(:receiver => @teacher, :amount => @gpi.amount + 1.0)
        }.to raise_error
      end
      @gpi.reload
      assert( true == @gpi.open? )
    end
  end

end
