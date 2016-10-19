CreateAppearanceChannel = function() {
  App.appearance = App.cable.subscriptions.create({
    channel: "AppearanceChannel"
  }, {
    connected: function() {},
    disconnected: function() {},
    received: function(data) {
      if (data.appear == true){
        var online_html = '<div class="online"></div>'
        $('#user_' + data.user_id).html(online_html);
      }
      else{
        $('#user_' + data.user_id).empty();
      }
    }
  });
};