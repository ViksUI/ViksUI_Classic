local T, C, L = unpack(ViksUI)
if C.minimap.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Minimap border
----------------------------------------------------------------------------------------
local MinimapAnchor = CreateFrame("Frame", "MinimapAnchor", UIParent)

if C.panels.NoPanels == true then
MinimapAnchor:CreatePanel("Transparent", C.minimap.size, C.minimap.size, unpack(C.position.minimapline))
else
MinimapAnchor:CreatePanel("Transparent", C.minimap.size, C.minimap.size, unpack(C.position.minimap))
end

--Note: Use "Invisible" to hide
----------------------------------------------------------------------------------------
--	Shape, location and scale
----------------------------------------------------------------------------------------
-- Disable Minimap Cluster
MinimapCluster:EnableMouse(false)
if T.Classic then
	MinimapCluster:SetPoint("TOPRIGHT", 0, 100) -- Prevent scaling for right panels
	MinimapCluster:Kill()
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event)
	self:UnregisterEvent(event)
	-- Parent Minimap into our frame
	Minimap:SetParent(MinimapAnchor)
	Minimap:ClearAllPoints()
	Minimap:SetPoint("TOPLEFT", MinimapAnchor, "TOPLEFT", 2, -2)
	Minimap:SetPoint("BOTTOMRIGHT", MinimapAnchor, "BOTTOMRIGHT", -2, 2)
	Minimap:SetSize(MinimapAnchor:GetWidth(), MinimapAnchor:GetWidth())

	MinimapBackdrop:ClearAllPoints()
	MinimapBackdrop:SetPoint("TOPLEFT", MinimapAnchor, "TOPLEFT", 2, -2)
	MinimapBackdrop:SetPoint("BOTTOMRIGHT", MinimapAnchor, "BOTTOMRIGHT", -2, 2)
	MinimapBackdrop:SetSize(MinimapAnchor:GetWidth(), MinimapAnchor:GetWidth())

	-- Instance Difficulty icon
	if T.Wrath or T.Cata then
		MiniMapInstanceDifficulty:SetParent(Minimap)
		MiniMapInstanceDifficulty:ClearAllPoints()
		MiniMapInstanceDifficulty:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 3, 2)
		MiniMapInstanceDifficulty:SetScale(0.75)
	elseif T.Mainline then
		MinimapCluster.InstanceDifficulty:SetParent(Minimap)
		MinimapCluster.InstanceDifficulty:ClearAllPoints()
		MinimapCluster.InstanceDifficulty:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 1, 3)
		MinimapCluster.InstanceDifficulty.Instance.Border:Hide()
		MinimapCluster.InstanceDifficulty.Instance.Background:SetSize(28, 28)
		MinimapCluster.InstanceDifficulty.Instance.Background:SetVertexColor(0.6, 0.3, 0)
	end

	-- Guild Instance Difficulty icon
	if T.Mainline then
		MinimapCluster.InstanceDifficulty.Guild.Border:Hide()
		MinimapCluster.InstanceDifficulty.Guild.Background:SetSize(28, 28)
		MinimapCluster.InstanceDifficulty.Guild.Background:ClearAllPoints()
		MinimapCluster.InstanceDifficulty.Guild.Background:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", -1, 0)
	end

	-- Challenge Mode icon
	if T.Mainline then
		MinimapCluster.InstanceDifficulty.ChallengeMode.Border:Hide()
		MinimapCluster.InstanceDifficulty.ChallengeMode.Background:SetSize(28, 28)
		MinimapCluster.InstanceDifficulty.ChallengeMode.Background:SetVertexColor(0.8, 0.8, 0)
		MinimapCluster.InstanceDifficulty.ChallengeMode.Background:ClearAllPoints()
		MinimapCluster.InstanceDifficulty.ChallengeMode.Background:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", -1, 0)
	end

	-- Move QueueStatus icon
	if T.Mainline then
		QueueStatusFrame:SetClampedToScreen(true)
		QueueStatusFrame:SetFrameStrata("TOOLTIP")
		QueueStatusButton:ClearAllPoints()
		QueueStatusButton:SetPoint("TOP", Minimap, "TOP", 1, -1)
		QueueStatusButton:SetParent(Minimap)
		QueueStatusButton:SetScale(0.5)

		hooksecurefunc(QueueStatusButton, "SetPoint", function(self, _, anchor)
			if anchor ~= Minimap then
				self:ClearAllPoints()
				self:SetPoint("TOP", Minimap, "TOP", 1, -1)
			end
		end)

		hooksecurefunc(QueueStatusButton, "SetScale", function(self, scale)
			if scale ~= 0.5 then
				self:SetScale(0.5)
			end
		end)
	end

	-- Invites icon
	if T.Wrath or T.Cata then
		GameTimeCalendarInvitesTexture:ClearAllPoints()
		GameTimeCalendarInvitesTexture:SetParent(Minimap)
		GameTimeCalendarInvitesTexture:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 0, 0)
	elseif T.Mainline then
		local InviteTexture = GameTimeCalendarInvitesTexture
		InviteTexture:ClearAllPoints()
		InviteTexture:SetParent(Minimap)
		InviteTexture:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", -1, -4)
		GameTimeFrame:Hide()

		-- Create button to show invite tooltip and allow open calendar
		local button = CreateFrame("Button", nil, Minimap)
		button:SetAllPoints(InviteTexture)
		if not GameTimeCalendarInvitesTexture:IsShown() then
			button:Hide()
		end

		button:SetScript("OnEnter", function()
			if InCombatLockdown() then return end
			if InviteTexture:IsShown() then
				GameTooltip:SetOwner(button, "ANCHOR_LEFT")
				GameTooltip:AddLine(GAMETIME_TOOLTIP_CALENDAR_INVITES)
				GameTooltip:AddLine(" ")
				GameTooltip:AddLine(GAMETIME_TOOLTIP_TOGGLE_CALENDAR)
				GameTooltip:Show()
			end
		end)

		button:SetScript("OnLeave", function()
			GameTooltip:Hide()
		end)

		button:SetScript("OnClick", function()
			if InCombatLockdown() then return end
			if InviteTexture:IsShown() then
				ToggleCalendar()
			end
		end)

		hooksecurefunc(InviteTexture, "Show", function()
			button:Show()
		end)

		hooksecurefunc(InviteTexture, "Hide", function()
			button:Hide()
		end)
	end

	-- Hide Game Time
	if T.Vanilla or T.TBC then
		GameTimeFrame:Hide()
	end

	-- Move Mail icon
	if T.Classic then
		MiniMapMailFrame:ClearAllPoints()
		MiniMapMailFrame:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 8, -10)
		MiniMapMailBorder:Hide()
		MiniMapMailIcon:SetTexture("Interface\\AddOns\\ViksUI\\Media\\Textures\\Mail.tga")
		MiniMapMailIcon:SetSize(16, 16)
	else
		local MailFrame = MinimapCluster.IndicatorFrame.MailFrame
		hooksecurefunc(MailFrame, "SetPoint", function(self, _, anchor)
			if anchor ~= Minimap then
				self:ClearAllPoints()
				self:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 4, -1)
			end
		end)
		MiniMapMailIcon:SetTexture("Interface\\AddOns\\ViksUI\\Media\\Textures\\Mail.tga")
		MiniMapMailIcon:SetSize(16, 16)
	end

	-- Move crafting order icon
	if T.Mainline then
		local Crafting = MinimapCluster.IndicatorFrame.CraftingOrderFrame
		hooksecurefunc(Crafting, "SetPoint", function(self, _, anchor)
			if anchor ~= Minimap then
				self:ClearAllPoints()
				self:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, 4)
			end
		end)
	end

	-- Move LFG Eye icon
	if MiniMapLFGFrame then
		MiniMapLFGFrame:SetClampedToScreen(true)
		MiniMapLFGFrame:SetFrameStrata("TOOLTIP")
		MiniMapLFGFrame:ClearAllPoints()
		MiniMapLFGFrame:SetPoint("TOP", Minimap, "TOP", 1, 6)
		MiniMapLFGFrame:SetScale(0.8)
		MiniMapLFGFrame:SetHighlightTexture(0)
		if T.Wrath or T.Cata then
			MiniMapLFGFrameBorder:Hide()
		else
			MiniMapLFGBorder:Hide()
		end
	end
	if LFGMinimapFrame then
		LFGMinimapFrame:SetClampedToScreen(true)
		LFGMinimapFrame:SetFrameStrata("TOOLTIP")
		LFGMinimapFrame:ClearAllPoints()
		LFGMinimapFrame:SetPoint("TOP", Minimap, "TOP", 1, 6)
		LFGMinimapFrame:SetScale(0.8)
		LFGMinimapFrame:SetHighlightTexture(0)
		if LFGMinimapFrameBorder then
			LFGMinimapFrameBorder:Hide()
		end
	end
