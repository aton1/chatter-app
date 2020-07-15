require 'rails_helper'

RSpec.feature "Edit Account" do
  let(:chatter) { create(:user) }

  context "when user edits their account" do
    before do
      sign_in_as(chatter)
    end

    scenario "signs in as a chatter" do
      expect(page).to have_content("Logged in successfully")
    end

    scenario "edits their account" do
      visit "/users/#{chatter.id}/edit"
      fill_in "Username", with: "Updated - #{chatter.username}"
      click_on "Submit"

      expect(page).to have_content("Updated - #{chatter.username}")
    end

    scenario "clicks cancel" do
      visit "/users/#{chatter.id}/edit"
      click_link "Cancel"

      expect(current_path).to eq(user_path(chatter))
    end

    scenario "updates account to be invalid" do
      visit "/users/#{chatter.id}/edit"
      fill_in "Email", with: "a"
      click_button "Submit"

      expect(page).to have_css(".negative.message")
    end
  end

  context "when a nonuser tries to edit an account" do
    before do
      visit "/users/#{chatter.id}/edit"
    end

    scenario "nonuser will be shown a flash message" do
      expect(page).to have_content("You must be logged in to do that")
    end
  end
end
