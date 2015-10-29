require 'rails_helper'

RSpec.describe User, type: :model do

  describe "user signs up" do
    before :each do
      visit new_user_registration_path
      @user = build(:user)
    end

    it "send email confirmation" do
      fill_in 'Name', with: @user.name
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password_confirmation

      click_on 'Sign up'
      expect(page).to have_content('A message with a confirmation link has been sent to your email address.')
    end

    it "name appears in the registrations#new form" do
      visit new_user_registration_path
      fill_in "Name", with: @user.name
    end

    it "is invalid without a name" do
      #DatabaseCleaner.clean
      user = build(:user, name: nil)

      fill_in 'Name', with: nil
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password_confirmation

      click_on 'Sign up'

      expect(page).to have_content('Name can\'t be blank')
    end

  end

end
