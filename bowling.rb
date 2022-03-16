class Bowling

    def initialize
        @throws = []
    end

    def throw(pins)
        @throws.push(pins)
    end

    def score
        game = @throws
        frame = 1
        currentthrow = 0
        totalscore = 0
        while frame <= 10 do
            if game[currentthrow] == 10
                totalscore += 10+game[currentthrow+1]+game[currentthrow+2]
                frame += 1
                currentthrow += 1
            elsif game[currentthrow] + game[currentthrow+1] == 10
                totalscore += 10+game[currentthrow+2]
                frame += 1
                currentthrow += 2
            else
                totalscore += game[currentthrow] + game[currentthrow+1]
                frame += 1
                currentthrow += 2
            end
        end
        return totalscore
    end

end
