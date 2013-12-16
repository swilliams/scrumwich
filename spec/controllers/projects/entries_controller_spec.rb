require 'spec_helper'

describe Projects::EntriesController do
  let(:yesterday) { DateTime.now - 1 }

  before do
    p = Person.create!(name: "person1", email: "person@example.com")
    Entry.create!(yesterday: "stuff", today: "more stuff", person_id: p.id)
    Entry.create!(yesterday: "more stuff from yesterday", today: "more stuff", person_id: p.id, created_at: yesterday)
  end

  describe "#today" do
    it "is successful" do
      get :today, project_id: 1
      expect(response).to be_success
    end
  end

  describe "#show" do
    it "is successful" do
      get :show, id: "#{yesterday.strftime("%m-%d-%Y")}", project_id: 1
      expect(response).to be_success
    end
  end

  describe "#new" do
    it "is successful" do
      get :new, project_id: 1
      expect(response).to be_success
    end
  end

end
