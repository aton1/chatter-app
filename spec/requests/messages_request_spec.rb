require 'rails_helper'

RSpec.describe "Messages", type: :request do
  let(:chatter) { create(:user) }
  let(:message) { build(:message, user: chatter) }

  context "when chatter is logged in" do
    before do
      sign_in_as(chatter)
      create_new_message(message)
    end

    it "creates message" do
      expect(response).to redirect_to(root_path)
    end
  end

  it "doesn't create message if not logged in" do
    create_new_message(message)

    expect(flash[:alert]).to include("You must be logged in to do that")
    expect(response).to redirect_to(login_path)
  end
end
