require 'spec_helper'

describe Entry do
  let(:yesterday) { DateTime.now - 1 }

  before do
    p = Person.create!(name: "person1", email: "person@example.com")
    Entry.create!(yesterday: "stuff", today: "more stuff", person_id: p.id)
    Entry.create!(yesterday: "more stuff", today: "more stuff", person_id: p.id, created_at: yesterday)
  end

  describe "#for_day" do
    it "only gets entries for the provided day" do
      results = Entry.for_day yesterday
      expect(results.count).to eq(1)
    end
  end

  describe "#for_today" do
    it "only gets entries for today" do
      results = Entry.for_today
      expect(results.count).to eq(1)
    end
  end
end