end)

-- Adjusting for patch 9.0.1 Minimap.xml
Minimap:SetFrameStrata("LOW")
Minimap:SetFrameLevel(2)

-- Hide Border
if T.Classic then
	MinimapBorder:Hide()
	MinimapBorderTop:Hide()
else
	MinimapCompassTexture:Hide()
	MinimapCluster.BorderTop:StripTextures()
end

-- Hide Zoom Buttons
MinimapZoomIn:Hide()
MinimapZoomOut:Hide()

-- Hide Blob Ring
if T.Mainline then
	Minimap:SetArchBlobRingScalar(0)
	Minimap:SetQuestBlobRingScalar(0)
end

-- Hide North texture at top
if T.Classic then
	MinimapNorthTag:SetTexture(0)
end

-- Hide Zone Frame
if T.Classic then
	MinimapZoneTextButton:Hide()
else
	MinimapCluster.ZoneTextButton:Hide()
end

-- Hide world map button
if T.Classic and MiniMapWorldMapButton then
	MiniMapWorldMapButton:Hide()
	MiniMapWorldMapButton.Show = T.dummy
end

if T.Mainline then
	AddonCompartmentFrame:Kill()
end

-- Garrison icon
if T.Mainline then
	if C.minimap.garrison_icon == true then
		ExpansionLandingPageMinimapButton:SetScale(0.6)
		ExpansionLandingPageMinimapButton:ClearAllPoints()
		ExpansionLandingPageMinimapButton:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -3, 1)
		hooksecurefunc(ExpansionLandingPageMinimapButton, "UpdateIconForGarrison", function()
			ExpansionLandingPageMinimapButton:ClearAllPoints()
			ExpansionLandingPageMinimapButton:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -3, 1)
		end)
	else
		ExpansionLandingPageMinimapButton:SetScale(0.0001)
		ExpansionLandingPageMinimapButton:SetAlpha(0)
	end
