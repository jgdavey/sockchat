window.Chat = {};

Chat.init = function() {
  var host = "ws://localhost:9292/chat";
  var socket = new WebSocket(host);

  console.log('Socket Status: '+socket.readyState);

  socket.onopen = function(){
    console.log('Socket Status: '+socket.readyState+' (open)');
  }

  socket.onmessage = function(msg){
    console.log('Received: ', msg.data);
  }

  socket.onclose = function(){
    console.log('Socket Status: '+socket.readyState+' (closed)');
  }

  return socket;
};
