#
# CreateChatRooms
#
# @author sufinsha
#
class CreateChatRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_rooms do |t|
      t.string :uuid
      t.string :title
      t.string :is_group_chat

      t.timestamps
    end
  end
end