end

-- Default LFG icon
if T.Classic then
	LFG_EYE_TEXTURES.raid = LFG_EYE_TEXTURES.default
	LFG_EYE_TEXTURES.unknown = LFG_EYE_TEXTURES.default
end

-- Feedback icon
if FeedbackUIButton then
	FeedbackUIButton:ClearAllPoints()
	FeedbackUIButton:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, 0)
	FeedbackUIButton:SetScale(0.8)
end

-- Streaming icon
if StreamingIcon then
	StreamingIcon:ClearAllPoints()
	StreamingIcon:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, -10)
	StreamingIcon:SetScale(0.8)
	StreamingIcon:SetFrameStrata("BACKGROUND")
end

-- GhostFrame
if T.Cata or T.Mainline then
	GhostFrame:StripTextures()
	GhostFrame:SetTemplate("Overlay")
	GhostFrame:StyleButton()
	GhostFrame:ClearAllPoints()
	GhostFrame:SetPoint(unpack(C.position.ghost))
	GhostFrameContentsFrameIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	GhostFrameContentsFrameIcon:SetSize(32, 32)
	GhostFrameContentsFrame:SetFrameLevel(GhostFrameContentsFrame:GetFrameLevel() + 2)
	GhostFrameContentsFrame:CreateBackdrop("Overlay")
	GhostFrameContentsFrame.backdrop:SetPoint("TOPLEFT", GhostFrameContentsFrameIcon, -2, 2)
	GhostFrameContentsFrame.backdrop:SetPoint("BOTTOMRIGHT", GhostFrameContentsFrameIcon, 2, -2)
end

