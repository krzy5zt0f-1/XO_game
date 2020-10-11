# gem extension to produce grid in command line
require "terminal-table"
# gem extension to colour X's and O's
require 'colorize'

  # grid to be used
  $rows = [[" ", " ", " "], :separator, [" ", " ", " "],
  :separator, [" ", " ", " "]]
  $tic_tac_toe_table = Terminal::Table.new :rows => $rows

  # hahs with locations on a grid
  $moves = { top_left: $rows[0][0], top_mid: $rows[0][1], top_right: $rows[0][2],
           mid_left: $rows[2][0], mid_mid: $rows[2][1], mid_right: $rows[2][2],
          bottom_left: $rows[4][0], bottom_mid: $rows[4][1], bottom_right: $rows[4][2],
          exit: "exit" }


# Class that defines and runs a game for PvC
 class Game

     @@player1 = []
     @@computer = []
     @@common = []
   def check_if_win(player)
     if player.include?("top_left") && player.include?("top_mid") && player.include?("top_right")
       true
     elsif player.include?("mid_left") && player.include?("mid_mid") && player.include?("mid_right")
       true
     elsif player.include?("bottom_left") && player.include?("bottom_mid") && player.include?("bottom_right")
       true
     elsif player.include?("bottom_right") && player.include?("mid_right") && player.include?("top_right")
       true
     elsif player.include?("bottom_mid") && player.include?("mid_mid") && player.include?("top_mid")
       true
     elsif player.include?("top_left") && player.include?("mid_left") && player.include?("bottom_left")
       true
     elsif player.include?("top_left") && player.include?("mid_mid") && player.include?("bottom_right")
       true
     elsif player.include?("bottom_left") && player.include?("mid_mid") && player.include?("top_right")
       true
     else
       false
     end
   end
   # method to make a turn for X
  def turn_first(player, input)
     player << input
     @@common << input.to_sym
    $moves[input.to_sym].insert(0, "X").delete!(" ")
   end
   # method to make a turn for O
  def turn_second(player, input)
     player << input
     @@common << input.to_sym
    $moves[input.to_sym].insert(0, "O").delete!(" ")
   end
   # method to pass only clear cells
   def good_to_take
     loop do
       input = gets.strip
       if ($moves.keys - @@common).include?(input.to_sym)
         return input
         break
       end
     end
   end
   # method to print up to date grid
   def update
     system "clear"
     puts $tic_tac_toe_table
     print ($moves.keys - @@common)
   end

   def who_starts?
     ["player1", "computer"].sample
   end
   # method to announce if you win/lose
   def check
     puts check_if_win(@@player1) ? "YOU WON!" : "COMPUTER WON!"
   end

   # method to define behaviour of AI
   def ai

   end
   # game run
   def game_run
     update
     i = 1
     x = ""
     decide = who_starts?
     if decide == "computer"
       puts "Computer's turn"
       x = good_to_take
       turn_second(@@computer, x)
       update
     end

     while i <= 4
       puts "Player's turn:"
       x = good_to_take
       if x == "exit"
         break
       else
       turn_first(@@player1, x)
       update
       puts "Computer's turn:"
       x = good_to_take
       turn_second(@@computer, x)
       update
       i += 1
     end
     end
     if x != "exit" && decide == "player1"
     puts "Player's turn:"
     turn_first(@@player1, good_to_take)
     update
   else
   end
   end
 end



h = Game.new
h.game_run
