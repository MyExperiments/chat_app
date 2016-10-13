module Api
  #
  # BaseApiController
  #
  # @author sufinsha
  #
  class BaseApiController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!

    before_action :set_current_user
    before_action :authenticate_current_user
    before_action :default_success_flag

    respond_to :json

    private

    def authenticate_current_user
      if @current_user.blank?
        render json: {
          success: false, message: 'Invalid access'
        }
      end
    end

    def set_current_user
      @current_user = User.find_by(
        authentication_token: params[:authentication_token])
    end

    def default_success_flag
      @success = true
      @message = nil
    end
  end
end