-- Enable mouse scrolling
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(_, d)
	if T.Classic then
		if d > 0 then
			_G.MinimapZoomIn:Click()
		elseif d < 0 then
			_G.MinimapZoomOut:Click()
		end
	else
		if d > 0 then
			_G.Minimap.ZoomIn:Click()
		elseif d < 0 then
			_G.Minimap.ZoomOut:Click()
		end
	end
end)

-- Hide Game Time
MinimapAnchor:RegisterEvent("PLAYER_LOGIN")
MinimapAnchor:RegisterEvent("ADDON_LOADED")
MinimapAnchor:SetScript("OnEvent", function(_, _, addon)
	if addon == "Blizzard_TimeManager" then
		TimeManagerClockButton:Kill()
	elseif addon == "Blizzard_HybridMinimap" then
		HybridMinimap:SetFrameStrata("BACKGROUND")
		HybridMinimap:SetFrameLevel(100)
		HybridMinimap.MapCanvas:SetUseMaskTexture(false)
		HybridMinimap.CircleMask:SetTexture("Interface\\BUTTONS\\WHITE8X8")
		HybridMinimap.MapCanvas:SetUseMaskTexture(true)
	end
end)

----------------------------------------------------------------------------------------
--	Right click menu
----------------------------------------------------------------------------------------
local menuFrame = CreateFrame("Frame", "MinimapRightClickMenu", UIParent, "UIDropDownMenuTemplate")
local guildText = IsInGuild() and ACHIEVEMENTS_GUILD_TAB or LOOKINGFORGUILD
local journalText = T.client == "ruRU" and ENCOUNTER_JOURNAL or ADVENTURE_JOURNAL
local micromenu = {
	{text = CHARACTER_BUTTON, notCheckable = 1, func = function()
		ToggleCharacter("PaperDollFrame")
	end},
	{text = SPELLBOOK_ABILITIES_BUTTON, notCheckable = 1, func = function()
		if InCombatLockdown() then
			print("|cffffff00"..ERR_NOT_IN_COMBAT.."|r") return
		end
		ToggleFrame(SpellBookFrame)
	end},
	{text = TALENTS_BUTTON, notCheckable = 1, func = function()
		if not PlayerTalentFrame then
			LoadAddOn("Blizzard_TalentUI")
		end
		if T.level >= 10 then
			ToggleTalentFrame()
		else
			if C.general.error_filter ~= "WHITELIST" then
				UIErrorsFrame:AddMessage(format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, 10), 1, 0.1, 0.1)
			else
				print("|cffffff00"..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, 10).."|r")
			end
		end
	end},
	{text = ACHIEVEMENT_BUTTON, notCheckable = 1, func = function()
		ToggleAchievementFrame()
	end},
	{text = QUESTLOG_BUTTON, notCheckable = 1, func = function()
		ToggleQuestLog()
	end},
	{text = guildText, notCheckable = 1, func = function()
		ToggleGuildFrame()
	end},
	{text = SOCIAL_BUTTON, notCheckable = 1, func = function()
		ToggleFriendsFrame(1)
	end},
	{text = CHAT_CHANNELS, notCheckable = 1, func = function()
		ToggleChannelFrame()
	end},
	{text = PLAYER_V_PLAYER, notCheckable = 1, func = function()
		if T.level >= 10 then
			TogglePVPUI()
		else
			if C.general.error_filter ~= "WHITELIST" then
				UIErrorsFrame:AddMessage(format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, 10), 1, 0.1, 0.1)
			else
				print("|cffffff00"..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, 10).."|r")
			end
		end
	end},
	{text = GROUP_FINDER, notCheckable = 1, func = function()
		if T.level >= 10 then
			PVEFrame_ToggleFrame("GroupFinderFrame", nil)
		else
			if C.general.error_filter ~= "WHITELIST" then
				UIErrorsFrame:AddMessage(format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, 10), 1, 0.1, 0.1)
			else
				print("|cffffff00"..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, 10).."|r")
			end
		end
	end},
	{text = journalText, notCheckable = 1, func = function()
		if C_AdventureJournal.CanBeShown() then
			ToggleEncounterJournal()
		else
			if C.general.error_filter ~= "WHITELIST" then
				UIErrorsFrame:AddMessage(FEATURE_NOT_YET_AVAILABLE, 1, 0.1, 0.1)
			else
				print("|cffffff00"..FEATURE_NOT_YET_AVAILABLE.."|r")
			end
		end
	end},
	{text = COLLECTIONS, notCheckable = 1, func = function()
		if InCombatLockdown() then
			print("|cffffff00"..ERR_NOT_IN_COMBAT.."|r") return
		end
		ToggleCollectionsJournal()
	end},
	{text = HELP_BUTTON, notCheckable = 1, func = function()
		ToggleHelpFrame()
	end},
	{text = L_MINIMAP_CALENDAR, notCheckable = 1, func = function()
		ToggleCalendar()
	end},
	{text = BATTLEFIELD_MINIMAP, notCheckable = 1, func = function()
		ToggleBattlefieldMap()
	end},
	{text = LOOT_ROLLS, notCheckable = 1, func = function()
		ToggleFrame(LootHistoryFrame)
	end},
}
if T.Classic then
	if T.Vanilla or T.TBC then
		tremove(micromenu, 14)
	end
	tremove(micromenu, 12)
	tremove(micromenu, 11)
	tremove(micromenu, 10)
	tremove(micromenu, 9)
	tremove(micromenu, 6)
	if T.Vanilla or T.TBC then
		tremove(micromenu, 4)
	end
