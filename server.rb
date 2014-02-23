require 'sinatra'
require 'shotgun'
require 'omniauth-twitter'
require 'omniauth-github'
require 'rest-client'
require 'json'
require_relative 'lib/game_creator.rb'

enable :sessions

CLIENT_ID = ENV['GH_BASIC_CLIENT_ID']
CLIENT_SECRET = ENV['GH_BASIC_SECRET_ID']

get '/' do
  erb :index, :locals => {:client_id => CLIENT_ID}
end

get '/callback' do
  if session[:access_token]
    puts ""
    puts session[:access_token]
    puts ""
  end
  # get temporary GitHub code...
  session_code = request.env['rack.request.query_hash']['code']

  # ... and POST it back to GitHub
  result = RestClient.post('https://github.com/login/oauth/access_token',
                          {:client_id => CLIENT_ID,
                           :client_secret => CLIENT_SECRET,
                           :code => session_code},
                           :accept => :json)

  # extract the token and granted scopes
  if JSON.parse(result)['access_token']
    access_token = JSON.parse(result)['access_token']
    session[:access_token] = access_token
  else
    access_token = session[:access_token]
  end
  @identity = access_token
  @wins = Game_Board.wins(@identity)
  @dual_array =Game_Board.randomizer(@identity)
  @gbt = @dual_array[1]
  @rand_arr = @dual_array[0]
  @selected_arr = Game_Board.selected_spaces(@identity)
  #github info
  @auth_result = JSON.parse(RestClient.get('https://api.github.com/user',{:params => {:access_token => access_token}}))
  @name = @auth_result['name']
  @photo = @auth_result['avatar_url']
  erb :game_board
end

get '/board/:key' do

end

get '/scores' do
  scores = Game_Board.scoreboard()
  @names = []
  @avatar_url = []
  @wins = []
  sorted_scores = scores.sort_by { |k,v| v[:wins] }
  sorted_scores.reverse_each do |element|
    @names << element.first
    @wins << element[1]["wins"]
    @avatar_url << element[1]["img"]
  end
  erb :score
end
