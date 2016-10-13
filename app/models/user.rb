#
# User
#
# @author sufinsha
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # set authentication token and requested at
  def set_authentication_token(token = Devise.friendly_token)
    self.authentication_token = token
  end
end
