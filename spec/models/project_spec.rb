require 'spec_helper'

describe Project do
  context "setup" do
    let (:proj) { Project.new(name: "test proj") }
    let (:owner) { Person.create!(name: "Test Guy", email: "test@example.com") }

    it "When the owner is set it is also added to the people list" do
      proj.owner = owner
      expect(proj.people).to include(owner)
    end

    it "Doesn't allow duplicate people" do
      person = Person.create!(name: "foo", email: "foo@example.com")
      proj.people << person
      proj.people << person
      expect(proj.people.length).to eq(1)
    end
  end

  describe "#last_10_days" do
    let (:person) { Person.create! name: "Test User", email: "test@example.com" }
    let (:project) { Project.create! name: "Test Project", owner: person }

    it "returns 10 items regardless" do
      result = project.last_10_days
      expect(result.count).to eq 10
    end

    it "records an entry entry for the row if one exists at the date" do
      project.entries.create!(yesterday: "old", today: "new", person: person, created_at: DateTime.now - 1)
      result = project.last_10_days
      expect(result[1].class).to eq ActiveRecord::AssociationRelation::ActiveRecord_AssociationRelation_Entry
    end

    it "records a datetime when entries do not exist for that date" do
      result = project.last_10_days
      expect(result[0].class).to eq DateTime
    end
  end
end
