require 'spec_helper'

describe Invitation do
  let (:invitation) { Invitation.new }

  describe "validation" do

    it "is invalid for an empty code" do
      invitation.code = nil
      expect(invitation.valid?).to eq false
    end

    it "is valid with a valid code" do
      invitation.code = "derp"
      expect(invitation.valid?).to eq true
    end
  end

  describe "#create_code" do
    it "creates a valid code" do
      invitation.create_code
      expect(invitation.code).not_to be_nil
    end
  end
end
