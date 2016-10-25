#
# NotificationChannel
#
# @author rashid
#
class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notification_channel_#{current_user.id}"
  end

  def received
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
