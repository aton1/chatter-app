require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:message) { create(:message) }
  let(:messages) { create_list(:message, 31, user: message.user) }
  let(:user) { message.user }

  it "passes all validations" do
    expect(message).to be_valid
  end

  it "doesn't pass validation" do
    message.body = nil

    expect(message).not_to be_valid
  end

  it "belongs to a user" do
    expect(message.user_id).to eq(user.id)
    expect(Message.reflect_on_association(:user).macro).to eq(:belongs_to)
    expect(message).to respond_to(:user)
  end

  it "only allows 30 messages to display" do
    messages

    expect(Message.display_chat_feed.count).to eq(30)
  end
end
