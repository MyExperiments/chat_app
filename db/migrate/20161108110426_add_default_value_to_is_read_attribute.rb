#
# AddDefaultValueToIsReadAttribute
#
# @author rashid
#
class AddDefaultValueToIsReadAttribute < ActiveRecord::Migration[5.0]
  def change
    change_column :messages, :is_read, :boolean, default: false
  end
end
