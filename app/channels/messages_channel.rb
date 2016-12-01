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
    # sidekiq worker for saving and broadcasting message
    MessageWorker.perform_async(current_user.id, @chat_room.id, data['message'])
  end

  # Broadcast user is typing something
  def typing?(data)
    @chat_room = find_chat_room(data['room_id'])
    return if @chat_room.blank?
    # broadcast_typing
    broadcast('status')
  end

  # find chat room
  def find_chat_room(uuid)
    ChatRoom.find_by(uuid: uuid)
  end

  private

  # Broadcast message or typing status
  def broadcast(type, msg = nil)
    hash = { user: current_user.name, type: type, user_id: current_user.id,
             chat_room_uuid: @chat_room.uuid }
    hash[:message] = msg if msg.present?
    @chat_room.users.each do |reciever|
      ActionCable.server.broadcast("messages_channel_#{reciever.id}", hash)
    end
  end
end
