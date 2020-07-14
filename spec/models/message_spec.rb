require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:message) { create(:message) }
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
end
