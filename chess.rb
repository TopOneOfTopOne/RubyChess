#!/usr/bin/ruby -w

# provides string coloring functionality
class String
    def black;          "\e[30m#{self}\e[0m" end
    def red;            "\e[31m#{self}\e[0m" end
    def green;          "\e[32m#{self}\e[0m" end
    def brown;          "\e[33m#{self}\e[0m" end
    def blue;           "\e[34m#{self}\e[0m" end
    def magenta;        "\e[35m#{self}\e[0m" end
    def cyan;           "\e[36m#{self}\e[0m" end
    def grey;           "\e[37m#{self}\e[0m" end

    def bg_black;       "\e[40m#{self}\e[0m" end
    def bg_red;         "\e[41m#{self}\e[0m" end
    def bg_green;       "\e[42m#{self}\e[0m" end
    def bg_brown;       "\e[43m#{self}\e[0m" end
    def bg_blue;        "\e[44m#{self}\e[0m" end
    def bg_magenta;     "\e[45m#{self}\e[0m" end
    def bg_cyan;        "\e[46m#{self}\e[0m" end
    def bg_grey;        "\e[47m#{self}\e[0m" end

    def bold;           "\e[1m#{self}\e[22m" end
    def italic;         "\e[3m#{self}\e[23m" end
    def underline;      "\e[4m#{self}\e[24m" end
    def blink;          "\e[5m#{self}\e[25m" end
    def reverse_color;  "\e[7m#{self}\e[27m" end
end

class ChessPiece
    def initialize(x, y)
        if y == 1 then # black special row
            @team = :blackTeam
            case x
            when 1
                @pieceID = :castle
            when 2
                @pieceID = :knight
            when 3
                @pieceID = :bishop
            when 4
                @pieceID = :queen
            when 5
                @pieceID = :king
            when 6
                @pieceID = :bishop
            when 7
                @pieceID = :knight
            when 8
                @pieceID = :castle
            end
        elsif y == 2 then # black pawn row
            @team = :blackTeam
            @pieceID = :pawn
        elsif y == 8 then # white special row
            @team = :whiteTeam
            case x
            when 1
                @pieceID = :castle
            when 2
                @pieceID = :knight
            when 3
                @pieceID = :bishop
            when 4
                @pieceID = :queen
            when 5
                @pieceID = :king
            when 6
                @pieceID = :bishop
            when 7
                @pieceID = :knight
            when 8
                @pieceID = :castle
            end
        elsif y == 7 then # white pawn row
            @team = :whiteTeam
            @pieceID = :pawn
        else
            @pieceID = :empty
        end
    end
    
    def symbol
        case @pieceID
        when :empty
            return " "
        when :castle
            if @team == :blackTeam
                return $symbolCastle
            end
            return $symbolCastle.reverse_color
        when :knight
            if @team == :blackTeam
                return $symbolKnight
            end
            return $symbolKnight.reverse_color
        when :bishop
            if @team == :blackTeam
                return $symbolBishop
            end
            return $symbolBishop.reverse_color
        when :queen
            if @team == :blackTeam
                return $symbolQueen
            end
            return $symbolQueen.reverse_color
        when :king
            if @team == :blackTeam
                return $symbolKing
            end
            return $symbolKing.reverse_color
        when :pawn
            if @team == :blackTeam
                return $symbolPawn
            end
            return $symbolPawn.reverse_color
        end
    end
end

class Game
    def initialize()
        # init instance vars
        @turn = 0
        @gameOver = false
        @boardDim = 8
        @board = Array.new(@boardDim) { Array.new(@boardDim) }
        for y in 0..@boardDim - 1 do
            for x in 0..@boardDim - 1 do
                @board[y][x] = ChessPiece.new(x + 1, y + 1)
            end
        end
        $symbolKing = "K"
        $symbolQueen = "Q"
        $symbolBishop = "B"
        $symbolKnight = "H"
        $symbolCastle = "C"
        $symbolPawn = "P"
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
            puts "usage: <piece> <col> <row>"
            update()
            return
        end
        
        col = args[1]
        row = args[2]
        
        # increment the turn counter
        @turn += 1
    end

    def draw()
        puts(@boardDim)
        
        # print first row of labels
        print("    a   b   c   d   e   f   g   h\n")
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
                    print("| #{@board[y / 2][x].symbol} ")
                end
            end
            if y % 2 == 0 then
                print("+")
            else
                print("| #{(y+1)/2}")
            end
            print("\n")
        end
        print("    a   b   c   d   e   f   g   h\n")
    end
end

game = Game.new()
game.loop()