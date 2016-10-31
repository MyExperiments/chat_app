#
# BroadcastRequests
#
# @author rashid
#
module BroadcastRequests
  extend ActiveSupport::Concern

  # Broadcast friend request
  def broadcast_friend_request
    ActionCable.server.broadcast(
      "notification_channel_#{@requestee_node.user_id}",
      requesterId: current_user.id,
      requesterName: current_user.name,
      type: 'friend request'
    )
  end

  # Broadcast unfriend
  def broadcast_unfriend
    ActionCable.server.broadcast(
      "notification_channel_#{@requestee_node.user_id}",
      requesterId: current_user.id,
      requesterName: current_user.name,
      type: 'unfriend'
    )
  end

  # Broadcast friend request acceptance
  def broadcast_request_acceptance
    ActionCable.server.broadcast(
      "notification_channel_#{@requestee_node.user_id}",
      requesteeId: current_user.id,
      requesteeName: current_user.name,
      type: 'accept request'
    )
  end

  # Broadcast friend request cancellation
  def broadcast_cancel_request
    ActionCable.server.broadcast(
      "notification_channel_#{@requestee_node.user_id}",
      requesterId: current_user.id,
      type: 'cancel request'
    )
  end
end
