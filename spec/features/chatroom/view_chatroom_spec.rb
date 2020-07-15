require 'rails_helper'

RSpec.feature "View Chatroom" do
  let(:chatter) { create(:user) }
  
  it "displays chatroom after logging in" do
    sign_in_as(chatter)

    expect(page).to have_css(".card")
  end

  it "doesn't display chatroom if not logged in" do
    visit "/"

    expect(page).to have_content("You must be logged in to do that")
  end
end
