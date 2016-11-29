// Create message channel
CreateMessageChannel = function() {
  App.messages = App.cable.subscriptions.create({
    channel: "MessagesChannel"
  }, {
    connected: function() {},
    disconnected: function() {},
    received: function(data) {
      var currentUserId = $('.message-textarea').data('current-user-id');
      if(data['type'] == 'message'){
        var activeChatRoom = $('.message-container').data('chat-room-uuid');
        if (data['user_id'] != currentUserId){
          appendReceivedMessage(data['message'], data['chat_room_uuid']);
          if (activeChatRoom != data['chat_room_uuid']){
            appendBadge(data['user_id']);
          }
        }
        else{
          appendSendMessage(data['message'], data['chat_room_uuid']);

        }  
        scrollDown();
      }
      else if(data['type'] == 'attachment'){
        if (data['user_id'] == currentUserId){
          if(data['content_type'].startsWith("image/")){
            var messageContent = '<img id="image" src='+ data['url'] + ' class="attached-image" />';
            appendSendAttachment(messageContent, data['chat_room_uuid']);
          }
          else{
            var messageContent = '<video class="attached-video" controls><source src=' + data['url'] + ' type="video/mp4"></video>';
            appendSendAttachment(messageContent, data['chat_room_uuid']);
          }
          scrollDown();
        }
        else{
          if(data['content_type'].startsWith("image/")){
            var messageContent = '<img id="image" src='+ data['url'] + ' class="attached-image recived-attachment" />';
            appendReceivedAttachment(messageContent, data['chat_room_uuid']);
          }
          else{
            var messageContent = '<video class="attached-video recived-attachment" controls><source src=' + data['url'] + ' type="video/mp4"></video>';
            appendReceivedAttachment(messageContent, data['chat_room_uuid']);
          }
          scrollDown();
        }
      }
      else if(data['type'] == 'read_status'){
        appendReadstatus();
      }
      else{
        if (data['user_id'] == currentUserId){
          return;
        }
        showIsTypingStatus(data['chat_room_uuid']);
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
    if (event.target.value == ''){
      event.preventDefault();
      return;
    }
    App.messages.speak(event.target.value, roomId);
    event.target.value = "";
    event.preventDefault();
  }
  else{
    App.messages.isTyping(roomId);
  }
});

// append badge
function appendBadge(userId){
  var chatRoomLink = $('.chat-room-link-' + userId);
  var messageCount = chatRoomLink.data('message-count') + 1;
  chatRoomLink.data('message-count', messageCount);
  var badge = '<span class="badge message-badge">' + messageCount + '</span>'
  chatRoomLink.html('Message ' + badge);
}

// scrollDown
function scrollDown(){
  var wtf    = $('.messages');
  var height = wtf[0].scrollHeight;
  wtf.scrollTop(height);
}

// append received message to chat room
function appendReceivedMessage(messageContent, chatRoomuuid){
  var messageTime = getCurrentTime();
  var imageSrc = $('.message-container').data('user-pic-url');
  var message = '<div class="col-lg-12 message-content"><div class="col-lg-12 message-content message-content-receiver"><span><img class="img-circle" src="' + imageSrc + '" alt="Default smallthumb"></span><span class="received-message">' + messageContent + '<span class="received-message-time">' + messageTime + '</span></span></div></div></div>';
  $('.message-container-' + chatRoomuuid).append(message);
}

// append sent message to chat room
function appendSendMessage(messageContent, chatRoomuuid){
  var messageTime = getCurrentTime();
  var imageSrc = $('.user-profile-pic').attr('src');
  var message = '<div class="col-lg-12 message-content"><div class="col-lg-12 message-content message-content-sender"><span class="send-message">' + messageContent + '<span class="sent-message-time">'+messageTime+'</span></span><span><img class="img-circle" src="' + imageSrc + '" alt="Default smallthumb"></span></div></div>';
  $('.message-container-' + chatRoomuuid).append(message);
}

// show is typing status
function showIsTypingStatus(chatRoomuuid){
  var imageSrc = $('.message-container').data('user-pic-url');
  var status = '<div class="col-lg-12 message-content"><div class="col-lg-12 message-content message-content-receiver"><span><img class="img-circle" src="' + imageSrc + '" alt="Default smallthumb"></span><span class="received-message">is typing..</span></div></div></div>';
  var $isTyping = $('.is-typing-' + chatRoomuuid);
  $isTyping.show();
  $isTyping.html(status);
  $isTyping.delay(2000).hide(0);
}

// append sent attachment to chat room
function appendSendAttachment(messageContent, chatRoomuuid){
  var messageTime = getCurrentTime();
  var imageSrc = $('.user-profile-pic').attr('src');
  var message = '<div class="col-lg-12 message-content"><div class="col-lg-12 message-content message-content-sender">' + messageContent + '<span><img class="img-circle" src="' + imageSrc + '" alt="Default smallthumb"></span><span class="sent-attachment-time">' + messageTime + '</span></div></div>';
  $('.message-container-' + chatRoomuuid).append(message);
}

// append received message to chat room
function appendReceivedAttachment(messageContent, chatRoomuuid){
  var messageTime = getCurrentTime();
  var imageSrc = $('.message-container').data('user-pic-url');
  var message = '<div class="col-lg-12 message-content"><div class="col-lg-12 message-content message-content-receiver"><span><img class="img-circle" src="' + imageSrc + '" alt="Default smallthumb"></span>' + messageContent + '<span class="received-attachment-time">' + messageTime + '<span></div></div></div>';
  $('.message-container-' + chatRoomuuid).append(message);
}

// change read status position to bottom
function appendReadstatus(){
  $('.last-seen').remove();
  var html = '<div class="col-md-12 last-seen" data-seen-at="0" >&#10004; seen just now </div>'
  $('.message-content-sender:last').append(html);
  setInterval(updateSeenStatus, 60000);
}
function getCurrentTime(){
  var d = new Date();
  var hour = d.getHours();
  var minutes = d.getMinutes();
  return hour + ':' + minutes
}