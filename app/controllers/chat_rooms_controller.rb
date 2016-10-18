#
# ChatRoomsController
#
# @author sufinsha
#
class ChatRoomsController < ApplicationController
  include ChatRoomInitializer

  before_action :current_user_chat_rooms, only: [:create]

  def show
    @chat_room = ChatRoom.includes(
      chat_room_users: :user, messages: :user
    ).find_by(id: params[:id])
  end

  def create
    initialize_chat_room
    @chat_room_html = render_to_string('_show', formats: [:html], layout: false, locals: { chat_room: @chat_room })
    if request.xhr?
      render partial: 'show', locals: { chat_room: @chat_room }
    else
      redirect_to chat_room_path(@chat_room)
    end
  end
end
