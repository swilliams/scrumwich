require 'spec_helper'

describe "Entries" do
  let (:owner) { Person.create!(name: "Test Owner", email: "test@example.com") }
  let (:project) { Project.create!(name: "Test Project", owner: owner) }

  describe "GET /projects/[id]/entries/today" do

    before do
      visit "/projects/#{project.id}/entries/today"
    end

    it "renders" do
      expect(page.status_code).to eq 200
    end
  end

  describe "GET /projects/[id]/entries/new" do
    before do
      visit "/projects/#{project.id}/entries/new"
    end

    it "renders" do
      expect(page.status_code).to eq 200
    end

    context "submit" do
      before do
        Projects::EntriesController.any_instance.stub(:retrieve_token).and_return owner.email
      end

      it "creates a new entry on valid submit" do
        page.fill_in 'What Did You Work On Yesterday?', with: 'Old stuff'
        page.fill_in 'What Will You Work On Today?', with: 'New Stuff'
        page.click_on 'Add'

        expect(project.entries.count).to eq 1
        expect(current_url).to eq today_project_entries_url(project_id: project.id)
      end

      it "displays validation errors on bad input" do
        page.fill_in 'What Did You Work On Yesterday?', with: ''
        page.fill_in 'What Will You Work On Today?', with: ''
        page.click_on 'Add'

        expect(current_url).to eq project_entries_url(project_id: project.id)
        expect(page).to have_selector('h2', text: 'Errors')
      end
    end
  end
end
