import consumer from "./consumer"

consumer.subscriptions.create("ChatroomChannel", {
  received(data) {
    const chatFeed = document.getElementById("chatroom-messages");

    chatFeed.insertAdjacentHTML("beforeend", data.chat_message);
    submitMessage();
    scrollToBottom();
  }
});
