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
      return if @current_user.present?
      render json: {
        success: false, message: 'Invalid access'
      }
    end

    def set_current_user
      authenticate_or_request_with_http_token do |token, _options|
        @current_user = User.find_by(authentication_token: token)
      end
    end

    def default_success_flag
      @success = true
      @message = nil
    end
  end
end
