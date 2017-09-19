#!/usr/bin/ruby

require 'pg'

begin

con = PG.connect :dbname => 'doctors_office'



# rs = con.exec "SELECT * FROM doctors_office WHERE Id=0"
#
# puts "There are %d columns " %rs.nfields
#
# rescue PG::Error => e
#
#   e.message
#
# ensure
#   rs.clear if rs
#   con.close if con
#
# end
