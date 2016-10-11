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
end
