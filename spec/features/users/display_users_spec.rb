require 'rails_helper'

RSpec.feature "Display Users" do
  let(:chatters) { create_list(:user, 3) }

  context "when viewing users logged in as a chatter" do
    before do
      sign_in_as(chatters[0])
    end

    scenario "signs in as a chatter" do
      expect(page).to have_content("Logged in successfully")
    end

    scenario "view users on the index page" do |users|
      visit "/users"
      users = User.all

      users.each do |user|
        expect(page).to have_content(user.username)
        expect(page).to have_content(user.description[0...97])
      end
    end

    scenario "has view button on index page" do
      visit "/users"

      expect(page).to have_css(".button")
    end

    scenario "views user show page with edit button" do
      visit "/users/#{chatters[0].id}"

      expect(page).to have_content(chatters[0].username)
      expect(page).to have_content(chatters[0].description)
      expect(page).to have_css(".button")
    end
  end
end
