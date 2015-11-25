require 'spec_helper'
require 'rails_helper'

describe "the signin process", :type => :feature do

  feature "the signup process" do
    scenario "has a new user page" do
      visit new_user_url
      expect(page).to have_content "Sign Up"
    end

    feature "signing up a user" do
      let(:user) { FactoryGirl.build(:user) }
      scenario "ensures a password greater than 5 characters" do
        visit new_user_url
        fill_in 'Username', with: user.username
        fill_in 'Password', with: "asdf"
        click_on 'Sign Up'
        expect(page).to have_content "Password is too short"
      end
      scenario "shows username on the homepage after signup" do
        visit new_user_url
        fill_in 'Username', with: user.username
        fill_in 'Password', with: user.password
        click_on 'Sign Up'
        expect(page).to have_content user.username
      end
    end

  end

  feature "logging in and logging out" do
    # user = User.create(username: 'joe', password: 'qwerty')
    let!(:user) { FactoryGirl.create(:user) }

    scenario "begins with logged out state" do
      visit new_session_url
      expect(page).not_to have_content user.username
    end

    scenario "shows username on the homepage only when logged in" do
      visit new_session_url
      fill_in 'Username', with: user.username
      fill_in 'Password', with: user.password
      click_on 'Sign In'
      expect(page).to have_content user.username
      click_on 'Sign Out'
      expect(page).not_to have_content user.username
    end
  end

end
