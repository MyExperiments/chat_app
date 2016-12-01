#
# ApplicationController
#
# @author sufinsha
#
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  # set time zone of the record with currentuser time zone
  def set_time_zone(&block)
    time_zone = if user_signed_in?
                  current_user.user_location.try(:time_zone) || 'UTC'
                else
                  'UTC'
                end
    Time.use_zone(time_zone, &block)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :user_pic, :gender])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :user_pic, :gender])
  end
end
