# Tic-tac-toe
# Created:  2017-12-02
# Updated:  2017-12-05 
# Learning to code or something

# TODO - computer player vs 'AI'
# => AI has to RNG cell & check if not already taken
# TODO

class HumanPlayer
  attr_reader :letter
  # below is identical to above
  #def letter
  #  @letter
  #end

  def initialize(letter)
    @letter = letter
  end

  def get_move(board)
    print "Your move #{@letter}\n"
    print "Which cell?: "

    cell = nil
    while cell.nil?
      cell = gets.chomp
      begin
        cell = Integer(cell)
      rescue ArgumentError => e
        puts "Must be a number"
        cell = nil
        next
      end
      if cell > 8 || cell < 0
        puts "Cell out of range"
        cell = nil
        next
      end
      if ! board.empty?(cell)
        puts "Space taken"
        cell = nil
        next
      end
    end

    cell
  end
end

class AIPlayer
  def initialize(letter)
    @letter = letter
  end
end

class Board
  EMPTY = " "

  def initialize
    @cells = Array.new(9, EMPTY)
  end

  # build the table
  def to_s
    "#{@cells[0]}|#{@cells[1]}|#{@cells[2]}\n" +
    "-+-+-\n" +
    "#{@cells[3]}|#{@cells[4]}|#{@cells[5]}\n" +
    "-+-+-\n" +
    "#{@cells[6]}|#{@cells[7]}|#{@cells[8]}\n"
  end

# record move
  def move!(cell, letter)
    @cells[cell] = letter
  end

# check if cell is empty
  def empty?(cell)
    @cells[cell] == EMPTY
  end

# winning scenarios
WINNING_ROWS = [
  [0,1,2],
  [3,4,5],

]
  def winner(players)
    players
      .map{|player| player.letter } #turn player into letter
      .each do |mark| #loops over letters
      WINNING_ROWS.each { |row| #loops winning scenarios
        actual = row.map{|index| @cells[index] } #grabs value of cell from WINNING_ROWS index
        return mark if actual.all? {|c| c == mark} #returns letter if all cells have letter
      }
      # above does same as below

      # check all 8 winning scenarios
      #return mark if [@cells[0], @cells[1], @cells[2]].all? {|c| c == mark}
      #return mark if [@cells[3], @cells[4], @cells[5]].all? {|c| c == mark}
      #return mark if [@cells[6], @cells[7], @cells[8]].all? {|c| c == mark}
      #return mark if [@cells[0], @cells[3], @cells[6]].all? {|c| c == mark}
      #return mark if [@cells[1], @cells[4], @cells[7]].all? {|c| c == mark}
      #return mark if [@cells[2], @cells[5], @cells[8]].all? {|c| c == mark}
      #return mark if [@cells[0], @cells[4], @cells[8]].all? {|c| c == mark}
      #return mark if [@cells[2], @cells[4], @cells[6]].all? {|c| c == mark}
    end
    # all cells filled, but no winner
    return "No Winner" if @cells.all? {|c| c != EMPTY}

    # no winner / draw
    return nil
  end

end

class Game

  def initialize
    @board = Board.new #create board
    @players =  [HumanPlayer.new("x"), HumanPlayer.new("o")] #create 2 players
    @next_player = @players.cycle #alternate between the 2 players
  end


  def run
    while ! @board.winner(@players) #while no winner from @board
      player = @next_player.next #alternate players
      move = player.get_move(@board) #asks player for move
      @board.move!(move, player.letter) #records move

      puts @board #prints board
    end

    puts "Game over: #{@board.winner(@players)}"
  end

end

g = Game.new #create game object

g.run #runs Game.run function
