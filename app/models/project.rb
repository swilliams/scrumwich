class Project < ActiveRecord::Base
  belongs_to :owner, class_name: :Person
  has_many :entries
  has_and_belongs_to_many :people

  validates :name, presence: true, length: { maximum: 40 }
  validates :owner, presence: true
end
