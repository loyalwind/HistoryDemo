--[[--ldoc
@module	Person.lua
@author	loyalwind

Date 2020/11/30
]]

local Person = {}

function Person:ctor()

end

function Person:dtor()

end

function Person:say(msg)
    print(msg)
end

function Person:getAge()
    return 18
end

return Person
