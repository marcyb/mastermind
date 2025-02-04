# frozen_string_literal: true

require 'delegate'

# Comparison class
class Comparison < SimpleDelegator
  def initialize(code, guess)
    @code = code
    @guess = guess
    @unmatched_code = Hash.new(0)
    @unmatched_guess = Hash.new(0)
    super(matches)
  end

  def correct?
    all? { |c| c == 'x' }
  end

  private

  def matches
    (exact_matches + partial_matches).tap do |arr|
      arr.fill('-', arr.length...4)
    end
  end

  def exact_matches
    result = []
    @code.each_with_index do |color, index|
      if color == @guess[index]
        result << 'x'
      else
        @unmatched_code[color] += 1
        @unmatched_guess[@guess[index]] += 1
      end
    end
    result
  end

  def partial_matches
    result = []
    @unmatched_guess.each do |color, count|
      [count, @unmatched_code[color]].min.times do
        result << 'o'
      end
    end
    result
  end
end
