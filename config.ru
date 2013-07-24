$:.unshift File.expand_path('..', __FILE__)
require 'rubygems'
require 'middleman/rack'
require 'chat_server'

map "/chat" do
  run ChatServer.new
end

run Middleman.server
