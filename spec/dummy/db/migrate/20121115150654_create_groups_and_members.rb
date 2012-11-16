class CreateGroupsAndMembers < ActiveRecord::Migration
  def up
    create_table :members do |t|
      t.string :name
      t.integer :group_id
    end
    create_table :groups do |t|
      t.string :name
    end
    create_table :admin_users do |t|
      t.string :name
    end
  end

  def down
    drop_table :admin_users
    drop_table :groups
    drop_table :members
  end
end
