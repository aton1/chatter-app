require 'rails_helper'

RSpec.feature "View Chatroom" do
  let(:chatter) { create(:user) }
  let(:message) { create(:message, user: chatter) }

  before do
    sign_in_as(chatter)
  end
  
  scenario "displays chatroom after logging in" do
    expect(page).to have_css(".card")
  end

  scenario "displays welcome text if there are no messages" do
    expect(page).to have_content("Welcome to Chatter...")
  end

  scenario "displays message" do
    post_new_message(message)

    expect(page).to have_content(message.user.username)
    expect(page).to have_content(message.body)
  end

  scenario "displays online users" do
    expect(page).to have_content(chatter.username)
  end
end
