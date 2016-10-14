module Api
  module V1
    #
    # ChatRoomsController
    #
    # @author rashid
    #
    class ChatRoomsController < ApiController
      include ChatRoomInitializer

      before_action :current_user_chat_rooms, only: [:create]
      # POST /api/v1/chatrooms
      def create
        initialize_chat_room
      end
    end
  end
end
