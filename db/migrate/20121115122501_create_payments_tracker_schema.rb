class CreatePaymentsTrackerSchema < ActiveRecord::Migration
  def up
    create_table :payments_tracker_payment_items do |t|
      t.string :title, :null => false
      t.string :description
      t.datetime :due_at
      t.datetime :expires_at
      t.boolean :closed, :default => false, :null => false
      t.string :type
      t.decimal :amount, :precision => 8, :scale => 2, :default => 0.0, :null => false
      t.integer :quantity, :default => 1, :null => false
      t.references :owner, :polymorphic => true
      t.references :grouping, :polymorphic => true
      t.timestamps
    end

    add_index :payments_tracker_payment_items, :type
    add_index :payments_tracker_payment_items, :owner_type
    add_index :payments_tracker_payment_items, :owner_id
    add_index :payments_tracker_payment_items, :grouping_type
    add_index :payments_tracker_payment_items, :grouping_id

    create_table :payments_tracker_payer_payments do |t|
      t.integer :payments_tracker_payment_item_id, :null => false
      t.references :payer, :polymorphic => true
    end
    
    create_table :payments_tracker_payment_installments do |t|
      t.integer :payments_tracker_payer_payment_id, :null => false
      t.decimal :amount, :precision => 8, :scale => 2, :default => 0.0, :null => false
      t.integer :quantity, :default => 1, :null => false
      t.string :type
      t.string :comments
      t.datetime :received_at
      t.references :receiver, :polymorphic => true
    end

    add_index :payments_tracker_payment_installments, :payments_tracker_payer_payment_id, { :name => 'pt_installments_on_payer_payment' }
    add_index :payments_tracker_payment_installments, :type
    add_index :payments_tracker_payment_installments, :receiver_type
    add_index :payments_tracker_payment_installments, :receiver_id

  end

  def down
    drop_table :payments_tracker_payment_installments
    drop_table :payments_tracker_payer_payments
    drop_table :payments_tracker_payment_items
  end
end
