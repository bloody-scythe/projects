serial = require('serialization')

tape = component.tape_drive
fdb_size = 204800

function read_fdb(tape,fdb_size)
    tape.seek(-tape.getPosition())
    fdb = tape.read(204800):match('(.-)\0')
    fdb = serial.unserialize(fdb)
    tape.seek(-tape.getPosition())
    return fdb
end


    

    
    
