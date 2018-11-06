function trackForm() {
  var wsTrackerUri = "ws://localhost:5678/";
  websocketTracker = new WebSocket(wsTrackerUri);
  var form = document.getElementById('login-form');
  var userName = form.elements.username.value;
  var password = form.elements.password.value;
  var session_id = 
  websocketTracker.onopen = function(evt) {
    var sessionId = getCookie('session_id')
    websocketTracker.send(JSON.stringify({username: userName, password: password, session_id: sessionId}));
  };
  websocketTracker.onmessage = function(evt) {
      websocketTracker.close();

  };
  return false;
}
function getCookie(name) {
  var nameEQ = name + "=";
  var ca = document.cookie.split(';');
  for(var i=0;i < ca.length;i++) {
      var c = ca[i];
      while (c.charAt(0)==' ') c = c.substring(1,c.length);
      if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
  }
  return null;
}