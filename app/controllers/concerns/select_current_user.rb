#
# SelectCurrentUser module
#
# @author rashid
#
module SelectCurrentUser
  extend ActiveSupport::Concern
  def set_current_user
    authenticate_or_request_with_http_token do |token, _options|
      @current_user = User.find_by(authentication_token: token)
    end
  end
end
