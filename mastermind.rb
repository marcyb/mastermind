#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'lib/code'
require_relative 'lib/guess'
require_relative 'lib/solver'

# Mastermind class
class Mastermind
  TURNS = 12

  def initialize(code = nil)
    @code = code.nil? ? Code.new : code
    # puts "CODE: #{@code}" # for debugging
    @guesses = []
    code.nil? ? guess : Solver.new(@code, TURNS)
  end

  private

  def guess
    print_instructions
    TURNS.times do |i|
      @guesses[i] = Guess.new(i, @code)
      display_board
      break display_win(@guesses[i]) if @guesses[i].correct?

      display_loss if @guesses.length == TURNS
    end
  end

  def print_instructions
    puts 'Can you guess the code?'
    puts
    puts "'x': correct color in the correct position"
    puts "'o': correct color but incorrect position"
    puts "'-': incorrect color"
    puts
    puts 'NB: score markers are in a randomised order'
  end

  def display_board
    puts
    @guesses.each(&:display)
  end

  def display_win(guess)
    puts
    puts '*' * 48
    puts "Congratulations! The code was #{guess}"
    puts "You guessed it on turn #{guess.number}"
    puts '*' * 48
    puts
  end

  def display_loss
    puts
    puts '~' * 48
    puts "Bad luck! You failed to guess the code: #{@code}"
    puts '~' * 48
    puts
  end
end

puts 'Welcome to Mastermind!'
loop do
  puts 'Would you like to guess? (y/n)'
  input = gets.chomp.downcase
  break Mastermind.new if input == 'y'

  break Mastermind.new(Code.user_prompt) if input == 'n'

  puts 'Invalid response. Try again.'
end
