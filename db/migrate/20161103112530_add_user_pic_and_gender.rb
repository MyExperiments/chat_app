#
# AddUserPicAndGender
#
# @author rashid
#
class AddUserPicAndGender < ActiveRecord::Migration[5.0]
  def change
    add_attachment :users, :user_pic
    add_column :users, :gender, :integer
  end
end
