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
end