end

if T.Mainline and not IsTrialAccount() and not C_StorePublic.IsDisabledByParentalControls() then
	tinsert(micromenu, {text = BLIZZARD_STORE, notCheckable = 1, func = function() StoreMicroButton:Click() end})
end

if T.Mainline and T.level == MAX_PLAYER_LEVEL then
	tinsert(micromenu, {text = RATED_PVP_WEEKLY_VAULT, notCheckable = 1, func = function()
		if not WeeklyRewardsFrame then
			WeeklyRewards_LoadUI()
		end
		ToggleFrame(WeeklyRewardsFrame)
	end})
end

if T.Mainline then
	local frame = CreateFrame("Frame")
	frame:RegisterEvent("GARRISON_SHOW_LANDING_PAGE")
	frame:SetScript("OnEvent", function()
		local textTitle
		if ExpansionLandingPageMinimapButton.garrisonMode then
			local garrisonType = C_Garrison.GetLandingPageGarrisonType()
			if garrisonType == Enum.GarrisonType.Type_6_0 then
				textTitle = GARRISON_LANDING_PAGE_TITLE
			elseif garrisonType == Enum.GarrisonType.Type_7_0 then
				textTitle = ORDER_HALL_LANDING_PAGE_TITLE
			elseif garrisonType == Enum.GarrisonType.Type_8_0 then
				textTitle = GARRISON_TYPE_8_0_LANDING_PAGE_TITLE
			elseif garrisonType == Enum.GarrisonType.Type_9_0 then
				textTitle = GARRISON_TYPE_9_0_LANDING_PAGE_TITLE
			end

			if textTitle then
				tinsert(micromenu, {text = textTitle, notCheckable = 1, func = function() GarrisonLandingPage_Toggle() end})
			end
		else
			textTitle = DRAGONFLIGHT_LANDING_PAGE_TITLE
			tinsert(micromenu, {text = textTitle, notCheckable = 1, func = function() ToggleExpansionLandingPage() end})
		end
		frame:UnregisterAllEvents()
	end)
end

