#
# HomeHelper
#
# @author rashid
#
module UsersHelper
  # To check whether request already exists
  #
  # @return boolean
  def friend_request_exist(requestee_id, requester_id)
    requestee = UserNode.find_by(user_id: requestee_id)
    requester = UserNode.find_by(user_id: requester_id)
    if requestee.friend_requests.map(&:user_id).include?(requester_id)
      render partial: 'users/cancel_request', locals: { user_id: requestee_id }
    elsif requester.friend_requests.map(&:user_id).include?(requestee_id)
      render partial: 'users/accept_request', locals: { user_id: requestee_id }
    else
      render partial: 'users/send_request', locals: { user_id: requestee_id }
    end
  end
end
