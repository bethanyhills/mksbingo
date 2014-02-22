require 'sinatra'
require 'shotgun'
require_relative 'lib/game_creator.rb'

set :bind, '0.0.0.0' #vagrant vix

get '/' do
  "Hey, this is a web app"
  erb :layout
end
