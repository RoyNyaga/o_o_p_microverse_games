class Player
  attr_accessor :name, :identity

  def initialize(name, identity)
    @name = name
    @identity = identity
  end
# takes the players choice, verifies if it is valid then returns only valid choices.
  def player_choice
    for i in 0..0
      puts "#{@name} Enter you choice"
      a = gets.chomp
      if !["1","2","3","4","5","6","7","8","9"].include?a
        puts "Enter single digit numbers only from 1 to 9"
        redo # repeats the loop until players choice is a number.
      end
    end
    return a
  end
# returns a board containing the new choice made by the player
  def add_players_identy_to_board(board,one)
    board.each do |num|
      num.each_with_index do |value, index|
        if "#{value}" == one
          num[index] = "#{@identity}"
        end
      end
    end
    return board
  end
end

class Board

  attr_accessor :content

  def initialize(content)
    @content = content
  end

# displays baord content
  def display_board
    @content.each do |subarray|
    puts subarray.join(" | "), "̣---------"
    end
  end

# spreads out the board

  def ungroup_board(board)
    array = Array.new
    board.each do |num|
      num.each_with_index do |value|
        array << value
      end
    end
    return array
  end

end

def decide_winner(player_board, board1)

  conditions_winning_1 = [ ["x", "x", "x"], ["o","o","o"] ]
  sample = board1.ungroup_board(player_board)
# since "include" method could not compute "include?.[ sample[0], sample[3], sample[6] ]" i had to pass
# the former to the variables sample4,5,6, etc
  sample4 = [ sample[0], sample[3], sample[6] ]
  sample5 = [ sample[1], sample[4], sample[7] ]
  sample6 = [ sample[2], sample[5], sample[8] ]
  sample7 = [ sample[0], sample[4], sample[8] ]
  sample8 = [ sample[2], sample[4], sample[6] ]
# winning conditions
  if conditions_winning_1.include?sample[0,3] or conditions_winning_1.include?sample[3,3] or
    conditions_winning_1.include?sample[6,3] or conditions_winning_1.include?sample4 or
    conditions_winning_1.include?sample5 or conditions_winning_1.include?sample6 or
    conditions_winning_1.include?sample7 or conditions_winning_1.include?sample8
    return true
  else
    return false
  end

end
#checks if the choice has ones been selected if true, it prompts the user to enter an unselected choice
def check_choice_existence(already_selected_choices, player)

  for i in 0..0
    choice_to_be_checked = player.player_choice
    if already_selected_choices.include?choice_to_be_checked
      puts "This number has already been used, please select an unused number"
      redo # repeats the iteration until an unselected choice is being entered.
    end
  end
  return choice_to_be_checked
end

def isDraw?(selected)
  if selected.length == 9
    puts "NO MORE EMPTY SPACES AVAILABLE, CONSIDER IT A DRAW. PLEASE RESTART THE GAME"
    return true
  end 
end


def gameRound(player1, player2)
  already_selected_choices = []
  board1 = Board.new([[1,2,3],[4,5,6],[7,8,9]])
  board1.display_board
  loop do     
    chosen = check_choice_existence(already_selected_choices, player1)
    already_selected_choices << chosen #stores selected choice
    one = player1.add_players_identy_to_board(board1.content, chosen)
    if decide_winner(one, board1) == true
        board1.display_board
       puts "CONGRATULATIONS!!! #{player1.name}, You win!!!"
       break
    end
    board1.display_board
    break if isDraw?(already_selected_choices) 
    chosen = check_choice_existence(already_selected_choices, player2)
    already_selected_choices << chosen
    two = player2.add_players_identy_to_board(board1.content,chosen)
    board1.display_board
    if decide_winner(two, board1) == true
       puts "CONGRATULATIONS!!! #{player2.name}, You win!!!"
       break
    end
  end
end

def tic_tac_toe

  puts "READY TO PALY TIC-TAC-TOE"
  puts "LET'S GO!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  board1 = Board.new([[1,2,3],[4,5,6],[7,8,9]])
  player1 = Player.new("Player One", "x")
  player2 = Player.new("Player Two", "o")
  gameRound(player1, player2)

end
tic_tac_toe
