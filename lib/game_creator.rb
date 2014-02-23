require 'unirest'

class Client
  def get_board(key)
    response = Unirest.get('https://mksbingo.firebaseio.com/'+key+'/board.json',
      headers: { "Accept" => "application/json" })
    posts = response.body
    if response.code == 200 && posts != "null"
      return posts
    else
      return nil
    end
  end

  def get_selected(key)
    response = Unirest.get('https://mksbingo.firebaseio.com/'+key+'/selected.json',
      headers: { "Accept" => "application/json" })
    posts = response.body
    if response.code == 200
      return posts
    else
      return nil
    end
  end
end


class Game_Board

  def self.randomizer(key)
    client = Client.new
    game_arr = []
    rand_arr = client.get_board(key)
    copy = []
    for i in 0..24 do
      game_arr << i
      copy << i
    end
    if rand_arr == nil
      rand_arr = []
      while rand_arr.length() < 25
        x=rand(copy.length)
        rand_arr << copy[x]
        copy.delete_at(x)
      end
    end
    return [rand_arr, game_arr]
  end

  def self.selected_spaces(key)
    client = Client.new
    selected_arr = client.get_selected(key)
    if selected_arr == 'null'
      selected_arr = Array.new(25, false)
      selected_arr[12] = true
    end
    return selected_arr
  end
end
