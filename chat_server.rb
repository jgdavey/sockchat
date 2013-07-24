require 'faye/websocket'

class ChatServer
  attr_reader :clients

  def initialize
    @clients = Set.new
  end

  def call(env)
    if Faye::WebSocket.websocket?(env)
      ws = Faye::WebSocket.new(env)
      client = Client.new(ws)
      clients.add(client)

      ws.on :message do |event|
        clients.each do |c|
          c.send(event.data)
        end
      end

      ws.on :close do |event|
        p [:close, event.code, event.reason]
        clients.delete(client)
        ws = nil
      end

      # Return async Rack response
      ws.rack_response

    else # Normal HTTP request
      [200, {'Content-Type' => 'text/plain'}, ['Request this endpoint using websockets']]
    end
  end

  class Client
    def initialize(ws)
      @ws = ws
    end

    def send(message)
      @ws.send(message)
    end
  end
end
