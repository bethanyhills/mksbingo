class Game_Board


  def self.randomizer()
    game_arr = []
    copy = []
    for i in 0..24 do
      game_arr << i
      copy << i
    end
    rand_arr = []
    while rand_arr.length() < 25
      x=rand(copy.length)
      rand_arr << copy[x]
      copy.delete_at(x)
    end
    return [rand_arr, game_arr]
  end
end
