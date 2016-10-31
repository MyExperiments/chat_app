#
# UsersController
#
# @author rashid
#
class UsersController < ApplicationController
  include BroadcastRequests

  # GET#index /users
  def index
    find_friends
    @users = User.search_users(params[:name]).select { |x| @friend_ids.include?(x.id) }
    render partial: 'users/friend_list', locals: { users: @users } if request.xhr?
  end

  # GET#friend_request /users
  def friend_request
    select_nodes
    @requestee_node.friend_requests << @requester_node
    broadcast_friend_request
    if request.xhr?
      render partial: 'users/cancel_request', locals: { user_id: @requestee_node.user_id }
    else
      format.json json: { status: 'success' }
    end
  end

  # GET#cancel_request /users
  def cancel_request
    select_nodes
    requester_node = @requester_node
    @requestee_node.friend_requests(:requester_node, :rel).match_to(requester_node).delete_all(:rel)
    broadcast_cancel_request
    if request.xhr?
      render partial: 'users/send_request', locals: { user_id: @requestee_node.user_id }
    else
      format.json json: { status: 'success' }
    end
  end

  # GET#accept_request /users
  def accept_request
    select_nodes
    requestee_node = @requestee_node
    @requestee_node.friends << @requester_node
    @requester_node.friend_requests(:requestee_node, :rel).match_to(requestee_node).delete_all(:rel)
    broadcast_request_acceptance
    render json: { status: 'success' }
  end

  # GET#unfriend_user /users
  def unfriend_user
    select_nodes
    requestee_node = @requestee_node
    @requester_node.friends(:requestee_node, :rel).match_to(requestee_node).delete_all(:rel)
    broadcast_unfriend
    render json: { status: 'success' }
  end

  private

  # select friends
  def find_friends
    @friend_ids = UserNode.find_by(user_id: current_user.id).friends.to_a.map(&:user_id)
  end

  # select requester and requestee
  def select_nodes
    @requestee_node = UserNode.find_by(user_id: params[:user_id])
    @requester_node = UserNode.find_by(user_id: current_user.id)
  end
end
