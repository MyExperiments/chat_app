class AddAttachmentToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :attachment, :string
  end
end
