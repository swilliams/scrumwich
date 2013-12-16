require 'spec_helper'

class DummyAppl
  include ApplicationHelper
end

describe ApplicationHelper do
  let (:dummy) { DummyAppl.new }

  describe "current_user" do
    it "returns a current_user if one already exists" do
      dummy.current_user = "derp"
      result = dummy.current_user
      expect(result).not_to be_nil
    end


    context "current_user is already nil" do
      before do
        dummy.stub(:retrieve_token).and_return "test@example.com"
      end

      it "looks up the user and sets it" do
        Person.create!(name: "test", email: "test@example.com")
        result = dummy.current_user
        expect(result.email).to eq("test@example.com")
      end

      it "returns nil if user could not be found" do
        result = dummy.current_user
        expect(result).to be_nil
      end
    end
  end

  describe "#long_formatted_date" do
    it "formats the date properly" do
      test_date = DateTime.new 2001,1,1
      result = dummy.long_formatted_date test_date
      expect(result).to eq "January 01, 2001"
    end
  end

  describe "#short_formatted_date" do
    it "formats the date properly" do
      test_date = DateTime.new 2001,1,1
      result = dummy.short_formatted_date test_date
      expect(result).to eq "01-01-2001"
    end
  end
end
