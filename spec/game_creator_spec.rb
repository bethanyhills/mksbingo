# require 'ruby-gems'
require 'rspec'
require_relative '../lib/game_creator.rb'

describe 'Creates a random array of 25 elements' do
  it 'Takes an array of numbers from 1-25' do
    arr = []
    for i in 0..24 do
      arr << i
    end
    expect(randomizer(arr).class).to eq(Array)
    expect(randomizer(arr).length).to eq(25)
    expect(randomizer(arr)[0]).not_to eq(0)
  end

end
