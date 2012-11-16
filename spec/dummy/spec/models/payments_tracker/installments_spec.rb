require 'spec_helper'

describe PaymentsTracker do

  before :all do
    @group = FactoryGirl.create(:group_with_members)
    @gpi = FactoryGirl.create(:general_payment_item, :amount => 10.00, :grouping => @group)
    @teacher = FactoryGirl.create(:teacher_user)
    @member = FactoryGirl.create(:member)
  end

  context "payment of installments" do

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

    it "should prevent member making installments" do
      pending "How do roles work?"
    end

    it "should disallow installments to be 0" do
      pending "NYI"
    end

    it "should close a payment item if all payers pay the necessary installments" do 
      @group.members.each do |member|
        ppr = PaymentsTracker::PayerPayment.find_by_payer_id_and_payer_type(member.id, member.class.to_s)
        ppr.payment_installments.new do |i|
          i.receiver = @member
          expect { i.save! }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end

  end

end
