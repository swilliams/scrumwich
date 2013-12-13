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

  describe "#create" do
    context "when a prior person is not found" do
      it "creates a Person for the email/name if one does not exist" do
        attrs = { person_name: "test", person_email: "test@example.com", entry: { yesterday: "worked on yesterday", today: "worked on today" }, project_id: 1 }
        expect{ post :create, attrs }.to change{Person.count}.by(1)
      end

      it "displays the error page if the new Person does not validate" do
        attrs = { project_id: 1 }
        post :create, attrs
        expect(response).to render_template(:new)
      end
    end

    it "displays the error page if the new Entry  does not validate" do
      attrs = { project_id: 1, person_name: "test", person_email: "test@example.com", entry: { yesterday: "" } }
      post :create, attrs
      expect(response).to render_template(:new)
    end

    it "adds the entry to the Person" do
      person = Person.create!(name: "Test User", email: "testuser@example.com")
      attrs = { person_name: person.name, person_email: person.email, entry: { yesterday: "worked on yesterday", today: "worked on today" }, project_id: 1 }
      expect{ post :create, attrs }.to change{person.entries.count}.by(1)
    end

  end
end
