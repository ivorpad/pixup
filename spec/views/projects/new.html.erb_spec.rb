require 'rails_helper'

RSpec.describe "projects/new.html.erb", type: :view do
  describe "adding projects" do
    it "allows users to create projects" do
      visit new_project_path

      fill_in "Title", with: "New Project Title"
      fill_in "Description", with: "New Project Description"
      click_on "Create Project"

      visit project_path
    end
  end
end
