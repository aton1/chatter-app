require 'rails_helper'

RSpec.describe "Chatrooms", type: :request do
  it "displays chatroom as root path" do
    get root_path

    expect(response).to be_successful
  end
end