Minimap:SetScript("OnMouseUp", function(self, button)
	local position = MinimapAnchor:GetPoint()
	if button == "RightButton" then
		if position:match("LEFT") then
			EasyMenu(micromenu, menuFrame, "cursor", 0, 0, "MENU")
		else
			EasyMenu(micromenu, menuFrame, "cursor", -160, 0, "MENU")
		end
	elseif not T.Vanilla and button == "MiddleButton" then
		if T.Classic then
			if MiniMapTrackingDropDown then
				if position:match("LEFT") then
					ToggleDropDownMenu(nil, nil, MiniMapTrackingDropDown, "cursor", 0, 0, "MENU", 2)
				else
					ToggleDropDownMenu(nil, nil, MiniMapTrackingDropDown, "cursor", -160, 0, "MENU", 2)
				end
			else
				MiniMapTrackingButton:OpenMenu()
				MiniMapTrackingButton.menu:ClearAllPoints()
				if position:match("LEFT") then
					MiniMapTrackingButton.menu:SetPoint("TOPLEFT", Minimap, "RIGHT", 4, 0)
				else
					MiniMapTrackingButton.menu:SetPoint("TOPRIGHT", Minimap, "LEFT", -4, 0)
				end
			end
		else
			if position:match("LEFT") then
				ToggleDropDownMenu(1, nil, MinimapCluster.Tracking.DropDown, "cursor", 0, 0, "MENU", 2)
			else
				ToggleDropDownMenu(1, nil, MinimapCluster.Tracking.DropDown, "cursor", -160, 0, "MENU", 2)
			end
		end
	elseif button == "LeftButton" then
		if T.Classic then
			Minimap_OnClick(self)
		else
			Minimap.OnClick(self)
		end
	end
end)

-- Set Square Map Mask
Minimap:SetMaskTexture(C.media.blank)
if T.Mainline then
	Minimap:SetArchBlobRingAlpha(0)
	Minimap:SetQuestBlobRingAlpha(0)
end

-- For others mods with a minimap button, set minimap buttons position in square mode
function GetMinimapShape() return "SQUARE" end

----------------------------------------------------------------------------------------
--	Hide minimap in combat
----------------------------------------------------------------------------------------
if C.minimap.hide_combat == true then
	MinimapAnchor:RegisterEvent("PLAYER_REGEN_ENABLED")
	MinimapAnchor:RegisterEvent("PLAYER_REGEN_DISABLED")
	MinimapAnchor:HookScript("OnEvent", function(self, event)
		if event == "PLAYER_REGEN_ENABLED" then
			self:Show()
		elseif event == "PLAYER_REGEN_DISABLED" then
			if not T.FarmMode then
				self:Hide()
			end
		end
	end)
end

----------------------------------------------------------------------------------------
--	Tracking icon
----------------------------------------------------------------------------------------
if T.Vanilla then
	if C.minimap.tracking_icon then
		if MiniMapTracking then
			MiniMapTracking:ClearAllPoints()
			MiniMapTracking:SetPoint("BOTTOMLEFT", MinimapAnchor, "BOTTOMLEFT", -4, 0)
			MiniMapTracking.SetPoint = T.dummy
			MiniMapTrackingBorder:Hide()
			MiniMapTracking:SetFrameStrata("HIGH")
			MiniMapTrackingIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			MiniMapTrackingIcon:SetSize(16, 16)
			MiniMapTrackingIcon.SetPoint = T.dummy

			MiniMapTracking:CreateBackdrop("ClassColor")
			MiniMapTracking.backdrop:SetPoint("TOPLEFT", MiniMapTrackingIcon, -2, 2)
			MiniMapTracking.backdrop:SetPoint("BOTTOMRIGHT", MiniMapTrackingIcon, 2, -2)
		end
	else
		if MiniMapTracking then
			MiniMapTracking:Hide()
			MiniMapTrackingBorder:Hide()
			MiniMapTrackingIcon:Hide()
		end
	end
elseif T.TBC or T.Wrath or T.Cata then
	if C.minimap.tracking_icon then
		MiniMapTrackingBackground:Hide()
		MiniMapTracking:ClearAllPoints()
		if T.Wrath or T.Cata then
			MiniMapTracking:SetPoint("BOTTOMLEFT", MinimapAnchor, "BOTTOMLEFT", -1, -5)
			MiniMapTrackingButtonBorder:Hide()
			MiniMapTrackingButton:SetHighlightTexture(0)
		else
			MiniMapTracking:SetPoint("BOTTOMLEFT", MinimapAnchor, "BOTTOMLEFT", -4, 0)
			MiniMapTrackingBorder:Hide()
		end
		MiniMapTrackingIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		MiniMapTrackingIcon:SetSize(16, 16)
		MiniMapTrackingIcon.SetPoint = T.dummy

		MiniMapTracking:CreateBackdrop("ClassColor")
		MiniMapTracking.backdrop:SetPoint("TOPLEFT", MiniMapTrackingIcon, -2, 2)
		MiniMapTracking.backdrop:SetPoint("BOTTOMRIGHT", MiniMapTrackingIcon, 2, -2)
	else
		MiniMapTracking:Hide()
	end
