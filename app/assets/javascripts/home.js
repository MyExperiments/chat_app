$(function() {
  // hide loader initially
  $('.loader').hide();

  // Ajax request for user search 
  $( "#email" ).keyup(function() {
    var valuesToSubmit = $(this).val();
    $.ajax({
      type:'GET',
      url:'/users',
      data: {email: valuesToSubmit},
      dataType: 'json',
      beforeSend: function(){
        $('.users-list').hide();
        $('.loader').show();
      },
      success: function(result){ 
        $(".users-list").html(result.html);
      },
      complete: function(){
        $('.loader').hide();
        $('.users-list').show();
      }
    });
  });

  //Ajax request to load chat room
  $(document).on('click', '.chat-room-link', function( event ) {
    var userId = $( this ).attr('data-user-id');
    var isGroupChat = $( this ).attr('data-is-group-chat');
    event.preventDefault();
    $.ajax({
      type:'POST',
      url:'/chat_rooms',
      data: {user_id: userId, is_group_chat: isGroupChat},
      beforeSend: function(){
        //$( ".chat-room-container" ).empty();
      },
      success: function(result){ 
        $(".chat-room-container").html(result);
      },
      complete: function(){
      }
    });
  });
});