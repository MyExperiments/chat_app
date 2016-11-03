// Create notificaion channel
CreateNotificationChannel = function() {
  App.notification = App.cable.subscriptions.create({
    channel: "NotificationChannel"
  }, {
    connected: function() {},
    disconnected: function() {},
    received: function(data) {
      if (data.type == 'friend request'){
        $('.no-content').remove();
        appendFriendRequest(data.requesterId, data.requesterName)
      }
      else if(data.type == 'cancel request'){
        removeFriendRequest(data.requesterId)
      }
      else if(data.type == 'unfriend'){
        unfriend(data.requesterId, data.requesterName)
      }
      else if(data.type == 'accept request'){
        $('.no-content').remove();
        appendFriend(data.requesteeId, data.requesteeName)
      }   
    }
  });
};




