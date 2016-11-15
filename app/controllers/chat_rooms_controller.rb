#
# ChatRoomsController
#
# @author sufinsha
#
class ChatRoomsController < ApplicationController
  include ChatRoomInitializer

  before_action :current_user_chat_rooms, only: [:create, :unread_messages]

  def show
    @chat_room = ChatRoom.includes(
      chat_room_users: :user, messages: :user
    ).find_by(id: params[:id])
  end

  def create
    initialize_chat_room
    @user = @chat_room.chat_room_users.where.not(user_id: current_user.id).first.user
    if request.xhr?
      Message.set_is_read_flag(@chat_room.id)
      render partial: 'show', locals: { chat_room: @chat_room, user: @user }
    else
      redirect_to chat_room_path(@chat_room)
    end
  end

  # GET #chat_room_messages /chat_rooms
  def chat_room_messages
    @messages = ChatRoom.find_by(uuid: params[:chat_room_uuid]).messages.includes(:user).page(params[:page]).per(15)
    if @messages.blank?
      render json: { last_page: true } if @messages.blank?
    else
      render partial: 'chat_rooms/messages', locals: { messages: @messages }
    end
  end
end
