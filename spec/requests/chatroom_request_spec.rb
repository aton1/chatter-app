require 'rails_helper'

RSpec.describe "Chatrooms", type: :request do
  let(:messages) { create_list(:message, 4) }
  
  it "displays chatroom as root path" do
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
