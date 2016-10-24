#
# AppearanceChannel
#
# @author rashid
#
class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'appearance_channel'
    User.find(current_user.id).update(online: true)
    ActionCable.server.broadcast(
      'appearance_channel',
      user_id: current_user.id,
      is_online: true
    )
  end

  def received
  end

  def unsubscribed
    User.find(current_user.id).update(online: false)
    ActionCable.server.broadcast(
      'appearance_channel',
      user_id: current_user.id,
      is_online: false
    )
    # Any cleanup needed when channel is unsubscribed
  end
end
