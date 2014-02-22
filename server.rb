require 'sinatra'
require 'shotgun'
require_relative 'lib/game_creator.rb'

set :bind, '0.0.0.0' #vagrant vix

get '/' do
  @board_layout =
  erb :layout
end
