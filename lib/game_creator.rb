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
    game_arr = ["Shehzan Tells a 'Great' Joke",
      "Whiteboard vs. Eraser Battle",
      "A Makernap",
      "A Dream Within a Dream Within a ...",
      "One of the Founders Holding a Beer",
      "'It's complicated' says Osei",
      "Mike Destroys a Vagrant Issue. Like a Boss.",
      "Osei Hands You a Dessert",
      'A "Gilbert ... Pause"',
      "An Instructor Finds a Bug During a Lecture",
      "Algorithms. F*CK!",
      '"Let me explain" says Osei',
      "What the HECK is This Music?",
      "Gene Saves the Day!",
      "It Works, but I Don't Know Why...",
      "Jessica Rocks Neon Jeans",
      "Taaha Mentions He Isn't 21 Yet",
      "A West-Coaster Mentions California",
      "A Flock of Five Ties",
      "DING DONG!",
      "Taylor Takes Attendance",
      "Line for the Microwave >= 4",
      "Git Problems. All Day Errday.",
      "Clay Talks About Teach for America",
      "Code Breaks While Being a Show-Off"]
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
