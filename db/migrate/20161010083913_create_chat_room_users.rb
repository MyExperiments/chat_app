#
# CreateChatRoomUsers
#
# @author sufinsha
#
class CreateChatRoomUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_room_users do |t|
      t.references :user, foreign_key: true
      t.references :chat_room, foreign_key: true

      t.timestamps
    end
  end
end
