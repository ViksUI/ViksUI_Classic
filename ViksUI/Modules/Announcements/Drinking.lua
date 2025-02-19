local T, C, L = unpack(ViksUI)
if C.announcements.drinking ~= true then return end

----------------------------------------------------------------------------------------
--	Announce enemy drinking in arena(by Duffed)
----------------------------------------------------------------------------------------
local drinkSpell
if T.Classic then
	if T.Vanilla then
		drinkSpell = {
			[GetSpellInfo(18071)] = true,	-- Enriched Manna Biscuit
			[GetSpellInfo(18140)] = true,	-- Blessed Sunfruit Juice
			[GetSpellInfo(23541)] = true,	-- Warsong Gulch Iron Ration
			[GetSpellInfo(23542)] = true,	-- Warsong Gulch Field Ration
			[GetSpellInfo(23692)] = true,	-- Alterac Manna Biscuit
			[GetSpellInfo(24409)] = true,	-- Arathi Basin Field Ration
			[GetSpellInfo(24410)] = true,	-- Arathi Basin Iron Ration
			[GetSpellInfo(24384)] = true,	-- Essence Mango
			[GetSpellInfo(25990)] = true,	-- Graccu's Mince Meat Fruitcake
			[GetSpellInfo(27089)] = true,	-- Drink
			[GetSpellInfo(29055)] = true,	-- Refreshing Red Apple
		}
	elseif T.TBC then
		drinkSpell = {
			[GetSpellInfo(18071)] = true,	-- Enriched Manna Biscuit
			[GetSpellInfo(18140)] = true,	-- Blessed Sunfruit Juice
			[GetSpellInfo(23541)] = true,	-- Warsong Gulch Iron Ration
			[GetSpellInfo(23542)] = true,	-- Warsong Gulch Field Ration
			[GetSpellInfo(23692)] = true,	-- Alterac Manna Biscuit
			[GetSpellInfo(24409)] = true,	-- Arathi Basin Field Ration
			[GetSpellInfo(24410)] = true,	-- Arathi Basin Iron Ration
			[GetSpellInfo(24384)] = true,	-- Essence Mango
			[GetSpellInfo(25990)] = true,	-- Graccu's Mince Meat Fruitcake
			[GetSpellInfo(27089)] = true,	-- Drink
			[GetSpellInfo(29055)] = true,	-- Refreshing Red Apple
			[GetSpellInfo(33772)] = true,	-- Underspore Pod
			[GetSpellInfo(41031)] = true,	-- Enriched Terocone Juice
			[GetSpellInfo(42309)] = true,	-- Brain Food
			[GetSpellInfo(44115)] = true,	-- Brewfest Drink
			[GetSpellInfo(44166)] = true,	-- Refreshment
			[GetSpellInfo(45020)] = true,	-- Holiday Drink
			[GetSpellInfo(49472)] = true,	-- Drink Coffee
		}
	elseif T.Wrath then
		drinkSpell = {
			[GetSpellInfo(18071)] = true,	-- Enriched Manna Biscuit
			[GetSpellInfo(18140)] = true,	-- Blessed Sunfruit Juice
			[GetSpellInfo(23541)] = true,	-- Warsong Gulch Iron Ration
			[GetSpellInfo(23542)] = true,	-- Warsong Gulch Field Ration
			[GetSpellInfo(23692)] = true,	-- Alterac Manna Biscuit
			[GetSpellInfo(24409)] = true,	-- Arathi Basin Field Ration
			[GetSpellInfo(24410)] = true,	-- Arathi Basin Iron Ration
			[GetSpellInfo(24384)] = true,	-- Essence Mango
			[GetSpellInfo(25990)] = true,	-- Graccu's Mince Meat Fruitcake
			[GetSpellInfo(27089)] = true,	-- Drink
			[GetSpellInfo(29055)] = true,	-- Refreshing Red Apple
			[GetSpellInfo(33772)] = true,	-- Underspore Pod
			[GetSpellInfo(41031)] = true,	-- Enriched Terocone Juice
			[GetSpellInfo(42309)] = true,	-- Brain Food
			[GetSpellInfo(44115)] = true,	-- Brewfest Drink
			[GetSpellInfo(44166)] = true,	-- Refreshment
			[GetSpellInfo(45020)] = true,	-- Holiday Drink
			[GetSpellInfo(49472)] = true,	-- Drink Coffee
			[GetSpellInfo(57337)] = true,	-- Great Feast
			[GetSpellInfo(57397)] = true,	-- Fish Feast
			[GetSpellInfo(58466)] = true,	-- Gigantic Feast
			[GetSpellInfo(58475)] = true,	-- Small Feast
			[GetSpellInfo(65422)] = true,	-- Food
			[GetSpellInfo(66477)] = true,	-- Bountiful Feast
		}
	elseif T.Cata then
		drinkSpell = {
			[GetSpellInfo(18071)] = true,	-- Enriched Manna Biscuit
			[GetSpellInfo(18140)] = true,	-- Blessed Sunfruit Juice
			[GetSpellInfo(23541)] = true,	-- Warsong Gulch Iron Ration
			[GetSpellInfo(23542)] = true,	-- Warsong Gulch Field Ration
			[GetSpellInfo(23692)] = true,	-- Alterac Manna Biscuit
			[GetSpellInfo(24409)] = true,	-- Arathi Basin Field Ration
			[GetSpellInfo(24410)] = true,	-- Arathi Basin Iron Ration
			[GetSpellInfo(24384)] = true,	-- Essence Mango
			[GetSpellInfo(25990)] = true,	-- Graccu's Mince Meat Fruitcake
			[GetSpellInfo(27089)] = true,	-- Drink
			[GetSpellInfo(29055)] = true,	-- Refreshing Red Apple
			[GetSpellInfo(33772)] = true,	-- Underspore Pod
			[GetSpellInfo(41031)] = true,	-- Enriched Terocone Juice
			[GetSpellInfo(42309)] = true,	-- Brain Food
			[GetSpellInfo(44115)] = true,	-- Brewfest Drink
			[GetSpellInfo(44166)] = true,	-- Refreshment
			[GetSpellInfo(45020)] = true,	-- Holiday Drink
			[GetSpellInfo(49472)] = true,	-- Drink Coffee
			[GetSpellInfo(57337)] = true,	-- Great Feast
			[GetSpellInfo(57397)] = true,	-- Fish Feast
			[GetSpellInfo(58466)] = true,	-- Gigantic Feast
			[GetSpellInfo(58475)] = true,	-- Small Feast
			[GetSpellInfo(65422)] = true,	-- Food
			[GetSpellInfo(66477)] = true,	-- Bountiful Feast
			[GetSpellInfo(87604)] = true,	-- Food
			[GetSpellInfo(87648)] = true,	-- Starfire Espresso
			[GetSpellInfo(87763)] = true,	-- Broiled Dragon Feast
			[GetSpellInfo(87806)] = true,	-- Seafood Magnifique Feast
			[GetSpellInfo(87916)] = true,	-- Goblin Barbecue Feast
			[GetSpellInfo(100367)] = true,	-- Bountiful Drink
		}
	end
else
	drinkSpell = {
		[GetSpellInfo(118358)] = true,	-- Drink
		[GetSpellInfo(167152)] = true,	-- Refreshment
		[GetSpellInfo(167268)] = true,	-- Ba'ruun's Bountiful Bloom
	}
end


local frame = CreateFrame("Frame")
frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
frame:SetScript("OnEvent", function(_, event, ...)
	if not (event == "UNIT_SPELLCAST_SUCCEEDED" and GetZonePVPInfo() == "arena") then return end

	local unit, _, spellID = ...
	if UnitIsEnemy("player", unit) and drinkSpell[GetSpellInfo(spellID)] then
		SendChatMessage(UnitClass(unit).." "..UnitName(unit)..L_MISC_DRINKING, T.CheckChat(true))
	end
end)
