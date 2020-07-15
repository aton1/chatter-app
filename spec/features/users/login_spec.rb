require 'rails_helper'

RSpec.feature "Login" do
  let(:chatter) { create(:user) }
  let(:invalid_chatter) { build(:user, username: chatter.username) }

  context "when logging in as a chatter" do
    before do
      sign_in_as(chatter)
    end

    scenario "signs in as a chatter user" do
      expect(page).to have_content("Logged in successfully")
    end

    scenario "tries to sign in again" do
      visit "/login"

      expect(page).to have_content("You are already logged in")
    end
  end

  scenario "signs in with incorrect credentials" do
    sign_in_as(invalid_chatter)

    expect(page).to have_css(".negative.message")
  end
end
