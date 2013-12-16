require 'spec_helper'

describe "Entries" do
  describe "GET /projects/[id]/entries/today" do
    let (:owner) { Person.create!(name: "Test Owner", email: "test@example.com") }
    let (:project) { Project.create!(name: "Test Project", owner: owner) }

    before do
      visit "/projects/#{project.id}/entries/today"
    end

    it "renders" do
      expect(page.status_code).to eq 200
    end
  end
end
