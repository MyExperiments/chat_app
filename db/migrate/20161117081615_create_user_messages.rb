#
# CreateUserMessages
#
# @author rashid
#
class CreateUserMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :user_messages do |t|
      t.integer :user_id
      t.integer :message_id
      t.boolean :is_read

      t.timestamps
    end
  end
end
