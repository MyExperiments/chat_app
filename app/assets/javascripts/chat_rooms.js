$(document).on('turbolinks:load', function() {

  // Close chat room on click
  $(document).on('click', '.chat-room-close', function( event ) {
    event.preventDefault();
    $(".chat-room-container").empty();
  });

  // Delete all conversation
  $(document).on('click', '.delete-chat', function( event ) {
    event.preventDefault();
    var chatRoomid = $(".message-container").data('chat-room-id');
    $(".message-container").data('page-count', 0);
    $.ajax({
      type:'GET',
      url:'/chat_rooms/delete_conversation',
      data: { chat_room_id: chatRoomid },
      success: function(result){ 
        $(".messages").empty();
      }
    });  
  });

  // Open file upload window 
  $(document).on('click', '.attachment-button', function( event ) {
    $('.attachment_upload').click();
  });

  // Remove attachment
  $(document).on('click', '.remove-attachment-button', function( event ) {
    event.preventDefault();
    removeAttachment();
  });

  // store selected file
  var files;

  // On file select
  $(document).on('change', '#files', function (event) {
    files = event.target.files;
    var reader = new FileReader();
    reader.onload = function (e) {
      var file = $('#files')[0].files[0].type;
      if(file.startsWith("image/")){
        $('.message-textarea').height(180);
        $('.attatchment-image').attr("src", e.target.result);
        appendUploadLink();
      }
      else if(file.startsWith("video/")){
        var videoThumbUrl = $('.video-thumb ').attr("src");
        $('.attatchment-image').attr("src", videoThumbUrl);
        $('.message-textarea').height(180);
        appendUploadLink();
      }
      else{
        alert('Unsupported file');
      }
    };

    // Read the image file as a data URL.
    reader.readAsDataURL(this.files[0]);
  });

  // On file upload
  $(document).on('click', '.upload-button', function( event ) {
    event.preventDefault();
    var chatRoomid = $(".message-container").data('chat-room-id');
    var data = new FormData();
    data.append('chat_room_id',chatRoomid);
    $.each(files, function(key, value)
    {
      data.append('image', value);
    });
    var attachedFile = $('#files')[0].files[0];
    $.ajax({
      type:'POST',
      url:'/chat_rooms/upload_attachment',
      data: data,
      contentType: false,
      cache: false,
      processData: false,
      success: function(result){ 
        removeAttachment();
      }
    }); 
  });
});


// append upload link
function appendUploadLink(){
  var removeIconUrl = $('.remove-icon').attr("src");
  var uploadIconUrl = $('.upload-icon').attr("src");
  $('.upload-image').attr("src", uploadIconUrl);
  $('.remove-image').attr("src", removeIconUrl);
  $('.attatchment-image').css("display","block");
}
// remove attachment
function  removeAttachment(){
  $('.upload-image').removeAttr("src");
  $('.remove-image').removeAttr("src");
  $('.attatchment-image').removeAttr("src");
  $('.attatchment-image').css("display","none");
  $('.message-textarea').height(40);
}

// update seen status
function updateSeenStatus(){
  var statusTime = $('.last-seen').data('seen-at') + 1;
  if (statusTime > 60){
    return
  }
  if (statusTime == 60){
   $('.last-seen').html('&#10004; seen about an hour ago');
  }
  $('.last-seen').data('seen-at',statusTime);
  $('.last-seen').html('&#10004; seen ' + statusTime + ' minutes ago');
}