CreateMessageChannel = function(roomId) {
  App.messages = App.cable.subscriptions.create({
    channel: "MessagesChannel",
    roomId: roomId
  }, {
    connected: function() {},
    disconnected: function() {},
    received: function(data) {
      var message = '<div class="col-lg-12"><span>' + data['user'] + ': </span><span>' + data['message'] + '</span></div>';
      return $('.messages').append(message);
    },
    speak: function(message, roomId) {
      return this.perform('speak', {
        message: message,
        room_id: roomId
      });
    },

  });
};

$(document).on('keypress', '[data-behavior~=room-speaker]', function(event) {
  if (event.keyCode === 13) {
    App.messages.speak(event.target.value, $(this).data('room-id'));
    event.target.value = "";
    event.preventDefault();
  }
});