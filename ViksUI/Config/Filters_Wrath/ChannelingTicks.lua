local T, C, L = unpack(ViksUI)
if C.unitframe.enable ~= true or C.unitframe.castbar_ticks ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Tranquility -> http://www.wowhead.com/spell=740
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
local function SpellName(id)
	local name = GetSpellInfo(id)
	if name then
		return name
	else
		print("|cffff0000ViksUI: spell ID ["..tostring(id).."] no longer exists!|r")
		return "Empty"
	end
end

T.CastBarTicks = {
	-- Death Knight
	[SpellName(42650)] = 8,		-- Army of the Dead
	-- Druid
	[SpellName(740)] = 4,		-- Tranquility
	[SpellName(16914)] = 10,	-- Hurricane
	-- Hunter
	[SpellName(1510)] = 6,		-- Volley
	-- Mage
	-- [SpellName(5143)] = 5,		-- Arcane Missiles (accurate for r13 - lower ranks have less ticks)
	[SpellName(12051)] = 4,		-- Evocation
	[SpellName(10)] = 8,		-- Blizzard
	-- Priest
	[SpellName(64843)] = 4,		-- Divine Hymn
	[SpellName(64901)] = 4,		-- Hymn of Hope (accurate without glyph - with glyph it is 5 ticks)
	[SpellName(15407)] = 3,		-- Mind Flay
	[SpellName(48045)] = 5,		-- Mind Sear
	[SpellName(47540)] = 2,		-- Penance
	-- Warlock
	[SpellName(1120)] = 5,		-- Drain Soul
	[SpellName(755)] = 10,		-- Health Funnel
	[SpellName(689)] = 5,		-- Drain Life
	[SpellName(5138)] = 5,		-- Drain Mana
	[SpellName(1949)] = 15,		-- Hellfire
	[SpellName(5740)] = 4,		-- Rain of Fire
}
