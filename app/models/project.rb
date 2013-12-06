class Project < ActiveRecord::Base
  belongs_to :owner, class_name: :Person
  has_many :entries
  has_and_belongs_to_many :people, -> { uniq }

  validates :name, presence: true, length: { maximum: 40 }
  validates :owner, presence: true

  def owner=(val)
    people << val
    super val
  end
end
