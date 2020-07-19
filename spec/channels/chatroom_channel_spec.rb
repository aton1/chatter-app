require 'rails_helper'

RSpec.describe ChatroomChannel, type: :channel do
  let(:user) { create(:user) }

  before do
    stub_connection user_id: user.id
  end

  it "successfully subscribes" do
    subscribe

    expect(subscription).to be_confirmed
    expect(subscription.user_id).to eq(user.id)
    expect(subscription).to have_stream_from("chatroom_channel")
  end
end
