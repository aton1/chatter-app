require 'rails_helper'

RSpec.describe "Messages", type: :request do
  let(:chatter) { create(:user) }
  let(:message) { build(:message, user: chatter) }
  let(:broadcast) { ActionCable.server.broadcast("chatroom_channel", chat_message: message.body) }

  context "when chatter is logged in" do
    before do
      sign_in_as(chatter)
      create_new_message(message)
    end

    it "creates message" do
      expect(response).to be_successful
    end

    it "broadcasts message" do
      expect{ broadcast }.to have_broadcasted_to("chatroom_channel")
    end
  end

  it "doesn't create message if not logged in" do
    create_new_message(message)

    expect(flash[:alert]).to include("You must be logged in to do that")
    expect(response).to redirect_to(login_path)
  end
end
