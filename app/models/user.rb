#
# User
#
# @author sufinsha
#
class User < ApplicationRecord
  after_create :create_user_node
  after_update :update_user_node, if: :name_changed?

  has_many :user_messages, dependent: :destroy
  has_many :messages, through: :user_messages

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # mount carrier wave attchment uploader
  mount_uploader :user_pic, UserPicUploader

  # set authentication token and requested at
  def set_authentication_token(token = Devise.friendly_token)
    self.authentication_token = token
  end

  # Gender
  enum gender: [:male, :female]

  # search email with pattern
  def self.search_users(pattern)
    where('name LIKE ?', "#{pattern}%")
  end

  # creating new user node
  def create_user_node
    UserNode.create(name: name, user_id: id)
  end

  # editing user node
  def update_user_node
    user_node = UserNode.find_by(user_id: id)
    user_node.update(name: name) unless user_node.nil?
  end
end
