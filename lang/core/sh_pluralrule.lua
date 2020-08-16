--[[-- License Plate Plural Rule

A plural rule handler handles a single type of plural rule.
A plural rule is a language rule, which determines how to change a word, depending on a numeric qualifier.

For example, for English, the plural rule has 2 outcomes.
A form for words qualified by "1" (1 page), and another for any other number (2 pages, 0 pages, etc)

A list of plural rules can be found at https://developer.mozilla.org/en-US/docs/Mozilla/Localization/Localization_and_Plurals

@copyright 2020 Joshua Piper
@release development
@author Joshua Piper
@classmod rule
--]]--
AddCSLuaFile()

local rule = {}
rule.__index = rule

--- Add a check to the rule.
-- If a function is passed, it is ran with the number, and should return a boolean.
-- If a table is passed, the number is passed as a key, and should return a bool or nil.
-- If a number is passed, the number is checked for equality against the number being checked.
-- If a boolean is passed, it returns if true.
-- @tparam function|table|number|bool check The check to add.
-- @treturn rule
function rule:Add(check)
	table.insert(self.rules, check)
	return self
end

--- Duplicate of Add.
-- @see rule.Add
-- @function rule.__call
rule.__call = rule.Add

--- Checks the given number, and sees which form should be returned.
-- @number num Number qualifer to check against.
-- @rnumber Form to use.
function rule:Check(num)
	for i, check in ipairs(self.rules) do
		if isfunction(check) and check(num) then
			return i
		elseif istable(check) and check[num] then
			return i
		elseif isnumber(check) and check == num then
			return i
		elseif isbool(check) and check then
			return i
		end
	end
	return #self.rules + 1
end

--- Register the rule in its language.
function rule:Register()
	self.parent:RegisterPluralRule(self)
end

return rule