require 'rails_helper'

RSpec.feature "Delete Account" do
  let(:chatter) { create(:user) }

  context "when deleting an account" do
    before do
      sign_in_as(chatter)
    end

    scenario "signs in as a chatter" do
      expect(page).to have_content("Logged in successfully")
    end

    scenario "deletes their account" do
      visit "/users/#{chatter.id}/edit"
      click_link "Delete"
      expect(page).to have_content("Account was successfully deleted")
    end
  end
end
