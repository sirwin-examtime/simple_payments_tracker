FactoryGirl.define do
  factory :member, :class => Member do    
    sequence(:name) {|n| "Member#{n}"}
  end

  factory :group, :class => Group do    
    sequence(:name) {|n| "Group#{n}"}
  end

  factory :group_with_members, :parent => :group do    
    ignore do
      n 1
    end
    name "Group with members"
  
    after_build do | g, proxy |
      proxy.n.times { g.members << FactoryGirl.create(:member) }
    end
  end

  factory :teacher_user, :class => AdminUser do
    sequence(:name) {|n| "Teacher#{n}"}
  end

  factory :admin_user, :parent => :teacher_user do
    sequence(:name) {|n| "Admin#{n}"}
  end

end
