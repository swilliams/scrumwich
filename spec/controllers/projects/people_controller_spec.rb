require 'spec_helper'

describe Projects::PeopleController do
  let (:owner) { Person.create! name: "Owner", email: "owner@example.com" }
  let (:project) { Project.create! name: "test project", owner: owner }
  let (:person) { Person.create! name: "Guy", email: "test@example.com" }

  describe "#destroy" do
    it "removes a person from a project" do
      project.people << person
      delete :destroy, id: person.id, project_id: project.id
      result = Project.find(project.id)
      expect(result.person_ids).to eq [owner.id]
    end
  end
end
