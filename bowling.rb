class Bowling
  def initialize
    @throws = []
    # 1, 9, 4
  end

  attr_reader :throws
  def throw(pins)
    @throws.push(pins)
  end

  # come back to this after refactoring
  def display
    output = []
    current_frame = []
    @throws.each_with_index do |pins, current_throw|
      if strike?(current_throw)
        current_frame << pins
        next if output.size == 9 && current_frame.size < 3 # final frame display

        output << current_frame
        current_frame = []
      else
        current_frame << pins
        if current_frame.size == 2
          output << current_frame
          current_frame = []
        end
      end
    end

    output
  end

  def score
    frame = 1
    currentthrow = 0
    totalscore = 0
    while frame <= 10 do
      if strike?(currentthrow)
        frame_score = throws[currentthrow]
        frame_bonus_score = throws[currentthrow+1] + throws[currentthrow+2]
        currentthrow += 1 # advance to next frame
      else
        frame_score = throws[currentthrow] + throws[currentthrow+1]
        if spare?(currentthrow, currentthrow + 1)
          frame_bonus_score = throws[currentthrow+2]
        else
          frame_bonus_score = 0
        end
        currentthrow += 2 # advance to next frame
      end
      totalscore += frame_score + frame_bonus_score
      frame += 1
    end
    return totalscore
  end

  def strike?(throw_index)
    throws[throw_index] == 10
  end

  def spare?(throw_index, throw2_index)
    throws[throw_index] + throws[throw2_index] == 10
  end
end
