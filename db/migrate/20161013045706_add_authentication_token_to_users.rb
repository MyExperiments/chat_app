#
# AddAuthenticationTokenToUsers
#
# @author sufinsha
#
class AddAuthenticationTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :authentication_token, :string, index: true
  end
end
