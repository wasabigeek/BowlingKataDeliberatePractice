class Bowling
  def initialize
    @throws = []
    # 1, 9, 4
  end

  attr_reader :throws
  def throw(pins)
    @throws.push(pins)
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
