require "terminal-table"

@rows = [[" ", " ", " "], :separator, [" ", " ", " "],
:separator, [" ", " ", " "]]
@tic_tac_toe_table = Terminal::Table.new :rows => @rows



@rows[0][1].insert(0, "X").delete!(" ")

puts @tic_tac_toe_table
