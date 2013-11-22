class Entry < ActiveRecord::Base
  belongs_to :person

  def self.for_today
    Entry.where('created_at BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day)
  end
end
