// Create notificaion channel
CreateNotificationChannel = function() {
  App.notification = App.cable.subscriptions.create({
    channel: "NotificationChannel"
  }, {
    connected: function() {},
    disconnected: function() {},
    received: function(data) {
      if (data.type == 'friend request'){
        loadFriendRequests(data.requesterId);
      }
      else if(data.type == 'cancel request'){
        $('.user-listing-' + data.requesterId).remove();
        var htmlCode = '<a class="btn btn-primary btn-sm add-friend" data-user-id=' + data.requesterId + ' href="#">Send Request</a>';
        $('.add-friend-container-' + data.requesterId).html(htmlCode);
      }
      else if(data.type == 'unfriend'){
        $('.user-listing-' + data.requesterId).remove();
        loadUsersList();
      }
      else if(data.type == 'accept request'){
        $('.user-listing-container-' + data.requesteeId).remove();
        loadFriendsList();
      }   
    }
  });
};




