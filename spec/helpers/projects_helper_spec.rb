require 'spec_helper'

class DummyProject
  include ProjectsHelper
end

describe ProjectsHelper do
  describe "emails_from_lines" do
    it "returns an array of emails" do
      helper = DummyProject.new
      text = <<-eos
        test@example.com
        test2@example.com
        test3@example.com
      eos
      result = helper.emails_from_lines text
      expect(result.count).to eq 3
    end
  end
end
