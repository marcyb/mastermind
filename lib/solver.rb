# frozen_string_literal: true

# Solver class
class Solver
  def initialize(code, turns)
    @turns = turns
    @code = code
    @permutations = Code.permutations
    @comparison = nil
    solve
  end

  private

  def solve
    @turns.times do |i|
      @guess = @permutations.sample
      @comparison = Comparison.new(@code, @guess)
      summary(i)
      break solved(i) if @comparison.correct?

      filter_permutations!
      puts
      display_win if i == @turns - 1
    end
  end

  def summary(turn)
    puts "#{@permutations.length} permutations left"
    puts "[#{turn + 1}] #{@guess}  --> #{@comparison.join}"
  end

  def filter_permutations!
    @permutations = @permutations.select do |perm|
      Comparison.new(@guess, perm) == @comparison
    end
  end

  def solved(number)
    puts
    puts '~' * 48
    puts "Code #{@code} solved in #{number + 1} turn(s)"
    puts '~' * 48
  end

  def display_win
    puts
    puts '*' * 48
    puts "Congratulations! Code #{@code} was not solved."
    puts '*' * 48
  end
end
