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

  describe "#invite_person" do
    let (:person) { Person.create! name: "Test User", email: "test@example.com" }
    let (:project) { Project.create! name: "Test Project", owner: person }

    before do
      ProjectMailer.stub(:invite_member).and_return true
    end

    it "does nothing if the person is already on the project" do
      old_person = Person.create! name: "Old User", email: "old@example.com"
      project.people << old_person
      ProjectMailer.should_receive(:invite_member).exactly(0).times
      project.invite_person old_person.email
      expect(project.people.count).to eq 2
    end

    it "does not create a new person if the person already exists" do
      old_person = Person.create! name: "Old User", email: "old@example.com"
      person # load the default person so that count change works right
      expect{ project.invite_person old_person.email }.to change{Person.count}.by 0
    end

    it "creates a person and adds them to the project" do
      project.invite_person "test2@example.com"
      person_count = project.people.count
      expect(person_count).to eq 2
    end

    it "destroys the invitation after it sends" do
      old_person = Person.create! name: "Old User", email: "old@example.com"
      project.invite_person old_person.email
      expect(old_person.invitations.count).to eq 0
    end
  end

  describe "#create_invitation" do
    let (:person) { Person.create! name: "Test User", email: "test@example.com" }
    let (:project) { Project.create! name: "Test Project", owner: person }
    
    it "creates an invitation" do
      invitation = project.create_invitation person
      expect(invitation).not_to be_nil
    end
  end
end
