class Game
  def initialize(players, filename)
    @fragment = ""
    @players = players
    @dictionary = {}
    File.readlines(filename).map {|k| @dictionary[k.chomp] = true}
    @losses = {}
    @players.each {|player| @losses[player] = 0}
  end

  def run
    until @losses.has_value?(5)
      play_round
      display_standings
    end
    puts "#{previous_player.name} is the ultimate loser haha."
  end

  def play_round
    @fragment = ""
    until @dictionary.has_key?(@fragment) && @fragment.length > 3
      puts "#{current_player.name}, guess a letter: "
      take_turn(current_player)
      next_player!
    end
    puts "#{previous_player.name} loses."
    @losses[previous_player] += 1
  end

  def display_standings
    puts "score: #{current_player.name} has #{record(current_player)}"
    puts "score: #{previous_player.name} has #{record(previous_player)}"
  end

  def current_player
    @players[0]
  end

  def previous_player
    @players[-1]
  end

  def next_player!
    @players.push(@players[0])
    @players.shift()
  end

  def take_turn(player)
    attempt = @fragment + player.guess
    if valid_play?(attempt)
      @fragment = attempt
      puts "this is what we have: #{@fragment}"
    else
      puts "invalid play!"
      take_turn(player)
    end
  end

  def valid_play?(string)
    @dictionary.keys.any?{ |word| word[0...string.length] == string}
  end

  def record(player)
    score = "GHOST!"
    if @losses[player] == 0
      return ""
    else
      score[0...@losses[player]]
    end
  end
end

class Player
  attr_accessor :name, :guess

  def initialize(name)
    @name = name
  end

  def guess
    gets.chomp
  end

end

if __FILE__ == $PROGRAM_NAME
  puts "Enter the no of players"
  no_of_players = gets.chomp.to_i
  i = 0
  players = []
  while i < no_of_players
    puts "Please enter Player #{i}'s name:"
    players << Player.new(gets.chomp)
    i += 1
  end
  game = Game.new(players, "dictionary.txt")
  game.run
end
