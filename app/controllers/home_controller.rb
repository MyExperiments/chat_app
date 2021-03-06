#
# HomeController
#
# @author sufinsha
#
class HomeController < ApplicationController
  include ChatRoomInitializer
  before_action :current_user_chat_rooms, only: :index
  before_action :initialize_friends, only: :index
  before_action :unread_messages, only: :index

  # GET#index /home
  def index
    @users = User.where.not(id: @friends_ids << current_user.id)
    @friend_requests = UserNode.find_by(user_id: current_user.id)
                               .friend_requests
  end

  private

  # set users friends and friend requests
  def initialize_friends
    @friends_ids = UserNode.find_by(user_id: current_user.id)
                           .friends.to_a.map(&:user_id)
    @friends = User.where(id: @friends_ids)
  end
end
