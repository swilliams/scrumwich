require 'spec_helper'

describe "Projects" do
  describe "GET /projects" do
    context "No projects" do

      before do
        Project.delete_all
        visit "/projects"
      end

      it "renders" do
        expect(page.status_code).to be(200)
      end
    end

    context "No current_user" do
      before do
        Person.delete_all
        visit "/projects"
      end

      it "renders" do
        expect(page.status_code).to be(200)
      end

      it "displays the 'need to be invited' message" do
        expect(page).to have_selector 'h2', text: 'You Need an Account'
      end

      it "does not display projects" do
        expect(page).not_to have_selector 'h2', text: "Available Projects"
        expect(page).not_to have_selector 'a.button', text: "Create a Project"
      end
    end

    context "When a current_user is available" do
      let (:email) { "test@example.com" }
      let (:person) { Person.create!(name: "Test Guy", email: email) }

      before do
        ApplicationController.any_instance.stub(:current_user).and_return person
        visit "/projects"
      end

      it "displays a list of projects" do
        expect(page).to have_selector 'h2', text: "Available Projects"
      end

    end
  end

  describe "GET /projects/[:id]" do
    let (:owner) { Person.create!(name: "Test Owner", email: "test@example.com") }
    let (:project) { Project.create!(name: "Test Project", owner: owner) }

    before do
      visit "/projects/#{project.id}"
    end

    it "renders" do
      expect(page.status_code).to be(200)
    end

    it "displays the project name" do
      expect(page).to have_selector 'h2', text: project.name
    end

    it "displays the last 10 days of the project" do
      expect(page.all("div.day").count).to eq 10
    end

  end
end
