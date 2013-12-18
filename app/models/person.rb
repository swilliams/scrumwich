class Person < ActiveRecord::Base
  include Gravtastic
  gravtastic

  has_many :entries
  has_many :invitations
  has_and_belongs_to_many :projects

  validates :name, presence: true, length: { maximum: 560 }
  validates :email, presence: true, length: { maximum: 560 }
end
