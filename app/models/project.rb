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

  def last_10_days
    (0..9).map do |days_back|
      date = DateTime.now - days_back
      results = entries.for_day date
      results.empty? ? date : results
    end
  end
end
