require_relative "Card.rb"
require_relative "Board.rb"
require 'byebug'


class Game
  debugger
  attr_accessor :board, :players, :score
  def initialize(player1, player2)
    @board = Board.new
    @players = [player1, player2]
    @score = { @players[0] => 0, @players[1] => 0 }
  end


# create new board
# populate the board
# prompt player 1 for input
# get guess position
#
  def play
    over = false

    until over
      display_score
      @board.render
      @guesses = []
      prompt
      if same_card?(@guesses[0], @guesses[1])
        puts "you got it!  Go again!"
        @guesses[0].reveal_card
        @guesses[1].reveal_card
        @score[current_player] += 1
      else
        @guesses[0].hide
        @guesses[1].hide
        puts "you suck! Go #{previous_player} is up."
        next_player!
      end


      over = true if board.won?
    end
  end


  def prompt
    puts "#{current_player} What's your first row guess?"
    row1 = gets.chomp
    puts "#{current_player} What's your first col guess?"
    col1 = gets.chomp
    guess1 = [row1.to_i, col1.to_i]
    @guesses << first_guess(guess1)
    puts "first card is #{@guesses[0]}"
    puts "#{current_player} What's your second row guess?"
     row2 = gets.chomp
     puts "#{current_player} What's your second col guess?"
     col2 = gets.chomp
     guess2 = [row2, col2]
    @guesses << second_guess(guess2)
    puts "second card is #{@guesses[1]}"
  end

  def same_card?(card1, card2)
    card1 == card2
  end

  def current_player
    @players.first
  end

  def previous_player
    @players.last
  end

  def next_player!
    @players = [players[1],players[0]]
  end

  def first_guess(guessed_pos)
    @board.reveal(guessed_pos)
  end

  def second_guess(guessed_pos)
    @board.reveal(guessed_pos)
  end

  def display_score
    puts "Player 1's score is: #{@score[@players[0]]}"
    puts "Player 2's score is: #{@score[@players[1]]}"
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new("jacob", "tanner")
  game.play
end
