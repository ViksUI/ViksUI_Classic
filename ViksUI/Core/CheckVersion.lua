local T, C, L = unpack(ViksUI)

----------------------------------------------------------------------------------------
--	Check outdated UI version
----------------------------------------------------------------------------------------
local check = function(self, event, prefix, message, _, sender)
	if event == "CHAT_MSG_ADDON" then
		if prefix ~= "ViksUIVersion" or sender == T.name then return end
		if tonumber(message) ~= nil and tonumber(message) > tonumber(T.version) then
			if T.Classic then
				print("|cffff0000"..L_MISC_UI_OUTDATED_CLASSIC.."|r")
			else
				print("|cffff0000"..L_MISC_UI_OUTDATED.."|r")
			end
			self:UnregisterEvent("CHAT_MSG_ADDON")
		end
	else
		if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
			C_ChatInfo.SendAddonMessage("ViksUIVersion", tonumber(T.version), "INSTANCE_CHAT")
		elseif IsInRaid(LE_PARTY_CATEGORY_HOME) then
			C_ChatInfo.SendAddonMessage("ViksUIVersion", tonumber(T.version), "RAID")
		elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
			C_ChatInfo.SendAddonMessage("ViksUIVersion", tonumber(T.version), "PARTY")
		elseif IsInGuild() then
			C_ChatInfo.SendAddonMessage("ViksUIVersion", tonumber(T.version), "GUILD")
		end
	end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
frame:RegisterEvent("CHAT_MSG_ADDON")
frame:SetScript("OnEvent", check)
C_ChatInfo.RegisterAddonMessagePrefix("ViksUIVersion")

----------------------------------------------------------------------------------------
--	Whisper UI version
----------------------------------------------------------------------------------------
local whisp = CreateFrame("Frame")
whisp:RegisterEvent("CHAT_MSG_WHISPER")
whisp:RegisterEvent("CHAT_MSG_BN_WHISPER")
whisp:SetScript("OnEvent", function(_, event, text, name, ...)
	if text:lower():match("ui_version") or text:lower():match("уи_версия") then
		if event == "CHAT_MSG_WHISPER" then
			SendChatMessage("ViksUI "..T.version, "WHISPER", nil, name)
		elseif event == "CHAT_MSG_BN_WHISPER" then
			BNSendWhisper(select(11, ...), "ViksUI "..T.version)
		end
	end
end)
