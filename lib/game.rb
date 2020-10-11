# gem extension to produce grid in command line
require "terminal-table"
# gem extension to colour X's and O's
require 'colorize'
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
  @a = Animation.new
  menu
end
# description of rules
def rules
  system "clear"
  puts "You'r goal is to cross three cells in vertical, horizontal"
  puts "or diagonal direction."
  puts "To play, just input which cell you would like to cross and hit return."
  puts "For example, `top_left` will mark top left corner of a grid, `mid_mid`"
  puts "will mark the middle, `bottom_right` will mark bottom right corner etc."
  puts " To exit a current game just type in `exit` and hit return."
end
# choices of Menu
def process(selection)
  case selection
  when "1"
    rules
  when "2"
    system("ruby XO.rb")
  when "3"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end
def menu_options
  puts "--------------------------------------------------"
  puts "1. Game instructions [press: 1]"
  puts "2. Start a new game [press: 2]"
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
Menu.new
