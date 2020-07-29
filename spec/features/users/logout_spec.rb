require 'rails_helper'

RSpec.feature "Login" do
  let(:chatter) { create(:user) }

  context "when a chatter is logging out" do
    before do
      sign_in_as(chatter)
    end

    scenario "chatter logs out" do
      sign_out

      expect(page).to have_content("Logged out successfully")
    end
  end
end
