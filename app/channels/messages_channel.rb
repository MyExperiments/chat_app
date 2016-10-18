#
# MessagesChannel
#
# @author sufinsha
#
class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "messages_channel_#{params[:roomId]}"
  end

  def received
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    chat_room = find_chat_room(data['room_id'])
    return if chat_room.blank?

    Message.create(
      user_id: current_user.id,
      chat_room_id: chat_room.id,
      content: data['message']
    )
  end

  def typing?(data)
    chat_room = find_chat_room(data['room_id'])

    return if chat_room.blank?

    ActionCable.server.broadcast(
      "messages_channel_#{chat_room.uuid}", user: current_user.email, type: 'status',
                                  typed_by: current_user.id
    )
  end

  def find_chat_room(uuid)
    ChatRoom.find_by(uuid: uuid)
  end
end
