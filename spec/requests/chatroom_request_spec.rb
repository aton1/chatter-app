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
  end

  it "doesn't display chatroom if user is not logged in" do
    get root_path

    expect(flash[:alert]).to include("You must be logged in to do that")
    expect(response).to redirect_to(login_path)
  end
end
