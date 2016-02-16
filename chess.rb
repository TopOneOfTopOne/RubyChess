#!/usr/bin/ruby -w

class Chess
    def init()
        # init instance vars
        @turn = 0
        @gameOver = false
        @boardDim = 8
        @board = Array.new(@boardDim) { Array.new(@boardDim) }
        for y in 0..@boardDim - 1 do
            for x in 0..@boardDim - 1 do
                @board[y][x] = " "
            end
        end
        @symbolKing = "K"
        @symbolQueen = "Q"
        @symbolBishop = "B"
        @symbolKnight = "H"
        @symbolCastle = "C"
    end

    def loop()
        # run the game loop until the game is over
        while !@gameOver do
            update()
            draw()     
        end
    end

    def update()
        # check whose turn it is
        player = false
        if @turn % 2 == 0 then
            player = true
        end
        
        # get user input
        userInput = gets
        args = userInput.split(" ")
        
        # check if the input is in the corect format
        if args.length != 3 then
            puts "usage: <piece> <x> <y>"
            update()
            return
        end
        
        # increment the turn counter
        @turn += 1
    end

    def draw()
        puts(@boardDim)
        
        # print first row of labels
        print("    1   2   3   4   5   6   7   8\n")
        # iterate over twice as many rows as boardDim as every second row is a line
        for y in 0 .. (@boardDim * 2) do
            # print the y labels only on odd rows, otherwise print a space to keep correct formatting
            if y % 2 != 0 then
                print("#{(y+1)/2} ")
            else
                print("  ")
            end
            # iterate over every column in the row
            for x in 0 .. (@boardDim - 1) do
                # every even row is a line, and every odd row is a space/piece
                if y % 2 == 0 then
                    print("+---")
                else
                    print("| #{@board[y / 2][x]} ")
                end
            end
            if y % 2 == 0 then
                print("+")
            else
                print("| #{(y+1)/2}")
            end
            print("\n")
        end
        print("    1   2   3   4   5   6   7   8\n")
    end
end

chess = Chess.new()
chess.init()
chess.loop()