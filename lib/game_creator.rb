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

  def get_wins(key)
    response = Unirest.get('https://mksbingo.firebaseio.com/'+key+'/wins.json',
      headers: { "Accept" => "application/json" })
    posts = response.body
    if response.code == 200
      return posts
    else
      return nil
    end
  end

  def get_scores()
    response = Unirest.get('https://mksbingo.firebaseio.com/scoreboard.json',
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
    game_arr = ["Shehzan tells a 'great' joke",
      "Whiteboard vs. Eraser Battle",
      "A Makernap",
      "A Dream Within a Dream",
      "One of the Founding Four Holding a Beer",
      "'It's Complicated' says Osei",
      "Mike destroys a Vagrant Issue",
      "Osei hands you a desert",
      'A "Gilbert ... Pause"',
      "An Instructor finds a bug during a Lecture",
      "Algorithms. F*CK!",
      '"Let me explain" says Osei',
      "What the hell is this music?",
      "Gene saves the day!",
      "It works, but I don't know how...",
      "Jessica rocks neon jeans",
      "Taaha mentions he isn't 21 yet",
      "A Cali Mafia member mentions California",
      "A flock of five ties",
      "DING DONG!",
      "Taylor Takes Attendance",
      "Line for the microwave",
      "Github Problems",
      "Clay talks about Teach for America",
      "Code doesn't work when showing it off"]
    client = Client.new
    rand_arr = client.get_board(key)
    copy = []
    for i in 0..24 do
      # game_arr[i] = i #Delete line for full functionality
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

  def self.wins(key)
    client = Client.new
    wins = client.get_wins(key)
    unless wins
      wins = 0
    end
    return wins
  end

  def self.scoreboard()
    client = Client.new
    scores = client.get_scores()
  end
end
