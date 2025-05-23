local T, C, L = unpack(ViksUI)

if IsAddOnLoaded("yClassColor") then return end

----------------------------------------------------------------------------------------
--	Class color guild/friends/etc list(yClassColor by Yleaf)
----------------------------------------------------------------------------------------
local GUILD_INDEX_MAX = 12
local SMOOTH = {1, 0, 0, 1, 1, 0, 0, 1, 0}
local BC = {}
for k, v in pairs(LOCALIZED_CLASS_NAMES_MALE) do
	BC[v] = k
end
for k, v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do
	BC[v] = k
end
local RAID_CLASS_COLORS = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS
local WHITE_HEX = "|cffffffff"

local function Hex(r, g, b)
	if type(r) == "table" then
		if (r.r) then r, g, b = r.r, r.g, r.b else r, g, b = unpack(r) end
	end

	if not r or not g or not b then
		r, g, b = 1, 1, 1
	end

	return format("|cff%02x%02x%02x", r * 255, g * 255, b * 255)
end

local function ColorGradient(perc, ...)
	if perc >= 1 then
		local r, g, b = select(select("#", ...) - 2, ...)
		return r, g, b
	elseif perc <= 0 then
		local r, g, b = ...
		return r, g, b
	end

	local num = select("#", ...) / 3

	local segment, relperc = math.modf(perc * (num - 1))
	local r1, g1, b1, r2, g2, b2 = select((segment * 3) + 1, ...)

	return r1 + (r2 - r1) * relperc, g1 + (g2 - g1) * relperc, b1 + (b2 - b1) * relperc
end

local guildRankColor = setmetatable({}, {
	__index = function(t, i)
		if i then
			local c = Hex(ColorGradient(i / GUILD_INDEX_MAX, unpack(SMOOTH)))
			if c then
				t[i] = c
				return c
			else
				t[i] = t[0]
			end
		end
	end
})
guildRankColor[0] = WHITE_HEX

local diffColor = setmetatable({}, {
	__index = function(t, i)
		local c = i and GetQuestDifficultyColor(i)
		t[i] = c and Hex(c) or t[0]
		return t[i]
	end
})
diffColor[0] = WHITE_HEX

local classColor = setmetatable({}, {
	__index = function(t, i)
		local c = i and RAID_CLASS_COLORS[BC[i] or i]
		if c then
			t[i] = Hex(c)
			return t[i]
		else
			return WHITE_HEX
		end
	end
})

local WHITE = {1, 1, 1}
local classColorRaw = setmetatable({}, {
	__index = function(t, i)
		local c = i and RAID_CLASS_COLORS[BC[i] or i]
		if not c then return WHITE end
		t[i] = c
		return c
	end
})

if CUSTOM_CLASS_COLORS then
	CUSTOM_CLASS_COLORS:RegisterCallback(function()
		wipe(classColorRaw)
		wipe(classColor)
	end)
end

-- WhoList
local function whoFrame()
	local offset = FauxScrollFrame_GetOffset(WhoListScrollFrame)
	local numWhos = C_FriendList.GetNumWhoResults()

	local playerZone = GetRealZoneText()
	local playerGuild = GetGuildInfo("player")
	local playerRace = UnitRace("player")

	for i = 1, WHOS_TO_DISPLAY do
		local index = offset + i
		if index <= numWhos then
			local nameText = _G["WhoFrameButton"..i.."Name"]
			local levelText = _G["WhoFrameButton"..i.."Level"]
			local variableText = _G["WhoFrameButton"..i.."Variable"]

			local info = C_FriendList.GetWhoInfo(index)
			if info then
				local guild = info.fullGuildName
				local level = info.level
				local race = info.raceStr
				local zone = info.area
				local classFileName = info.filename

				if zone == playerZone then
					zone = "|cff00ff00"..zone
				end
				if guild == playerGuild then
					guild = "|cff00ff00"..guild
				end
				if race == playerRace then
					race = "|cff00ff00"..race
				end

				local c = classColorRaw[classFileName]
				nameText:SetTextColor(c.r, c.g, c.b)
				levelText:SetText(diffColor[level]..level)
			end
		end
	end
end

hooksecurefunc("WhoList_Update", whoFrame)

