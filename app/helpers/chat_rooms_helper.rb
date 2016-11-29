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

  # message time
  def message_time(t)
    if t.today?
      t.strftime('%H:%M')
    elsif t.to_date == Date.yesterday
      "yesterday at #{t.strftime('%H:%M')}"
    else
      t.strftime('%d %b %H:%M')
    end
  end
end
