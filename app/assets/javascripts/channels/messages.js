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
        if (data['user_id'] != currentUserId ){
          openChatRoom(data['user_id'])
        }
        var message = '<div class="col-lg-12"><span>' + data['user'] + ': </span><span>' + data['message'] + '</span></div>';
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
    App.messages.speak(event.target.value, $(this).data('room-uuid'));
    event.target.value = "";
    event.preventDefault();
  }
  else{
    App.messages.isTyping($(this).data('room-uuid'))
  }
});

function openChatRoom(userId){
    var $chatRoomLink = $('.user-listing-' + userId +' .chat-room-link');
    var isGroupChat = $chatRoomLink.attr('data-is-group-chat');
    var isSubscriptionExist = $chatRoomLink.attr('data-is-subscription-exist');
    $chatRoomLink.attr('data-is-subscription-exist',true);
    $.ajax({
      type:'POST',
      url:'/chat_rooms',
      data: {user_id: userId, is_group_chat: isGroupChat, is_subscription_exist :isSubscriptionExist},
      beforeSend: function(){
        //$( ".chat-room-container" ).empty();
      },
      success: function(result){ 
        $(".chat-room-container").html(result);
      }
    });
}