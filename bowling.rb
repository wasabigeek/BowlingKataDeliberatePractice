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
            totalscore += frame_score + frame_bonus_score
            currentthrow += 1 # advance to next frame
          elsif spare?(currentthrow)
            frame_score = throws[currentthrow] + throws[currentthrow+1]
            frame_bonus_score = throws[currentthrow+2]
            totalscore += frame_score + frame_bonus_score
            currentthrow += 2 # advance to next frame
          else
            frame_score = throws[currentthrow] + throws[currentthrow+1]
            frame_bonus_score = 0
            totalscore += frame_score + frame_bonus_score
            currentthrow += 2 # advance to next frame
          end
          frame += 1
        end
        return totalscore
    end

  def strike?(throw_index)
    throws[throw_index] == 10
  end

  def spare?(throw_index)
    throws[throw_index] + throws[throw_index+1]== 10
  end
end
