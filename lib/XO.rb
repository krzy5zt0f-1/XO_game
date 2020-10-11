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
    $moves[input.to_sym].insert(0, "X".colorize(:red)).delete!(" ")
   end
   # method to make a turn for O
  def turn_second(player, input)
     player << input
     @@common << input.to_sym
    $moves[input.to_sym].insert(0, "O".colorize(:green)).delete!(" ")
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
   end

   def who_starts?
     ["player1", "computer"].sample
   end
   # method to announce if you win/lose/draw
   def check
     if check_if_win(@@player1)
       for i in 1..13 do
         system "clear"
        puts $tic_tac_toe_table
        puts i % 2 == 0 ? "   YOU WON!".colorize(:red) : "   YOU WON!".colorize(:green)
        sleep(0.5)
       end
     elsif check_if_win(@@computer)
       for i in 1..13 do
         system "clear"
        puts $tic_tac_toe_table
        puts i % 2 == 0 ? "COMPUTER WON!".colorize(:green) : "COMPUTER WON!".colorize(:red)
        sleep(0.5)
       end
     elsif @@x == "exit" && @@common.count <= 9
       puts " "
     else
       for i in 1..13 do
         system "clear"
        puts $tic_tac_toe_table
        puts i % 2 == 0 ? "IT'S A DRAW!".colorize(:green) : "IT'S A DRAW!".colorize(:red)
        sleep(0.5)
       end
     end
   end

   # method to define behaviour of AI
   def ai
     if @@common.count == 9
       $moves[:exit]
     elsif @@common.count == 0
       ($moves.keys - [:exit, :top_mid, :mid_left, :mid_right, :bottom_mid]).sample.to_s
     elsif [:top_right, :top_left, :bottom_right, :bottom_left].include?(@@x) && ($moves.keys - @@common).include?(:mid_mid)
       $moves[:mid_mid]
     else
       ($moves.keys - @@common - [:exit]).sample.to_s
     end
   end
   # game run
   def game_run
     update
     i = 1
     @@x = ""
     decide = who_starts?
     if decide == "computer"
       puts "Computer's turn"
       @@x = ai
       sleep(1)
       turn_second(@@computer, @@x)
       update
     end
     while @@common.count <= 8
       puts "Player's turn:"
       @@x = good_to_take
       if @@x == "exit"
         break
       else
       turn_first(@@player1, @@x)
       update
       break if check_if_win(@@player1)
       puts "Computer's turn:"
       @@x = ai
       sleep(1)
       turn_second(@@computer, @@x)
       update
       break if check_if_win(@@computer)
     end
     end
     check
   end
 end

# class that holds a front screen animation

class Animation
def front
  for i in 1..13 do
   system "clear"
   puts i % 2 == 0 ? File.read(File.dirname(__FILE__) + '/front0.txt').colorize(:red) : File.read(File.dirname(__FILE__) + '/front0.txt').colorize(:green)
   sleep(0.5)
  end
end
def back

end
end

# class to hold game menu

class Menu
def initialize
  @g = Game.new
  @a = Animation.new
  menu
end
# choices of Menu
def process(selection)
  case selection
  when "1"
    puts "You'r goal is to cross three cells in vertical, horizontal"
    puts "diagonal direction."
    puts "To play, just input which cell you would like to cross and hit return."
    puts "For example, `to_left` will mark top left corner of a grid, `mid_mid`"
    puts "will mark the middle, `bottom_right` will mark bottom right corner etc."
    puts " To exit a current game just type in `exit and hit return.`"
  when "2"
    @g.game_run
  when "3"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end
def menu_options
  puts "--------------------------------------------------"
  puts "1. Game instructions [press: 1]"
  puts "2. Start game [press: 2]"
  puts "3. Exit [press 3]"
end
def menu
  @a.front
  sleep (1)
  loop do
    menu_options
    process(STDIN.gets.strip)
  end
end
end

t= Menu.new
