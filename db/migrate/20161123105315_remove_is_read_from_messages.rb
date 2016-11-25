#
# RemoveIsReadFromMessages
#
# @author rashid
#
class RemoveIsReadFromMessages < ActiveRecord::Migration[5.0]
  def change
    remove_column :messages, :is_read, :boolean
  end
end
