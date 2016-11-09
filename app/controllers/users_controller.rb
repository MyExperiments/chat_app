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

  # GET#user_relations /users
  def user_relations
    @path = Neo4j::Session.query(
      "match p= shortestpath((u:UserNode{user_id: #{current_user.id}})
      -[f:friend*1..15]-(v:UserNode{user_id: #{params[:user_id]}}))
       return nodes(p)"
    ).to_a
    render partial: 'users/user_relations', locals: { path: @path }
  end

  # GET#mutual friends /users
  def mutual_friends
    find_mutual_friends
    render partial: 'users/mutual_friends', locals: { mutual_friends: @mutual_friends, user: @user }
  end

  # GET#user profile /users
  def user_profile
    find_mutual_friends
    render partial: 'users/user_profile', locals: { user: @user, mutual_friends: @mutual_friends }
  end

  # GET#friend_list /users
  def friends_list
    initialize_friends
    render partial: 'users/friend_list', locals: { users: @friends }
  end

  # GET#users_list /users
  def users_list
    initialize_friends
    @users = @users.select { |x| x.name.downcase.start_with?(params[:pattern].downcase) } if params[:pattern].present?
    render partial: 'users/users_listing', locals: { users: @users }
  end

  # GET#friend_request /users
  def friend_requests
    @friend_requests = UserNode.find_by(user_id: current_user.id).friend_requests
    render partial: 'users/friend_request', locals: { users: @friend_requests }
  end

  private

  # find mutual friends
  def find_mutual_friends
    mutual_friends_ids = Neo4j::Session.query(
      "MATCH (n:UserNode{user_id: #{current_user.id}})
      -[:friend]-(m)-[:friend]-(u:UserNode{user_id: #{params[:user_id]}})
      return m"
    ).to_a.map { |m| m[0].user_id }
    @mutual_friends = User.where(id: mutual_friends_ids)
    @user = User.find(params[:user_id])
  end

  # select friends
  def find_friends
    @friend_ids = UserNode.find_by(user_id: current_user.id).friends.to_a.map(&:user_id)
  end

  # select requester and requestee
  def select_nodes
    @requestee_node = UserNode.find_by(user_id: params[:user_id])
    @requester_node = UserNode.find_by(user_id: current_user.id)
  end

  # set users friends and friend requests
  def initialize_friends
    @friends_ids = UserNode.find_by(user_id: current_user.id).friends.to_a.map(&:user_id)
    @friends = User.where(id: @friends_ids)
    @users = User.where.not(id: @friends_ids << current_user.id)
  end
end
