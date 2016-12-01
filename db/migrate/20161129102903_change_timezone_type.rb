#
# ChangeTimezoneType
#
# @author rashid
#
class ChangeTimezoneType < ActiveRecord::Migration[5.0]
  def change
    change_column :user_locations, :time_zone, :string
  end
end
