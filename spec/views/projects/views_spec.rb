require 'rails_helper'

RSpec.describe "projects/views_spec.rb", type: :view do
  describe "CRUD projects" do
    let(:user) { create(:user) }

    before :each do
      login_as user, scope: :user
    end

    it "allows users to create projects" do
      visit new_project_path

      project = create(:project)

      fill_in "Title", with: project.title
      fill_in "Description", with: project.description
      click_on "Create Project"

      visit project_path(project.id)
      expect(page).to have_content(project.title)
    end

    it "allows to delete projects" do
      project = create(:project)

      visit project_path(project.id)
      click_on "Delete Project"

      expect(page).to have_content("The project has been deleted.")
    end
  end
end
