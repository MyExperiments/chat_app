#
# MessagesChannel
#
# @author sufinsha
#
class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "messages_channel_#{current_user.id}"
  end

  def received
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  # Creating new message
  def speak(data)
    @chat_room = find_chat_room(data['room_id'])
    return if @chat_room.blank?

    Message.create(
      user_id: current_user.id,
      chat_room_id: @chat_room.id,
      content: data['message']
    )
    broadcast_message(data['message'])
  rescue
    return
  end

  # Broadcast user is typing something
  def typing?(data)
    @chat_room = find_chat_room(data['room_id'])
    return if @chat_room.blank?
    broadcast_typing
  end

  def find_chat_room(uuid)
    ChatRoom.find_by(uuid: uuid)
  end

  private

  # broadcast message to reciever's message channel
  def broadcast_message(message)
    @chat_room.users.each do |reciever|
      ActionCable.server.broadcast(
        "messages_channel_#{reciever.id}",
        message: message,
        user: current_user.name,
        type: 'message',
        user_id: current_user.id,
        chat_room_uuid: @chat_room.uuid
      )
    end
  end

  # broadcast is typing to reciever's message channel
  def broadcast_typing
    @chat_room.users.each do |reciever|
      ActionCable.server.broadcast(
        "messages_channel_#{reciever.id}",
        user: current_user.name,
        type: 'status',
        typed_by: current_user.id,
        chat_room_uuid: @chat_room.uuid
      )
    end
  end
end
