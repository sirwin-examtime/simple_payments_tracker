class Group < ActiveRecord::Base
  attr_accessible :name, :members
  has_many :members
  alias_attribute :group_members, :members
end