else
	if C.minimap.tracking_icon then
		MinimapCluster.Tracking.Background:Hide()
		MinimapCluster.Tracking.Button:ClearAllPoints()
		MinimapCluster.Tracking.Button:SetPoint("BOTTOMLEFT", MinimapAnchor, "BOTTOMLEFT", 5, 6)
		MinimapCluster.Tracking.Button:SetHighlightTexture(0)
		MinimapCluster.Tracking.Button:SetSize(16, 16)

		MinimapCluster.Tracking.Button:SetScript("OnMouseDown", function(self, button)
			Minimap:GetScript("OnMouseUp")(self, "MiddleButton")
		end)

		MinimapCluster.Tracking:CreateBackdrop("ClassColor")
		MinimapCluster.Tracking.backdrop:SetPoint("TOPLEFT", MinimapCluster.Tracking.Button, -2, 2)
		MinimapCluster.Tracking.backdrop:SetPoint("BOTTOMRIGHT", MinimapCluster.Tracking.Button, 2, -2)
	else
		MinimapCluster.Tracking:Hide()
	end
end

------------------------------------------------------------------------------------------	
-- COMPASS
------------------------------------------------------------------------------------------
if C.minimap.compass then
function compass()

		frameC = CreateFrame("Frame", "Compass", Minimap)
		frameC:SetAllPoints()
		local north = frameC:CreateFontString(frameC:GetName())
		north:SetPoint("TOP", Minimap, "TOP", 0, -2)
		north:SetFont("Interface\\Addons\\ViksUI\\Media\\Font\\HandelGothicBT.ttf",12,"OUTLINE")
		north:SetTextColor(1,1,0,1) 
		north:SetText("N")

		local east = frameC:CreateFontString(frameC:GetName())
		east:SetPoint("RIGHT", Minimap, "RIGHT", -2, 0)
		east:SetFont("Interface\\Addons\\ViksUI\\Media\\Font\\HandelGothicBT.ttf",10,"OUTLINE")
		east:SetTextColor(1,1,.251,1) 
		east:SetText("E")

		local south = frameC:CreateFontString(frameC:GetName())
		south:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, 2)
		south:SetFont("Interface\\Addons\\ViksUI\\Media\\Font\\HandelGothicBT.ttf",10,"OUTLINE")
		south:SetTextColor(1,1,.251,1) 
		south:SetText("S")

		local west = frameC:CreateFontString(frameC:GetName())
		west:SetPoint("LEFT", Minimap, "LEFT", 4, 0)
		west:SetFont("Interface\\Addons\\ViksUI\\Media\\Font\\HandelGothicBT.ttf",10,"OUTLINE")
		west:SetTextColor(1,1,.251,1) 
		west:SetText("W")
end
compass()
end

----------------------------------------------------------------------------------------
--	Battlefield icon (Classic)
----------------------------------------------------------------------------------------
if T.Classic then
	MiniMapBattlefieldFrame:ClearAllPoints()
	MiniMapBattlefieldFrame:SetPoint("TOPRIGHT", MinimapAnchor, "TOPRIGHT", 2, 2)
	MiniMapBattlefieldBorder:Hide()
	MiniMapBattlefieldIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	MiniMapBattlefieldIcon:SetSize(16, 16)
	MiniMapBattlefieldIcon.SetPoint = T.dummy
	BattlegroundShine:Hide()

	MiniMapBattlefieldFrame:CreateBackdrop("ClassColor")
	if T.Vanilla then
		MiniMapBattlefieldFrame.backdrop:SetPoint("TOPLEFT", MiniMapBattlefieldIcon, -2, 2)
		MiniMapBattlefieldFrame.backdrop:SetPoint("BOTTOMRIGHT", MiniMapBattlefieldIcon, 2, -2)
	else
		MiniMapBattlefieldFrame.backdrop:SetPoint("TOPLEFT", MiniMapBattlefieldIcon, 4, -4)
		MiniMapBattlefieldFrame.backdrop:SetPoint("BOTTOMRIGHT", MiniMapBattlefieldIcon, -4, 4)
	end
end