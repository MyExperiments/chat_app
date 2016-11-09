#
# AddIsReadToMessages
#
# @author rashid
#
class AddIsReadToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :is_read, :integer
  end
end
