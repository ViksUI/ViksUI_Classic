local T, C, L = unpack(ViksUI)
if C.announcements.spells ~= true then return end

----------------------------------------------------------------------------------------
--	Announce some spells
----------------------------------------------------------------------------------------
local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", function()
	local _, event, _, sourceGUID, sourceName, _, _, _, destName, _, _, spellID = CombatLogGetCurrentEventInfo()
	local _, _, difficultyID = GetInstanceInfo()
	if difficultyID == 0 or event ~= "SPELL_CAST_SUCCESS" then return end

	if sourceName then sourceName = sourceName:gsub("%-[^|]+", "") end
	if destName then destName = destName:gsub("%-[^|]+", "") end
	if C.announcements.spells_from_all == true and not (sourceGUID == UnitGUID("player") and sourceName == T.name) then
		if not sourceName then return end

		if T.AnnounceSpells[spellID] then
			if destName == nil then
				SendChatMessage(string.format(L_ANNOUNCE_FP_USE, sourceName, GetSpellLink(spellID)), T.CheckChat())
			else
				SendChatMessage(string.format(L_ANNOUNCE_FP_USE, sourceName, GetSpellLink(spellID).." -> "..destName), T.CheckChat())
			end
		end
	else
		if not (sourceGUID == UnitGUID("player") and sourceName == T.name) then return end

		if T.AnnounceSpells[spellID] then
			if destName == nil then
				SendChatMessage(string.format(L_ANNOUNCE_FP_USE, sourceName, GetSpellLink(spellID)), T.CheckChat())
			else
				SendChatMessage(GetSpellLink(spellID).." -> "..destName, T.CheckChat())
			end
		end
	end
end)