require 'spec_helper'

describe ProjectsController do

  let (:project) { create(:project) }
  let (:invitation) { Invitation.new project: project, person: create(:person) }

  describe "#join" do
    context "with a valid invitation code" do
      before do
        invitation.create_code
        invitation.save
      end

      it "is successful" do
        # looks up the invitation 
        get :join, id: invitation.code
        expect(response).to be_success
      end
    end

    context "without a valid invitation code" do
      it "renders 404"
    end
  end
end

