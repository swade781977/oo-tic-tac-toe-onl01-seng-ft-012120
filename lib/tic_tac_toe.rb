require 'pry'
class TicTacToe
  
  def initialize(board = nil)
    @board =board || Array.new(9, " ")
  end
  
  WIN_COMBINATIONS = [[0,1,2],[3,4,5],[2,5,8],[6,7,8],[0,3,6],[1,4,7],[0,4,8],[6,4,2]]
  
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end
  
  def input_to_index(input)
    input = input.to_i  
    input - 1
  end
  def move(square, token="X")
    @board[square] = token
  end
  def position_taken?(position)
    if @board[position].include?("X") || @board[position].include?("O")
      true   
    else
      false 
    end
  end
  def valid_move?(position)
    if position.between?(0, 8) && position_taken?(position) == false 
        true
    else
      false
    end
  end
  def turn 
    puts "Please choose a square \(1-9\)."
    position = gets.strip
    position = input_to_index(position)
    
    while valid_move?(position) == false 
      puts "please make sure the chosen square is included in \(1-9\) and choose again."
      position = gets.strip
      position = input_to_index(position)
    end
    move(position,current_player)
    display_board
  end
  def turn_count
    countx = @board.count("X")
    counto = @board.count("O")
    count = countx + counto
    count
  end
  def current_player
    if turn_count % 2 == 0
      return "X"
    else
      return "O"
    end
  end
   def won?
    winx =[]
    wino = []
    @board.each_with_index do |item, index|
      if item == "X"
        winx.push(index)
      elsif item == "O"
        wino.push(index)
      else
      end
    end
    a = nil
    WIN_COMBINATIONS.each do |combos|
      if combos.all?{|place| winx.include?(place)}
        a = combos
      elsif combos.all?{|place| wino.include?(place)}
        a = combos
      end
    end
    a
  end
  def full?
    if turn_count == 9
      true
    end
  end
  def draw?
    if full? == true && won? == nil
      true
    elsif won? != nil
      false
    elsif full? != true && won? != nil
      false
    end
  end
  def over?
    if draw? == true || won? != nil
      true
    end
  end
  def winner
    if won? != nil
      if current_player == "X"
        "O"
      else
        "X"
      end
    end
  end
  def play 
    until over?
      turn
    end
      if won?
        puts "Congratulations #{winner}!"
      elsif draw?
        puts "Cat's Game!"
      end
  end
end