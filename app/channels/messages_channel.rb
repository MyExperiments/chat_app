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
    Message.create(
      user_id: current_user.id,
      chat_room_id: data['room_id'],
      content: data['message']
    )
  end

  def typing?(data)
    uuid = ChatRoom.find(data['room_id']).uuid
    ActionCable.server.broadcast(
      "messages_channel_#{uuid}", user: current_user.email, type: 'status',
                                  typed_by: current_user.id
    )
  end
end
