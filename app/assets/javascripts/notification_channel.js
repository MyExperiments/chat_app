// remove user from friend list
// add user to user's list
function unfriend(requesterId, requesterName){
  $('.user-listing-' + requesterId).remove();
  var htmlCode = '<div class="row user-listing user-listing-container-' + requesterId + '"><div class="col-md-6">' + requesterName + '</div><div class="col-md-6 add-friend-container-' + requesterId + '"><a class="btn btn-primary btn-sm add-friend" data-user-id=' + requesterId + ' href="#">Send Request</a></div></div>';
  $('.user-listing-container').append(htmlCode);
}

// append accept-request link to friend request
// replace add-frend link with accept request in users listing
function appendFriendRequest(requesterId, requesterName){
  var htmlCode = '<div class="row user-listing-' + requesterId +' friend_request"><div class="col-md-6 friend-request-name">' + requesterName + '</div><div class="col-md-6"><a href="#" class= "btn btn-success btn-sm accept-request" data-user-id=' + requesterId + '>Accept Request</a></div></div>';
  $('.friend-request-container').append(htmlCode);
  htmlCode = '<a class="btn btn-success btn-sm accept-request" data-user-id=' + requesterId + ' >Accept Request</a>'
  $('.add-friend-container-' + requesterId).html(htmlCode);
}

// remove accept friend request link in friend request's tab
// replace accept request with add friend in user's tab
function removeFriendRequest(requesterId, requesterName){
  $('.user-listing-' + requesterId).remove();
  var htmlCode = '<a class="btn btn-primary btn-sm add-friend" data-user-id=' + requesterId + ' href="#">Send Request</a>';
  $('.add-friend-container-' + requesterId).html(htmlCode);
}

//remove request from friend request tab
//add friend to friend list
function appendFriend(requesteeId, requesteeName){
  $('.user-listing-container-' + requesteeId).remove();
  var htmlCode = '<div class="row user-listing-' + requesteeId + ' friend_listing"><div class="col-md-6"><li><a href="#" class="chat-room-link" data-is-group-chat="false" data-user-id=' + requesteeId + '>' + requesteeName + '</a></li></div><div class="col-md-2" id = "user_' + requesteeId + '"><div class="online"></div></div><div class="col-md-4"><a href="#" class="btn btn-danger btn-sm un-friend" data-user-id=' + requesteeId + '>Un-friend</a></div></div>';
    $('.users-list').append(htmlCode);

}

  


