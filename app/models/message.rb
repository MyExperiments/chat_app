#
# Message
#
# @author sufinsha
#
class Message < ApplicationRecord
  after_create :create_user_message

  belongs_to :user
  belongs_to :chat_room
  has_many :user_messages, dependent: :destroy

  # mount carrier wave attchment uploader
  mount_uploader :attachment, AttachmentUploader

  # Set is read flag to true
  def self.set_is_read_flag(chatroom_id)
    where(chat_room_id: chatroom_id, is_read: false).update_all(is_read: true)
  end

  # Create user message for chatroom users
  def create_user_message
    chat_room.users.each do |chat_room_user|
      UserMessage.create(message_id: id, user_id: chat_room_user.id, is_read: chat_room_user.id == user_id)
    end
  end
end
