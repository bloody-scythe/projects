serial = require('serialization')
filesystem = require('filesystem')
component = require('component')
io = require'io'
tape = component.tape_drive

fdb_size = 204800 -- size of the file descriptor block
test_fdb = {}
test_fdb['test.lua'] = { i = 204800, s = 50 }

function tape.go(pos)
    return tape.seek(pos - tape.getPosition())
end

function read_fdb()
    tape.go(0)
    size = tape.read(8):match('(.-)\0')
    fdb = tape.read(fdb_size):match('(.-)\0')
    if size == '' then size = 0 end
    if fdb == '' then --- setup basic (empty) file descriptor block
        fdb = {}
        fdb['files'] = {}
        fdb['blocks'] = {}
        table.insert(fdb['blocks'], {tape.getSize() - fdb_size, fdb_size})
    else
        fdb = serial.unserialize(fdb)
    end

    return fdb, tonumber(size)
end


function write_fdb(fdb)
    tape.go(0)
    fdb = serial.serialize(fdb)
    size = #fdb
    if size > ( fdb_size - 8 ) then 
        error('error: File descriptor block too big!!')
    end
    tape.write(tostring(size))
    tape.write(string.rep('\0', 8 - #tostring(size)))
    tape.write(tostring(fdb))
    tape.write(string.rep('\0', fdb_size - tape.getPosition()))
end

function put_file(file)
    handle = io.open(file, rb)
end

-------------------------------------------

fdb, fdb_size = read_fdb()

print("The file descriiptor block is:\n" .. serial.serialize(fdb) .. "\n")

args = { ... }

if args[1] == 'put' then
        -- file = shell.resolve(arg[2])
        -- if filesystem.exists(file) then
        files = {table.unpack( args, 2 )}
        for i,file in ipairs(files) do
            file = shell.resolve(file)
            if filesystem.exists(file) then
                put_file(file)
            else
                print('warning: file \"' .. file .. '\" doesn\'t exist' )
            end
        end
end
