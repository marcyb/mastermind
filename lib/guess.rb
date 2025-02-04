# frozen_string_literal: true

require_relative 'code'
require_relative 'comparison'

# Guess class
class Guess < Code
  attr_reader :number

  def initialize(number, code)
    @number = number + 1
    super(Code.user_prompt)
    @comparison = Comparison.new(code, self)
  end

  def display
    puts "[#{@number}] #{self}  --> #{@comparison.join}"
  end

  def correct?
    @comparison.correct?
  end
end
