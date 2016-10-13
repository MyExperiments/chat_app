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

      # GET /api/v1/users/:id
      def show
        @user = User.find_by(id: params[:id])
      end
    end
  end
end
