class Member < ActiveRecord::Base
  attr_accessible :name
  belongs_to :group
end
