#
# ChatRoomsHelper
#
# @author rashid
#
module ChatRoomsHelper
  # read time of message
  def last_seen_time(t)
    return "#{time_ago_in_words(t)} ago" if t + 15.hours >= Time.now
    "at #{t.strftime('%d-%m-%Y %H:%M')}"
  end

  # time ago in minutes
  def last_seen_duration(t)
    ((Time.now - t) / 60).floor
  end
end
