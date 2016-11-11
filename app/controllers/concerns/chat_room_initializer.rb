#
# ChatRoomInitializer
#
# @author rashid
#
module ChatRoomInitializer
  extend ActiveSupport::Concern

  # find chat room if already exists one, else create new
  def initialize_chat_room
    @chat_room = find_chat_room

    return if @chat_room.present?

    @chat_room = ChatRoom.create(
      is_group_chat: params[:is_group_chat], uuid: SecureRandom.uuid
    )

    @chat_room.users = chat_room_users
  end

  # find all users in a chat room
  def chat_room_users
    if params[:is_group_chat]
      User.where(id: params[:user_id]).to_a << current_user
    else
      [current_user, User.find(params[:user_id])]
    end
  end

  # find chatrooms of current user
  def current_user_chat_rooms
    is_group_chat = params[:is_group_chat].present? ? params[:is_group_chat] : FALSE_STR
    @chat_rooms = ChatRoom.joins(:chat_room_users).includes(
      chat_room_users: :user, messages: :user
    ).where(
      chat_rooms: { is_group_chat: is_group_chat },
      chat_room_users: { user_id: current_user.id }
    )
  end

  # if room_uuid present find chat room with uuid
  # else find private chat room of current user with requested user.
  def find_chat_room
    if params[:room_uuid].present?
      ChatRoom.find_by(uuid: params[:room_uuid])
    elsif params[:is_group_chat] == FALSE_STR
      find_one_to_one_chat_room
    end
  end

  # select chat room with participants length 2
  # and user_id equals requested user id
  def find_one_to_one_chat_room
    @chat_rooms.to_a.find do |chat_room|
      chat_room_users = chat_room.chat_room_users
      chat_room_users.length == 2 && chat_room_users.any? do |chat_room_user|
        chat_room_user.user_id == params[:user_id].to_i
      end
    end
  end

  # find userwise unread message count
  def unread_messages
    @user_wise_unread_messages = {}
    @chat_rooms.each do |chat_room|
      user_id = chat_room.chat_room_users
                         .where.not(user_id: current_user.id)
                         .first.user_id
      unread_message_count = chat_room.messages
                                      .where.not(user_id: current_user.id)
                                      .where(is_read: 0).count
      @user_wise_unread_messages[user_id] = unread_message_count
    end
  end
end
