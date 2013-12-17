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

    context "project info" do
      before do
        visit "/projects/#{project.id}"
      end

      it "renders" do
        expect(page.status_code).to eq 200
      end

      it "displays the project name" do
        expect(page).to have_selector 'h2', text: project.name
      end

      it "displays the last 10 days of the project" do
        expect(page.all("div.row-day").count).to eq 10
      end
    end

    context "people in the project" do
      before do
        dummy_person1 = Person.create! name: "person 1", email: "person1@example.com"
        dummy_person2 = Person.create! name: "person 2", email: "person2@example.com"
        project.people << dummy_person1
        project.people << dummy_person2
        
        visit "/projects/#{project.id}"
      end

      it "displays the list of people on the project" do
        expect(page.all(".person").count).to eq 3
      end

    end
  end

  describe "GET /projects/new" do
    let (:owner) { Person.create!(name: "Test Owner", email: "test@example.com") }

    context "with a valid user" do
      before do
        ApplicationController.any_instance.stub(:current_user).and_return owner
        visit "/projects/new"
      end

      it "renders the form" do
        expect(page).to have_selector 'h2', text: 'New Project' 
      end

      context "the form is submitted" do
        it "renders an error if the name is blank" do
          page.fill_in 'Name', with: ''
          page.click_on 'Add'
          expect(current_url).to eq projects_url
          expect(page).to have_selector('h2', text: 'Errors')
        end

        it "redirects to the project itself when valid" do
          page.fill_in 'Name', with: 'New Test Project'
          page.click_on 'Add'
          new_project = Project.last
          expect(current_url).to eq project_url(id: new_project.id)
          expect(page).to have_selector 'h2', text: 'New Test Project'
        end
      end
    end

    context "without a valid user" do
      it "renders the no user template if no user is found" do
        visit "/projects/new"
        expect(page).to have_selector 'h2', text: 'You Need an Account'
      end
    end
  end
end
