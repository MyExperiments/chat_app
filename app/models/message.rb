#
# Message
#
# @author sufinsha
#
class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room
  def self.set_is_read_flag(chatroom_id)
    where(chat_room_id: chatroom_id, is_read: false).update_all(is_read: true)
  end
end
