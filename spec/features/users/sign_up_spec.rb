require 'rails_helper'

RSpec.feature "Sign Up" do
  let(:chatter) { build(:user) }
  let(:invalid_chatter) { build(:user, email: "test@test") }

  context "when signing up" do
    before do
      sign_up_as(chatter)
    end

    scenario "signs up as a chatter user" do
      expect(page).to have_content("Welcome to Chatter, #{chatter.username}!")
      expect(page).to have_css(".content", text: chatter.username)
    end
  end

  scenario "signs up with incorrect credentials" do
    sign_up_as(invalid_chatter)

    expect(page).to have_css(".negative.message")
  end
end
