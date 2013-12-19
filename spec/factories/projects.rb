FactoryGirl.define do

  factory :owner, class: Person do
    name "Owner"
    email "owner@example.com"
  end

  factory :project do
    name "Test Project"
    owner
  end

  factory :person do
    name "Normal Person"
    email "test@example.com"
  end

  factory :person2, class: Person do
    name "Other Person"
    email "test2@example.com"
  end
end
