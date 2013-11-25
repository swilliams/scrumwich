class Person < ActiveRecord::Base
  include Gravtastic
  gravtastic

  has_many :entries

  validates :name, presence: true
  validates :email, presence: true
end
