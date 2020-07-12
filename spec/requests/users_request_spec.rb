require 'rails_helper'

RSpec.describe "Users", type: :request do
 let(:chatter) { create(:user) }
 let(:chatter2) { create(:user) }
 let(:new_chatter) { build(:user) }
 let(:params) { { user: { username: new_chatter.username, email: new_chatter.email, password: new_chatter.password } } }
 let(:invalid_params) { { user: { username: "abcd", email: "test", password: "password" } } }

  it "users#index" do
    get users_path

    expect(response).to be_successful
  end

  it "users#show" do
    get user_path(chatter)

    expect(response).to be_successful
  end

  it "users#new" do
    get sign_up_path

    expect(response).to be_successful
  end

  context "when users#edit" do
    it "edits user info if signed in and same user" do
      sign_in_as(chatter)
      get edit_user_path(chatter)

      expect(response).to be_successful
    end

    it "can't edit user info if signed in but not same user" do
      sign_in_as(chatter)
      get edit_user_path(chatter2)

      expect(flash[:alert]).to include("You can only make changes to your own account")
    end

    it "can't edit user info if not signed in" do
      get edit_user_path(chatter)

      expect(flash[:alert]).to include("You must be logged in to do that")
    end
  end

  context "when users#create" do
    it "creates new user" do
      post users_path, params: params

      expect(response).to redirect_to(root_path)
    end

    it "renders new form if user entered in invalid info" do
      post users_path, params: invalid_params

      expect(response.body).to include("Sign Up")
    end
  end

  context "when users#update" do
    before do
      sign_in_as(chatter)
    end

    it "updates user info" do
      patch user_path(chatter), params: { user: { username: "upd_username" } }

      expect(response).to redirect_to(user_path(chatter))
    end

    it "can only update user's own info" do
      patch user_path(chatter2), params: { user: { username: "upd_username" } }

      expect(flash[:alert]).to include("You can only make changes to your own account")
    end

    it "renders edit form if there were errors" do
      patch user_path(chatter), params: { user: { username: "a" } }

      expect(response.body).to include("Edit")
    end
  end

  context "when users#destroy" do
    before do
      sign_in_as(chatter)
    end

    it "deletes user account" do
      delete user_path(chatter)

      expect(response).to redirect_to(root_path)
    end

    it "can only delete user's own account" do
      delete user_path(chatter2)

      expect(flash[:alert]).to include("You can only make changes to your own account")
    end
  end
end
