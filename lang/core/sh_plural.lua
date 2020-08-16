--[[-- License Plate Plural Handler

This class is a representation of a single plural.

@copyright 2020 Joshua Piper
@release development
@author Joshua Piper
@classmod plural
--]]--
AddCSLuaFile()

local plural = {}
plural.__index = plural

--- Set the data for this plural.
-- @string id Unique ID to set for this plural, for which it can be referenced by language files.
-- @tparam vararg ... String plural forms, listed in order that the language plural rule demands.
-- @treturn plural
function plural:Set(id, ...)
	self.id = id
	self.set = {...}
	return self
end

--- Duplicate of Set.
-- @see plural.Set
-- @function plural.__call
plural.__call = plural.Set

--- Get the given plural form, given the numeric qualifier.
-- @number num
-- @treturn string
function plural:Check(num)
	return self.set[self.parent.pluralRule:Check(num)]
end

--- Register this plural in the language.
function plural:Register()
	self.parent:RegisterPlural(self)
end

return plural
