require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:chatter) { create(:user, active: true) }
  let(:chatter2) { create(:user) }
  let(:invalid_chatter) { build(:user) }

  context "when logging in" do
    it "displays login page" do
      get login_path
      
      expect(response).to be_successful
    end

    it "user logs in successfully" do
      sign_in_as(chatter)

      expect(chatter.active).to be_truthy
      expect(session[:user_id]).to eq(chatter.id)
      expect(flash[:notice]).to include("Logged in successfully")
      expect(response).to redirect_to(root_path)
    end

    it "user doesn't log in successfully" do
      sign_in_as(invalid_chatter)

      expect(flash[:alert]).to include("Username or password entered is incorrect")
      expect(response.body).to include("Login")
    end

    it "user can't login again" do
      sign_in_as(chatter)
      get login_path

      expect(flash[:alert]).to include("You are already logged in")
      expect(response).to redirect_to(root_path)
    end
  end

  context "when logging out" do
    it "user logs out successfully" do
      sign_in_as(chatter2)
      sign_out_as(chatter2)

      expect(chatter2.active).to be_falsey
      expect(session[:user_id]).to be_nil
      expect(flash[:notice]).to include("Logged out successfully")
      expect(response).to redirect_to(login_path)
    end
  end
end
