// Reload user listing to include unfriended user. 
function loadUsersList(){
  $.ajax({
    type:'GET',
    url:'/users/users_list',
    success: function(result){ 
      $('.user-listing-container').html(result);
    }
  });
}

// Reload friends list
function loadFriendsList(){
  $.ajax({
    type:'GET',
    url:'/users/friends_list',
    success: function(result){ 
      $('.users-list').html(result);
    }
  });
}

// Reload friend requests
function loadFriendRequests(requesterId){
  $.ajax({
    type:'GET',
    url:'/users/friend_requests',
    success: function(result){ 
      $('.friend-request-container').html(result);
      htmlCode = '<a class="btn btn-success btn-sm accept-request" data-user-id=' + requesterId + ' >Accept Request</a>'
      $('.add-friend-container-' + requesterId).html(htmlCode);
    }
  });
} 


