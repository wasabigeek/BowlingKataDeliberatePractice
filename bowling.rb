class Bowling
  class Strike
    def self.match?(score)
      score == 10
    end

    def self.base_score
      10
    end

    def self.get_bonus_score(throws, current_index)
      throws[current_index + 1] + throws[current_index + 2]
    end

    def self.throws
      1
    end
  end

  def initialize
    @throws = []
    # 1, 9, 4
  end

  attr_reader :throws
  def throw(pins)
    @throws.push(pins)
  end

  # come back to this after refactoring
  # def display
  #   output = []
  #   current_frame = []
  #   @throws.each_with_index do |pins, current_throw|
  #     if strike?(current_throw)
  #       current_frame << pins
  #       next if output.size == 9 && current_frame.size < 3 # final frame display

  #       output << current_frame
  #       current_frame = []
  #     else
  #       current_frame << pins
  #       if current_frame.size == 2
  #         output << current_frame
  #         current_frame = []
  #       end
  #     end
  #   end

  #   output
  # end

  def score
    frame = 1
    currentthrow = 0
    totalscore = 0
    while frame <= 10 do
      if Strike.match?(throws[currentthrow])
        frame_score = Strike.base_score
        frame_bonus_score = Strike.get_bonus_score(throws, currentthrow)
        currentthrow += Strike.throws
      elsif spare?(currentthrow, currentthrow + 1)
        frame_score = throws[currentthrow] + throws[currentthrow+1]
        frame_bonus_score = throws[currentthrow+2]
        currentthrow += 2 # advance to next frame
      else
        frame_score = throws[currentthrow] + throws[currentthrow+1]
        frame_bonus_score = 0
        currentthrow += 2 # advance to next frame
      end
      totalscore += frame_score + frame_bonus_score
      frame += 1
    end
    return totalscore
  end

  def spare?(throw_index, throw2_index)
    throws[throw_index] + throws[throw2_index] == 10
  end
end
