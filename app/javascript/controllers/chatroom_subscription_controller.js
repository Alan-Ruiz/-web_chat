import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { chatroomId: Number, userId: Number}
  static targets = ["messages", "form"]

  connect() {
    this.createSubscription();
  }

  createSubscription() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue, user_id: this.userIdValue},
      { 
        received: data => {
          const isCurrentUser = data.user_id === this.userIdValue;
          this.#insertMessageAndScrollDown(data.message, isCurrentUser, data.id);
        },
        speak: function(data) {
          return this.perform('speak', data);
        }
      }
      )
    this.#scrollToBottom()
    console.log(`Subscribed to the chatroom with the id ${this.chatroomIdValue}.`)
  }


  handleFormSubmit(event) {
    event.preventDefault();
  
    let messageContent = this.formTarget.querySelector('input[name="message[content]"]').value;
  
    this.channel.speak({ message: messageContent });
  
    this.resetForm(event);
  }

  disconnect() {
    console.log("Unsubscribed from the chatroom")
    this.channel.unsubscribe()
  }

  resetForm(event) {
    event.target.reset()
  }

  #insertMessageAndScrollDown(message, isCurrentUser, id) {
    const messageElement = document.createElement('div');
    messageElement.innerHTML = message;
    const messageDiv = messageElement.querySelector(`#message-${id}`);
    if (isCurrentUser) {
      messageDiv.classList.add('message-right');
      messageDiv.classList.remove('message-left');
    } else {
      messageDiv.classList.add('message-left');
      messageDiv.classList.remove('message-right');
    }
    this.messagesTarget.appendChild(messageElement.firstChild);
    this.#scrollToBottom();
  }

  #scrollToBottom() {
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }
}