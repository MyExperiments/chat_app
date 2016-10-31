#
# AppearanceChannel
#
# @author rashid
#
class AppearanceChannel < ApplicationCable::Channel
  # set online flag true and broadcast user's appearance
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

  # set online flag to false and broadcast user's disapearance
  def unsubscribed
    User.find(current_user.id).update(online: false)
    ActionCable.server.broadcast(
      'appearance_channel',
      user_id: current_user.id,
      is_online: false
    )
  end
end
