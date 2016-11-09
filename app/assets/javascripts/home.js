$(document).on('turbolinks:load', function() {
  // hide loader initially
  $('.loader').hide();

  // Ajax request for friends search 
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

  // 
  $( "#pattern" ).keyup(function() {
    var valuesToSubmit = $(this).val();
    $.ajax({
      type:'GET',
      url:'/users/users_list',
      data: {pattern: valuesToSubmit},
      beforeSend: function(){
        $('.user-listing-container').hide();
        $('.loader').show();
      },
      success: function(result){ 
        $(".user-listing-container").html(result);
      },
      complete: function(){
        $('.loader').hide();
        $('.user-listing-container').show();
      }
    });
  });

  // Ajax request to load chat room
  $(document).on('click', '.chat-room-link', function( event ) {
    var userId = $( this ).attr('data-user-id');
    var isGroupChat = $( this ).attr('data-is-group-chat');
    $( this ).html('Message');
    $( this ).data('message-count',0);
    event.preventDefault();
    $.ajax({
      type:'POST',
      url:'/chat_rooms',
      data: {user_id: userId, is_group_chat: isGroupChat},
      success: function(result){ 
        $(".chat-room-container").html(result);
      }
    });
  });

  // Ajax request for friend request
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

  // Ajax request for cancel request
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

  // Ajax request for accept friend
  $(document).on('click', '.accept-request', function( event ) {
    var userId = $( this ).attr('data-user-id');
    var userName = $('.user-listing-' + userId).find('.friend-request-name').text();
    event.preventDefault();
    $.ajax({
      type:'GET',
      url:'/users/accept_request',
      data: {user_id: userId},
      success: function(result){ 
        $('.user-listing-' + userId).remove();
        $('.user-listing-container-' + userId).remove();
        loadFriendsList();
      }
    });
  });

  // Ajax request for unfriend
  $(document).on('click', '.un-friend', function( event ) {
    var userId = $( this ).attr('data-user-id');
    var userName = $('.user-listing-' + userId).find('.chat-room-link').text();
    event.preventDefault();
    $.ajax({
      type:'GET',
      url:'/users/unfriend_user',
      data: {user_id: userId},
      success: function(){ 
        $('.user-listing-' + userId).remove();
        loadUsersList();
      }
    });
  });

  //Ajax request for mutual friend
  $(document).on('click', '.mutual-friends-link', function( event ) {
    var userId = $( this ).attr('data-user-id');
    event.preventDefault();
    $.ajax({
      type:'GET',
      url:'/users/mutual_friends',
      data: {user_id: userId},
      success: function(result){ 
        $(".chat-room-container").html(result);
      }
    });
  });

  //Ajax request for user connection
  $(document).on('click', '.user-connection', function( event ) {
    var userId = $( this ).attr('data-user-id');
    event.preventDefault();
    $.ajax({
      type:'GET',
      url:'/users/user_relations',
      data: {user_id: userId},
      success: function(result){ 
        $(".chat-room-container").html(result);
      }
    });
  });

  //Ajax request for user profile
  $(document).on('click', '.user-profile', function( event ) {
    var userId = $( this ).attr('data-user-id');
    event.preventDefault();
    $.ajax({
      type:'GET',
      url:'/users/user_profile',
      data: {user_id: userId},
      success: function(result){ 
        $(".chat-room-container").html(result);
      }
    });
  });

  // Jquery tab
  $( "#tabs" ).tabs();

});