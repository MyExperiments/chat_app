// Create message channel
CreateMessageChannel = function(roomId) {
  App.messages = App.cable.subscriptions.create({
    channel: "MessagesChannel",
    roomId: roomId
  }, {
    connected: function() {},
    disconnected: function() {},
    received: function(data) {
      var currentUserId = $('.message-textarea').data('current-user-id');
      if(data['type'] == 'message'){
        sender = (currentUserId == data['user_id'])?'You':data['user'];
        var message = '<div class="col-lg-12"><span>' + sender + ': </span><span>' + data['message'] + '</span></div>';
        if (data['user_id'] != currentUserId){
          appendBadge(data['user_id']);
        }
        return $('.message-container-' + data['chat_room_uuid']).append(message);
      }
      else{
        if (data['typed_by'] == currentUserId){
          return;
        }
        var message = '<div class="col-lg-12 msgbody"><span>' + data['user'] + ': </span><span>' + ' is typing' + '</span></div>';
        var $isTyping = $('.is-typing-' + data['chat_room_uuid']);
        $isTyping.show();
        $isTyping.html(message);
        $isTyping.delay(2000).hide(0);
      }
    },
    speak: function(message, roomId) {
      return this.perform('speak', {
        message: message,
        room_id: roomId
      });
    },
    isTyping: function(roomId) {
      return this.perform('typing?', {
        room_id: roomId
      });
    }

  });
};

// On keypress sent message if enter key
// else sent is-typing status
$(document).on('keypress', '[data-behavior~=room-speaker]', function(event) {
  roomId = $(this).data('room-uuid');
  if (event.keyCode === 13) {
    App.messages.speak(event.target.value, roomId);
    event.target.value = "";
    event.preventDefault();
  }
  else{
    App.messages.isTyping(roomId);
  }
});

//append badge
function appendBadge(userId){
  var chatRoomLink = $('.chat-room-link-' + userId);
  var messageCount = chatRoomLink.data('message-count') + 1;
  chatRoomLink.data('message-count', messageCount);
  var badge = '<span class="badge message-badge">' + messageCount + '</span>'
  chatRoomLink.html('Message ' + badge);
}