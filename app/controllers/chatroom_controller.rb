class ChatroomController < ApplicationController
  def index
    @messages = Message.display_chat_feed
    @message = Message.new
    @users = User.display_online_users
  end
end
