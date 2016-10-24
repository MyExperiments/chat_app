$(function() {
  // hide loader initially
  $('.loader').hide();

  // Ajax request for user search 
  $( "#name" ).keyup(function() {
    var valuesToSubmit = $(this).val();
    $.ajax({
      type:'GET',
      url:'/users',
      data: {name: valuesToSubmit},
      beforeSend: function(){
        $('.users-list').hide();
        $('.loader').show();
      },
      success: function(result){ 
        $(".users-list").html(result);
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
      }
    });
  });

  //Ajax request for friend request
  $(document).on('click', '.add-friend', function( event ) {
    var userId = $( this ).attr('data-user-id');
    event.preventDefault();
    $.ajax({
      type:'GET',
      url:'/users/friend_request',
      data: {user_id: userId},
      success: function(result){ 
        $('.add-friend-container-' + userId).html(result);
      }
    });
  });

  //Ajax request for cancel request
  $(document).on('click', '.cancel-request', function( event ) {
    var userId = $( this ).attr('data-user-id');
    event.preventDefault();
    $.ajax({
      type:'GET',
      url:'/users/cancel_request',
      data: {user_id: userId},
      success: function(result){ 
        $('.add-friend-container-' + userId).html(result);
      }
    });
  });

  //Ajax request for accept friend
  $(document).on('click', '.accept-request', function( event ) {
    var userId = $( this ).attr('data-user-id');
    event.preventDefault();
    $.ajax({
      type:'GET',
      url:'/users/accept_request',
      data: {user_id: userId},
      success: function(result){ 
        $('.user-listing-' + userId).remove();
      }
    });
  });

  //Ajax request for unfriend
  $(document).on('click', '.un-friend', function( event ) {
    var userId = $( this ).attr('data-user-id');
    event.preventDefault();
    $.ajax({
      type:'GET',
      url:'/users/unfriend_user',
      data: {user_id: userId},
      success: function(result){ 
        $('.user-listing-' + userId).remove();
      }
    });
  });

  //Jquery tab
  $( "#tabs" ).tabs();

});