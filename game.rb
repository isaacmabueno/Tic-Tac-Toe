class Game
  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @corner_turn = false
    @computer = "X"
    @human = "O"
    @turn = nil
  end

  def start_game
    puts "Welcome to my Tic Tac Toe game"
    puts "|_#{@board[0]}_|_#{@board[1]}_|_#{@board[2]}_|\n|_#{@board[3]}_|_#{@board[4]}_|_#{@board[5]}_|\n|_#{@board[6]}_|_#{@board[7]}_|_#{@board[8]}_|\n"
    puts "Please type your marker X or O and hit enter"
    pick_marker
    puts "Type 1 to make the first move, 2 to go second"
    first_move

    until game_is_over(@board) || tie(@board)
      if @turn == true

          puts "|_#{@board[0]}_|_#{@board[1]}_|_#{@board[2]}_|\n|_#{@board[3]}_|_#{@board[4]}_|_#{@board[5]}_|\n|_#{@board[6]}_|_#{@board[7]}_|_#{@board[8]}_|\n"
          puts "please select your spot"
          get_human_spot
      else
          eval_board
      end
      if !game_is_over(@board) && !tie(@board)
        if @turn == false
            puts "|_#{@board[0]}_|_#{@board[1]}_|_#{@board[2]}_|\n|_#{@board[3]}_|_#{@board[4]}_|_#{@board[5]}_|\n|_#{@board[6]}_|_#{@board[7]}_|_#{@board[8]}_|\n"

            puts "Please select your spot"
            get_human_spot
        else
            eval_board
        end
      end
    end
    if game_is_over(@board)
      puts "|_#{@board[0]}_|_#{@board[1]}_|_#{@board[2]}_|\n|_#{@board[3]}_|_#{@board[4]}_|_#{@board[5]}_|\n|_#{@board[6]}_|_#{@board[7]}_|_#{@board[8]}_|\n"
      puts "Game Over!"
    elsif tie(@board)
      puts "It's a draw!"
    end
  end
  def pick_marker
      input = nil
      until input
      input = gets.chomp.upcase
      if input == "X"
          @human = "X"
          @computer =  "O"
      elsif input == "O"
          @human = "O"
          @computer = "X"
      else
        puts "|Sorry, that input was invalid| \nPlease type your marker X or O and hit enter"
        input = nil
      end
    end
  end

  def first_move
      input = nil
    until input
      input = gets.chomp.to_i
      if input == 1
         @turn = true
      elsif input == 2
        @turn = false
      else
        puts "|Sorry, that input was invalid| \nType 1 to make the first move, 2 to go second"
        input = nil
      end
    end
  end

  def get_human_spot
    spot = nil
    until spot
      spot = gets.chomp
      if !@board.include? spot
         spot = nil
         puts "|Sorry, that input was invalid| \nPlease select your spot"
         next
      else
          spot = spot.to_i
      end
      if @board[spot] != "X" && @board[spot] != "O" && @board[spot] != nil
        @board[spot] = @human
      else
        spot = nil
      end
    end
  end

  def eval_board
    spot = nil
    until spot
    if @board[4] == "4"
        spot = 4
        @board[spot] = @computer
      else
        spot = get_best_move(@board, @computer)
        if @board[spot] != "X" && @board[spot] != "O"
          @board[spot] = @computer
        else
          spot = nil
        end
      end
    end
    puts "the computer placed on " + spot.to_s
  end

  def get_best_move(board, next_player, depth = 0, best_score = {})

    if @corner_turn == false && @turn == false;
        available_spaces = []
        best_move = nil

        board.each do |s|
          if s != "X" && s != "O"
              if ["0", "2", "6", "8"].include? s
                available_spaces << s
              end
          end
        end
        @corner_turn = true
        n = rand(0...available_spaces.count)
        return available_spaces[n].to_i
    elsif @turn == true && @corner_turn ==false;
      available_spaces = []
      best_move = nil
      board.each do |s|
        if s != "X" && s != "O"
          available_spaces << s
        end
      end
      available_spaces.each do |as|
        board[as.to_i] = @computer
        if game_is_over(board)
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        else
          board[as.to_i] = @human
          if game_is_over(board)
            best_move = as.to_i
            board[as.to_i] = as
            @corner_turn = true
            return best_move
          else
            board[as.to_i] = as
          end
        end
      end
      if best_move == nil
          puts "NIL"
      else
          puts best_move
      end
      if best_move == nil
        available_laterals = []
        board.each do |s|
          if s != "X" && s != "O"
              if ["1", "3", "5", "7"].include? s
                available_laterals << s
              end
          end
        end
        @corner_turn = true
        puts available_laterals
        n = available_laterals[rand(0...available_laterals.count)].to_i
        puts n.to_s
        return n
      end
    else
        available_spaces = []
        best_move = nil
        board.each do |s|
          if s != "X" && s != "O"
            available_spaces << s
          end
        end
        available_spaces.each do |as|
          board[as.to_i] = @computer
          if game_is_over(board)
            best_move = as.to_i
            board[as.to_i] = as
            return best_move
          else
              board[as.to_i] = as
          end
        end
        available_spaces.each do |as|
            board[as.to_i] = @human
            if game_is_over(board)
              best_move = as.to_i
              board[as.to_i] = as
              return best_move
            else
              board[as.to_i] = as
            end
        end
    end

    if best_move
      return best_move
    else
      n = rand(0..available_spaces.count)
      return available_spaces[n].to_i
    end
  end

  def game_is_over(b)

    [b[0], b[1], b[2]].uniq.length == 1 ||
    [b[3], b[4], b[5]].uniq.length == 1 ||
    [b[6], b[7], b[8]].uniq.length == 1 ||
    [b[0], b[3], b[6]].uniq.length == 1 ||
    [b[1], b[4], b[7]].uniq.length == 1 ||
    [b[2], b[5], b[8]].uniq.length == 1 ||
    [b[0], b[4], b[8]].uniq.length == 1 ||
    [b[2], b[4], b[6]].uniq.length == 1
  end

  def tie(b)
    b.all? { |s| s == "X" || s == "O" }
  end


end

game = Game.new
game.start_game
