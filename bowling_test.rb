require_relative "bowling"
require "minitest/autorun"

class BowlingTest < Minitest::Test
  def test_game_with_open_frames_only
    newgame = Bowling.new
    21.times{newgame.throw 2}
    assert_equal 40, newgame.score
  end

  def test_game_with_all_strikes
    newgame = Bowling.new
    12.times{newgame.throw 10}
    assert_equal 300, newgame.score
  end

  def test_game_with_all_nines
    newgame = Bowling.new
    10.times do
     newgame.throw 9
     newgame.throw  0
    end
    assert_equal 90, newgame.score
  end

  def test_game_with_all_spares
    newgame = Bowling.new
    10.times do
     newgame.throw 5
     newgame.throw  5
    end
    newgame.throw  5

    assert_equal 150, newgame.score
  end

  def test_bonus_roll
    newgame = Bowling.new
    10.times do
     newgame.throw 9
     newgame.throw  0
    end
    assert_equal 90, newgame.score
  end
end

# class BowlingPrintTest < Minitest::Test
#   def test_game_with_open_frames_only
#     newgame = Bowling.new
#     20.times { newgame.throw 2 }

#     expected = []
#     10.times { expected << [2, 2] }

#     assert_equal(
#       expected,
#       newgame.display
#     )
#   end

#   def test_game_with_all_strikes
#     newgame = Bowling.new
#     12.times{newgame.throw 10}

#     expected = []
#     9.times { expected << [10] }
#     expected << [10, 10, 10]

#     assert_equal(
#       expected,
#       newgame.display
#     )
#   end
# end