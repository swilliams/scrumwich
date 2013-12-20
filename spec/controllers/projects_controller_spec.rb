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
        get :join, code: invitation.code, id: project.id
        expect(response).to be_success
      end

      it "destroys the invitation" do
        inv_id = invitation.id
        get :join, code: invitation.code, id:project.id
        result = Invitation.find_by(id: inv_id)
        expect(result).to be_nil
      end

      it "stores the proper auth token in cookies" do
        controller.should_receive(:store_token).once.with(invitation.person.email)
        get :join, code: invitation.code, id:project.id
      end
    end

    context "problems" do
      it "renders 404 with an invalid invitation code" do
        get :join, code: "", id: project.id
        expect(response.status).to eq 404
      end

      it "renders 404 if the invitation code is not tied to a the requested project" do
        invitation.project_id = -1
        invitation.create_code
        invitation.save
        get :join, id: project.id, code: invitation.code
        expect(response.status).to eq 404
      end
    end
  end
end

