--[[-- License Plate Language Handler

The language handler represents a single language, with a set of translation strings and plurals.
The language also contains details, such as the used plural rules.

@copyright 2020 Joshua Piper
@release development
@author Joshua Piper
@classmod lang
--]]--
AddCSLuaFile()

local lang = {}
lang.__index = lang

--- Set a language variable.
-- @string key Unique ID
-- @string phrase Localised phrase.
function lang:__call(key, phrase)
	self.stored[key or "#"] = (phrase or "?")
end

local plural = include("sh_plural.lua")
--- Create a new plural.
-- @treturn plural
function lang:NewPlural()
	return setmetatable({parent = self}, plural)
end

--- Generate a plural based on input params
-- @see plural.Set
-- @tparam ... id and plural forms.
function lang:Plural(...)
	self:NewPlural()
		:Set(...)
		:Register()
end

--- Register a plural.
-- @tparam plural newPlural
function lang:RegisterPlural(newPlural)
	self.plurals[newPlural.id] = newPlural
end

--- Register this language in the languages table.
function lang:Register()
	self.parent:Register(self)
end

return lang
