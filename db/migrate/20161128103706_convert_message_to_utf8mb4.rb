#
# ConvertMessageToUtf8mb4
#
# @author rashid
#
class ConvertMessageToUtf8mb4 < ActiveRecord::Migration[5.0]
  def change
    # for each string/text column with unicode content execute:
    execute 'ALTER TABLE messages CHANGE content content VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin'
  end
end
