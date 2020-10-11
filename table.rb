require "terminal-table"
# rows of XO grid
rows = []
rows << [" ", " ", " "]
rows << :separator
rows << [" ", " ", " "]
rows << :separator
rows << [" ", " ", " "]
# table for the game
tic_tac_toe_table = Terminal::Table.new :rows => rows

puts tic_tac_toe_table
