#
# RemoveAttachmentUserPic
#
# @author rashid
#
class RemoveAttachmentUserPic < ActiveRecord::Migration[5.0]
  def change
    remove_attachment :users, :user_pic
  end
end
