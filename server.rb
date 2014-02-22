require 'sinatra'
require 'shotgun'
require 'omniauth-twitter'
require 'omniauth-github'
require 'rest-client'
require 'json'
require_relative 'lib/game_creator.rb'



CLIENT_ID = ENV['GH_BASIC_CLIENT_ID']
CLIENT_SECRET = ENV['GH_BASIC_SECRET_ID']

get '/' do
  erb :index, :locals => {:client_id => CLIENT_ID}
end

get '/callback' do
  # get temporary GitHub code...
  session_code = request.env['rack.request.query_hash']['code']

  # ... and POST it back to GitHub
  result = RestClient.post('https://github.com/login/oauth/access_token',
                          {:client_id => CLIENT_ID,
                           :client_secret => CLIENT_SECRET,
                           :code => session_code},
                           :accept => :json)

  # extract the token and granted scopes
  access_token = JSON.parse(result)['access_token']
  # fetch user information
  # auth_result = JSON.parse(RestClient.get('https://api.github.com/user', {:params => {:access_token => access_token}}))
  #build board
  @dual_array =Game_Board.randomizer()
  @gbt = @dual_array[1]
  @rand_arr = @dual_array[0]
  @selected_arr = Game_Board.selected_spaces()
  erb :game_board
end

