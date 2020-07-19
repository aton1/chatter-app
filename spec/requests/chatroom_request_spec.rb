require 'rails_helper'

RSpec.describe "Chatroom", type: :request do
  let(:messages) { create_list(:message, 4) }
  let(:chatter) { create(:user) }

  context "when chatter is logged in" do
    before do
      sign_in_as(chatter)
    end

    it "displays chatroom" do
      get root_path

      expect(response).to be_successful
    end

    it "displays messages" do 
      messages.each do |message|
        get root_path

        expect(response.body).to include(message.body)
      end
    end

    it "displays online chatters" do
      get root_path

      expect(response.body).to include(chatter.username)
    end
  end
end
