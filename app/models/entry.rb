class Entry < ActiveRecord::Base
  belongs_to :person
  belongs_to :project

  validates :yesterday, presence: true, length: { maximum: 560 }
  validates :today, presence: true, length: { maximum: 560 }
  validates :block, length: { maximum: 560 }

  def self.for_today
    Entry.for_day DateTime.now
  end

  def self.for_day day
    Entry.where('created_at BETWEEN ? AND ?', day.beginning_of_day, day.end_of_day)
  end
end
