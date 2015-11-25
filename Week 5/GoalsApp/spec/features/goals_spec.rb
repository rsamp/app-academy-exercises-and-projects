require 'spec_helper'
require 'rails_helper'

describe "the goals process", :type => :feature do

  def sign_in(user)
    visit new_session_url
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password
    click_on 'Sign In'
  end

  # before(:each) do
    # user_one = User.create(username: 'Billy', password: 'qwerty')
    # user_two = User.create(username: 'Genevieve', password: 'qwerty')
    let!(:user_one) { FactoryGirl.create(:user) }
    let!(:user_two) { FactoryGirl.create(:user) }
  # end

  #user_id
  #description
  #privacy_status
  #completion_status

  feature "Goals: user can" do
      let!(:goal_one) { FactoryGirl.build(:goal) }
      let!(:goal_two) { FactoryGirl.build(:goal) }

    scenario "reach goal creation page" do
      sign_in(user_one)
      visit goals_url
      click_on 'Create Goal'
      expect(page).to have_content "Create Goal"
    end

    def create_goal(goal, privacy)
      visit new_goal_url
      fill_in 'Description', with: goal.description
      choose privacy
      select 'Incomplete', from: "Complete?"
      click_on 'Create Goal'
    end

    scenario "create new goals for only themselves" do
      sign_in(user_one)
      create_goal(goal_one, "Public")
      expect(page).to have_content goal_one.description
    end

    scenario "edit own goals" do
      sign_in(user_one)
      create_goal(goal_one, "Public")
      click_on "Edit Goal"
      fill_in 'Description', with: "Changing description"
      click_on "Edit Goal"
      expect(page).to have_content "Changing description"
    end

    scenario "not edit others' goals" do
      sign_in(user_one)
      create_goal(goal_one, "Public")
      click_on "Sign Out"
      sign_in(user_two)
      click_on Goal.last.description
      expect(page).not_to have_content "Edit Goal"
    end

    scenario "delete own goals" do
      sign_in(user_one)
      create_goal(goal_one, "Public")
      click_on "Delete Goal"
      expect(page).to have_content "All Goals"
      expect(page).not_to have_content goal_one.description
    end

    scenario "not delete others' goals" do
      sign_in(user_one)
      create_goal(goal_one, "Public")
      click_on "Sign Out"
      sign_in(user_two)
      click_on Goal.last.description
      expect(page).not_to have_content "Delete Goal"
    end

    scenario "mark goals as 'Complete'" do
      sign_in(user_one)
      create_goal(goal_one, "Public")
      expect(page).to have_content "incomplete"
      click_on "mark as completed"
      expect(page).to have_content "complete"
    end

    scenario "view all of own goals" do
      sign_in(user_one)
      create_goal(goal_one, "Private")
      click_on "Goals Page"
      expect(page).to have_content goal_one.description
    end
  end
end
