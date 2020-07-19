require 'rails_helper'

RSpec.feature "Create New Message" do
  let(:chatter) { create(:user) }
  let(:message) { build(:message) }
  
  context "when logged in as a chatter" do
    before do
      sign_in_as(chatter)
    end

    scenario "displays chatroom after logging in" do
      expect(page).to have_css(".card")
    end

    scenario "posts a new message" do
      post_new_message(message)

      expect(page).to have_content(message.body)
    end
  end

  context "when not logged in as a chatter" do
    scenario "doesn't post new mesasge if not logged in" do
      visit root_path
      post_new_message(message)
  
      expect(page).to have_content("You must be logged in to do that")
    end
  end
end
