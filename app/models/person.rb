class Person < ActiveRecord::Base
  include Gravtastic
  gravtastic

  has_many :entries

  validates :name, presence: true, length: { maximum: 560 }
  validates :email, presence: true, length: { maximum: 560 }
end
