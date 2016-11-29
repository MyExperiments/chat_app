#
# RemoveAttachmentUserPic
#
# @author rashid
#
class AddUserPicToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :user_pic, :string
  end
end
