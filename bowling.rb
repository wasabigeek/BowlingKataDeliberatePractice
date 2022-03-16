class Bowling
  class DefaultThrow
    def initialize(throws:, frame_start_index:)
      @throws = throws
      @frame_start_index = frame_start_index
    end

    def self.match?(throws, current_index)
      throws[current_index] + throws[current_index + 1] < 10
    end

    def base_score
      @throws[@frame_start_index] + @throws[@frame_start_index + 1]
    end

    def get_bonus_score
      0
    end

    def throws
      2
    end
  end

  class Strike < DefaultThrow
    def self.match?(throws, current_index)
      throws[current_index] == 10
    end

    def base_score
      10
    end

    def get_bonus_score
      @throws[@frame_start_index + 1] + @throws[@frame_start_index + 2]
    end

    def throws
      1
    end
  end

  class Spare < DefaultThrow
    def self.match?(throws, current_index)
      throws[current_index] + throws[current_index + 1] == 10
    end

    def base_score
      10
    end

    def get_bonus_score
      @throws[@frame_start_index + 2]
    end

    def throws
      2
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
      frame_type = if Strike.match?(throws, currentthrow)
                      Strike.new(throws: throws, frame_start_index: currentthrow)
                    elsif Spare.match?(throws, currentthrow)
                      Spare.new(throws: throws, frame_start_index: currentthrow)
                    else
                      DefaultThrow.new(throws: throws, frame_start_index: currentthrow)
                    end

      totalscore += frame_type.base_score + frame_type.get_bonus_score
      currentthrow += frame_type.throws
      frame += 1
    end
    return totalscore
  end
end