-- WorldStateScoreList
hooksecurefunc("WorldStateScoreFrame_Update", function()
	local offset = FauxScrollFrame_GetOffset(WorldStateScoreScrollFrame)

	for i = 1, GetNumBattlefieldScores() do
		local index = offset + i
		local name, _, _, _, _, faction, _, _, _, class = GetBattlefieldScore(index)
		if name then
			local n, r = strsplit("-", name, 2)
			n = classColor[class]..n.."|r"

			if name == myName then
				n = ">>> "..n.." <<<"
			end

			if r then
				local color
				if faction == 1 then
					color = "|cff00adf0"
				else
					color = "|cffff1919"
				end
				r = color..r.."|r"
				n = n.."|cffffffff - |r"..r
			end

			local button = _G["WorldStateScoreButton"..i]
			if button then
				button.name.text:SetText(n)
			end
		end
	end
end)

-- CommunitiesFrame
-- CommunitiesFrame
local function RefreshList(self)
	local playerArea = GetRealZoneText()
	local memberInfo = self:GetMemberInfo()
	if memberInfo then
		if memberInfo.presence == Enum.ClubMemberPresence.Offline then return end
		if memberInfo.zone and memberInfo.zone == playerArea then
			self.Zone:SetText("|cff4cff4c"..memberInfo.zone)
		end

		if memberInfo.level then
			self.Level:SetText(diffColor[memberInfo.level]..memberInfo.level)
		end

		if memberInfo.guildRankOrder and memberInfo.guildRank then
			self.Rank:SetText(guildRankColor[memberInfo.guildRankOrder]..memberInfo.guildRank)
		end
	end
end

-- local loaded = false
-- hooksecurefunc("Communities_LoadUI", function()
	-- if loaded then
		-- return
	-- else
		-- loaded = true
		if CommunitiesMemberListEntryMixin then
			hooksecurefunc(CommunitiesMemberListEntryMixin, "RefreshExpandedColumns", RefreshList)
		end
	-- end
-- end)

-- FriendsList
local FRIENDS_LEVEL_TEMPLATE = FRIENDS_LEVEL_TEMPLATE:gsub("%%d", "%%s")
FRIENDS_LEVEL_TEMPLATE = FRIENDS_LEVEL_TEMPLATE:gsub("%$d", "%$s")
local function friendsFrame()
	local scrollFrame = FriendsFrameFriendsScrollFrame
	local buttons = scrollFrame.buttons

	local playerArea = GetRealZoneText()

	for i = 1, #buttons do
		local nameText, infoText
		local button = buttons[i]
		if button:IsShown() then
			if button.buttonType == FRIENDS_BUTTON_TYPE_WOW then
				local info = C_FriendList.GetFriendInfoByIndex(button.id)
				if info.connected then
					nameText = classColor[info.className]..info.name.."|r, "..format(FRIENDS_LEVEL_TEMPLATE, diffColor[info.level]..info.level.."|r", info.className)
					if info.area == playerArea then
						infoText = format("|cff00ff00%s|r", info.area)
					end
				end
			elseif button.buttonType == FRIENDS_BUTTON_TYPE_BNET then
				local accountInfo = C_BattleNet.GetFriendAccountInfo(button.id)
				if accountInfo.gameAccountInfo.isOnline and accountInfo.gameAccountInfo.clientProgram == BNET_CLIENT_WOW then
					local accountName = accountInfo.accountName
					local characterName = accountInfo.gameAccountInfo.characterName
					local class = accountInfo.gameAccountInfo.className
					local areaName = accountInfo.gameAccountInfo.areaName
					if accountName and characterName and class then
						nameText = format(BATTLENET_NAME_FORMAT, accountName, "").." "..FRIENDS_WOW_NAME_COLOR_CODE.."("..classColor[class]..classColor[class]..characterName..FRIENDS_WOW_NAME_COLOR_CODE..")"
						if areaName == playerArea then
							infoText = format("|cff00ff00%s|r", areaName)
						end
					end
				end
			end
		end

		if nameText then
			button.name:SetText(nameText)
		end
		if infoText then
			button.info:SetText(infoText)
		end
	end
end
hooksecurefunc(FriendsFrameFriendsScrollFrame, "update", friendsFrame)
hooksecurefunc("FriendsFrame_UpdateFriends", friendsFrame)