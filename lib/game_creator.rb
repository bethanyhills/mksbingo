game_arr = []

def randomizer(game_arr)
  rand_arr = []
  copy = game_arr
  while rand_arr.length() < 25
    x=rand(copy.length)
    rand_arr << copy[x]
    copy.delete_at(x)
  end
  return rand_arr
end
