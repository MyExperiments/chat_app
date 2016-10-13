module ApplicationCable
  #
  # Connection
  #
  # @author sufinsha
  #
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    protected

    def find_verified_user
      current_user = ws_current_user
      if current_user
        current_user
      else
        reject_unauthorized_connection
      end
    end

    def ws_current_user
      if request.headers['AuthenticationToken'].present?
        User.find_by(authentication_token: request.headers['AuthenticationToken'])
      else
        User.find_by(id: cookies.signed['user.id'])
      end
    end
  end
end
