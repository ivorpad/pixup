require 'rails_helper'

RSpec.describe Project, type: :model do
  describe "Project validation" do
    it "title can't be blank" do
      visit new_project_path

      fill_in "Title", with: nil
      fill_in "Description", with: "New Project Description"
      click_on "Create Project"

      expect(page).to have_content("Title can't be blank")
    end

    it "description can't be blank" do
      visit new_project_path

      fill_in "Title", with: "My new title"
      fill_in "Description", with: nil
      click_on "Create Project"

      expect(page).to have_content("Description can't be blank")
    end

  end
end
