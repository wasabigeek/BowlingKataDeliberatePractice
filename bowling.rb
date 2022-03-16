class Bowling
  class DefaultFrame
    def initialize(throws:, frame_start_index:)
      @throws = throws
      @frame_start_index = frame_start_index
    end

    def self.match?(throws, current_index)
      throws[current_index] + throws[current_index + 1] < 10
    end

    def score
      base_score + bonus_score
    end

    def next_frame_index
      @frame_start_index + 2
    end

    private

    def base_score
      @throws[@frame_start_index] + @throws[@frame_start_index + 1]
    end

    def bonus_score
      0
    end
  end

  class StrikeFrame < DefaultFrame
    def self.match?(throws, current_index)
      throws[current_index] == 10
    end

    def next_frame_index
      @frame_start_index + 1
    end

    private

    def base_score
      10
    end

    def bonus_score
      @throws[@frame_start_index + 1] + @throws[@frame_start_index + 2]
    end
  end

  class SpareFrame < DefaultFrame
    def self.match?(throws, current_index)
      throws[current_index] + throws[current_index + 1] == 10
    end

    private

    def bonus_score
      @throws[@frame_start_index + 2]
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
    frames = []
    frame_count = 1
    currentthrow = 0
    while frame_count <= 10 do
      # a big assumption here is we are looking back on a finished game,
      # and that we know the start index of each frame based on the previous frame.
      # also, this probably isn't very helpful given that bowling's rules are pretty fixed
      frame_type = if StrikeFrame.match?(throws, currentthrow)
                      StrikeFrame
                    elsif SpareFrame.match?(throws, currentthrow)
                      SpareFrame
                    else
                      DefaultFrame
                    end

      current_frame = frame_type.new(throws: throws, frame_start_index: currentthrow)
      currentthrow = current_frame.next_frame_index
      frames << current_frame
      frame_count += 1
    end

    frames.sum(&:score)
  end
end
