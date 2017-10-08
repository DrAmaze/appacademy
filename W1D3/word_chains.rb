require "set"

class WordChainer
  def initialize(dictionary_file_name)
    @dictionary = Set.new(File.readlines(dictionary_file_name).map(&:chomp))
  end

  def adjacent_words(word)
    alpha = ("a".."z")
    adj_words = []
    letters = word.split("")
    letters.each_index do |i|
      alpha.each do |let|
        new_letters = letters.dup
        new_letters[i] = let
        new_word = new_letters.join("")
        adj_words << new_word if @dictionary.include?(new_word) && new_word != word
      end
    end
    adj_words
  end


  def run(source, target)
    @current_words = [source]
    @all_seen_words = [source]

    until @current_words.empty?
      new_current_words = []
      @current_words.each do |current_word|
        adjacent_words = adjacent_words(current_word)
        adjacent_words.each do |adjacent_word|
          if !@all_seen_words.include?(adjacent_word)
            new_current_words << adjacent_word
            @all_seen_words << adjacent_word
          end
        end
      end
      @current_words = new_current_words
      puts @all_seen_words.length
    end
  end



end
