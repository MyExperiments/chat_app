#
# Message
#
# @author sufinsha
#
class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  after_create_commit do
    ActionCable.server.broadcast(
      "messages_channel_#{chat_room.uuid}",
      message: content, user: user.email, type: 'message'
    )
  end
end
