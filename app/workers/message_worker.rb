#
# MessageWorker
#
# @author rashid
#
class MessageWorker
  include Sidekiq::Worker
  def perform(user_id, chat_room_id, message)
    Message.create(
      user_id: user_id,
      chat_room_id: chat_room_id,
      content: message
    )
    @chat_room = ChatRoom.find(chat_room_id)
    hash = { type: 'message',
             user_id: user_id,
             chat_room_uuid: @chat_room.uuid,
             message: message }
    @chat_room.users.each do |reciever|
      ActionCable.server.broadcast("messages_channel_#{reciever.id}", hash)
    end
  end
end
