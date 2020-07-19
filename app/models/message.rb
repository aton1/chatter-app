class Message < ApplicationRecord
  belongs_to :user

  validates :body, presence: true

  scope :display_chat_feed, -> { order(:created_at).last(30) }
end
