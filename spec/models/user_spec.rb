require 'rails_helper'

RSpec.describe User, type: :model do
  let(:chatter) { create(:user) }
  let(:invalid_chatter) { build(:user) }
  let(:messages) { create_list(:message, 3, user: chatter) }

  it "passes all validations" do
    expect(chatter).to be_valid
    expect(User.count).to be(1)
  end

  context "when entering an invalid username" do
    it "validates presence" do
      invalid_chatter.username = nil

      expect(invalid_chatter).not_to be_valid
    end

    it "validates length" do
      invalid_chatter.username *= 100
      
      expect(invalid_chatter).not_to be_valid
    end

    it "validates uniqueness" do
      invalid_chatter.username = chatter.username

      expect(invalid_chatter).not_to be_valid
    end
  end

  context "when entering an invalid email" do
    it "validates email" do
      invalid_chatter.email = nil

      expect(invalid_chatter).not_to be_valid
    end

    it "validates length" do
      invalid_chatter.email *= 200

      expect(invalid_chatter).not_to be_valid
    end

    it "validates uniqueness" do
      invalid_chatter.email = chatter.email

      expect(invalid_chatter).not_to be_valid
    end

    it "validates format" do
      invalid_chatter.email = "test@test"

      expect(invalid_chatter).not_to be_valid
    end
  end

  context "when entering an invalid description" do
    it "validates length" do
      invalid_chatter.description *= 300

      expect(invalid_chatter).not_to be_valid
    end
  end

  it "has many messages" do
    messages.all? do |message|
      expect(message.user_id).to eq(chatter.id)
    end

    expect(User.reflect_on_association(:messages).macro).to eq(:has_many)
    expect(chatter).to respond_to(:messages)
  end

  it "destroys all messages belonging to a user" do
    messages.all? do |message|
      chatter.destroy

      expect(chatter.messages.count).to be(0)
    end
  end
end
