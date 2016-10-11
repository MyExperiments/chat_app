CreateMessageChannel = function(roomId) {
  App.messages = App.cable.subscriptions.create({
    channel: "MessagesChannel",
    roomId: roomId
  }, {
    connected: function() {},
    disconnected: function() {},
    received: function(data) {
      return $('.messages').append(receivedMessage(data));
    },
    speak: function(message, roomId) {
      return this.perform('speak', {
        message: message,
        room_id: roomId
      });
    },
    receivedMessage: function(data) {
      return '<span>' + data['url'] + ': </span><span>' + data['message'] + '</span>';
    }
  });
};

$(document).on('keypress', '[data-behavior~=room-speaker]', function(event) {
  if (event.keyCode === 13) {
    App.messages.speak(event.target.value, $(this).data('room-id'));
    event.target.value = "";
    event.preventDefault();
  }
});