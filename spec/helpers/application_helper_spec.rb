require 'spec_helper'

describe ApplicationHelper do

  describe "dashboard_title function" do
    it "should include the page title" do
      expect(dashboard_title("aloha")).to match(/aloha/)
    end

    it "should include the base dashboard title" do
      expect(dashboard_title("dragon")).to match(/^Boss Dashboard/)
    end

    it "should not include a bar for the home page" do
      expect(dashboard_title("")).not_to match(/\|/)
    end
  end
end
