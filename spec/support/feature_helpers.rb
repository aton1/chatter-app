module Helpers
  module FeatureHelpers
    def sign_up_as(user)
      visit sign_up_path
      fill_in "Email", with: user.email
      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_button "Sign Up"
    end

    def sign_in_as(user)
      visit login_path
      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_button "Login"
    end

    def sign_out
      click_link "Logout"
    end

    def post_new_message(message)
      visit root_path
      fill_in "message_body", with: message.body
      click_button "button"
    end
  end
end
