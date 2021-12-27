serial = require('serialization')
component = require('component')
tape = component.tape_drive

fdb_size = 204800 -- size of the file descriptor block
test_fdb = {}
test_fdb['test.lua'] = { i = 204800, s = 50 }

function tape.start()
    return tape.seek(-tape.getPosition())
end

function read_fdb()
    tape.start()
    size = tape.read(8):match('(.-)\0')
    fdb = tape.read(fdb_size):match('(.-)\0')
    if size == '' then size = 0 end
    if fdb == '' then
        fdb = {}
    else
        fdb = serial.unserialize(fdb)
    end

    return fdb, tonumber(size)
end

function write_fdb(fdb, previous_size)
    tape.start()
    fdb = serial.serialize(fdb)
    size = #fdb
    if size > fdb_size then 
        error('error: File descriptor block too big!!')
    end
    tape.write(tostring(size))
    tape.seek(9 - tape.getPosition())
    tape.write(tostring(fdb))
    a = test
end
