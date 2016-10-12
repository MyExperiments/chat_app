CreateMessageChannel = function(roomId) {
  App.messages = App.cable.subscriptions.create({
    channel: "MessagesChannel",
    roomId: roomId
  }, {
    connected: function() {},
    disconnected: function() {},
    received: function(data) {
      if(data['type'] == 'message'){
        var message = '<div class="col-lg-12"><span>' + data['user'] + ': </span><span>' + data['message'] + '</span></div>';
        return $('.message-container').append(message);
      }
      else{
        var currentUserId = $('.message-textarea').data('current-user-id');
        if (data['typed_by'] == currentUserId){
          return;
        }
        var message = '<div class="col-lg-12 msgbody"><span>' + data['user'] + ': </span><span>' + ' is typing' + '</span></div>';
        var $isTyping = $('.is-typing');
        $isTyping.show();
        $isTyping.html(message);
        $isTyping.delay(3000).hide(0);
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

$(document).on('keypress', '[data-behavior~=room-speaker]', function(event) {
  if (event.keyCode === 13) {
    App.messages.speak(event.target.value, $(this).data('room-id'));
    event.target.value = "";
    event.preventDefault();
  }
  else{
    App.messages.isTyping($(this).data('room-id'))
  }
});