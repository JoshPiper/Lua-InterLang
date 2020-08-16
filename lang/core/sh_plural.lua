--[[-- License Plate Plural Handler
@copyright 2020 Joshua Piper
@release development
@author Joshua Piper
@classmod plural
--]]--
AddCSLuaFile()

local plural = {}
plural.__index = plural

function plural:Set(id, ...)
	self.id = id
	self.set = {...}
	return self
end

function plural:__call(...)
	return self:Set(...)
end

function plural:Check(num)
	return self.set[self.parent.pluralRule:Check(num)]
end

function plural:Register()
	self.parent:RegisterPlural(self)
end

return plural
