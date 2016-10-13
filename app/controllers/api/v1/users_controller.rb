module Api
  module V1
    #
    # UsersController
    #
    # @author sufinsha
    #
    class UsersController < ApiController
      # GET /api/v1/users.json
      def index
        @users = User.where.not(id: @current_user.id)
      end
    end
  end
end
