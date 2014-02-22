require 'sinatra'
require 'shotgun'
require_relative 'lib/game_creator.rb'

set :bind, '0.0.0.0' #vagrant vix

get '/' do
  @dual_array = Game_Board.randomizer()
  @gbt = @dual_array[1]
  @rand_arr = @dual_array[0]
  @selected_arr = Game_Board.selected_spaces()
  erb :game_board
end
