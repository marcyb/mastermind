# frozen_string_literal: true

require 'colorize'
require 'delegate'

# Code class
class Code < SimpleDelegator
  COLORS = {
    'r' => 'red',
    'g' => 'green',
    'b' => 'blue',
    'y' => 'yellow',
    'm' => 'magenta',
    'w' => 'white'
  }.freeze

  def initialize(code = generate_code)
    super(code)
  end

  class << self
    def user_prompt
      puts
      puts '-' * 12
      puts "Input 4 colors: (#{Code::COLORS.keys.join(' ')})"
      puts
      input_code
    end

    def from_color_code_char_arr(arr)
      Code.new(arr.map { |k| COLORS.fetch(k) })
    end

    def permutations
      COLORS.keys.repeated_permutation(4).map { |arr| from_color_code_char_arr(arr) }
    end

    private

    def input_code
      while (input = gets.chomp.chars)
        return Code.from_color_code_char_arr(input) if valid_input?(input)

        puts 'Invalid code!'
      end
    end

    def valid_input?(input)
      input.length == 4 && input.all? { |color| COLORS.keys.include?(color) }
    end
  end

  private

  def generate_code
    Array.new(4) { COLORS.values.sample }
  end

  def to_s
    map { |color| '#'.colorize(color: color.to_sym, background: :black) }.join(' ')
  end
end
