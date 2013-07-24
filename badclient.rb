require 'faye/websocket'
require 'eventmachine'

port = ARGV[0] || "9292"

EM.run {
ws = Faye::WebSocket::Client.new('ws://localhost:9292/chat')

ws.on :open do |event|
  p [:open]
end

ws.on :message do |event|
  p [:message, event.data]
end

ws.on :close do |event|
  p [:close, event.code, event.reason]
  ws = nil
  EM.stop
end
}
