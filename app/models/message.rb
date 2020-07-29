class Message < ApplicationRecord
  belongs_to :user

  validates :body, presence: true

  scope :filter_messages, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }
  scope :display_chat_feed, -> { filter_messages.order(:created_at).last(30) }
end
