# frozen_string_literal: true

class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    return unless params['id'] && params['user_id'] # added this as there was a first subsciption without params

    @chatroom = Chatroom.find(params[:id])
    @user = User.find(params[:user_id])
    stream_for @chatroom
  end

  def speak(data)
    message = current_user.messages.create!(content: data['message'], chatroom: @chatroom)
    socket = { id: message.id, message: render_message(message), type: 'message', user_id: params[:user_id]}
    self.class.broadcast_to(@chatroom, socket)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  private

  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message',
                                          locals: { message: message,
                                                    current_user: current_user })
  end
end
