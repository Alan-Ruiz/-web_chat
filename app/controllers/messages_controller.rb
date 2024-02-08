# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :set_chatroom, only: [:create]
  before_action :build_message, only: [:create]

  def create
    if @message.save
      broadcast_message
      head :ok
    else
      render 'chatrooms/show', status: :unprocessable_entity
    end
  end

  private

  def set_chatroom
    @chatroom = Chatroom.find(params[:chatroom_id])
  end

  def build_message
    @message = @chatroom.messages.build(message_params)
    @message.user = current_user
  end

  def broadcast_message
    ChatroomChannel.broadcast_to(
      @chatroom,
      render_to_string(partial: 'message', locals: { message: @message })
    )
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
