local T, C, L = unpack(ViksUI)
if C.tooltip.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Based on aTooltip(by ALZA)
----------------------------------------------------------------------------------------
local StoryTooltip, CampaignTooltip

if T.Mainline then
	StoryTooltip = QuestScrollFrame.StoryTooltip
	StoryTooltip:SetFrameLevel(4)

	CampaignTooltip = QuestScrollFrame.CampaignTooltip

	T.SkinCloseButton(_G.ItemRefTooltip.CloseButton)
end

local tooltips = {
	GameTooltip,
	ItemRefTooltip,
	ShoppingTooltip1,
	ShoppingTooltip2,
	FriendsTooltip,
	ItemRefShoppingTooltip1,
	ItemRefShoppingTooltip2,
	StoryTooltip,
	ReputationParagonTooltip,
	CampaignTooltip,
	EmbeddedItemTooltip,
	QuickKeybindTooltip,
	SettingsTooltip,
	-- Addons
	AtlasLootTooltip,
	QuestGuru_QuestWatchTooltip,
	TomTomTooltip,
	LibDBIconTooltip,
	AceConfigDialogTooltip,
	BigWigsOptionsTooltip
}

local backdrop = {
	bgFile = C.media.blank, edgeFile = C.media.blank, edgeSize = T.mult,
	insets = {left = -T.mult, right = -T.mult, top = -T.mult, bottom = -T.mult}
}

for _, tt in pairs(tooltips) do
	if not C_AddOns.IsAddOnLoaded("Aurora") then
		tt.NineSlice:SetAlpha(0)
		local bg = CreateFrame("Frame", nil, tt)
		bg:SetPoint("TOPLEFT")
		bg:SetPoint("BOTTOMRIGHT")
		if tt:GetFrameLevel() - 1 >= 0 then
			bg:SetFrameLevel(tt:GetFrameLevel() - 1)
		else
			bg:SetFrameLevel(0)
		end
		bg:SetTemplate("Transparent")

		tt.GetBackdrop = function() return backdrop end
		tt.GetBackdropColor = function() return C.media.backdrop_color[1], C.media.backdrop_color[2], C.media.backdrop_color[3], C.media.backdrop_alpha end
		tt.GetBackdropBorderColor = function() return unpack(C.media.border_color) end
	end
end

-- LibExtraTip skin
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function()
	if not C_AddOns.IsAddOnLoaded("Auc-Advanced") then return end

	local LT = LibStub("LibExtraTip-1")
	for _, Tooltip in pairs({GameTooltip, ItemRefTooltip}) do
		Tooltip:HookScript("OnUpdate", function(self)
			if not LT then return end
			local ExtraTip = LT:GetExtraTip(self)
			if ExtraTip then
				if not ExtraTip.IsDone then
					ExtraTip:StripTextures()
					ExtraTip:CreateBackdrop("Transparent")
					ExtraTip.backdrop:SetPoint("TOPLEFT", 0, -3)
					ExtraTip.backdrop:SetPoint("BOTTOMRIGHT", 0, 2)
					ExtraTip:HookScript("OnShow", function()
						ExtraTip.backdrop:SetFrameLevel(0)
					end)
					ExtraTip.IsDone = true
				end
			end
		end)
	end
end)

if C_AddOns.IsAddOnLoaded("RaiderIO") then
	PVEFrame:HookScript("OnShow", function(self)
		if not RaiderIO_ProfileTooltip.styled then
			RaiderIO_ProfileTooltip.NineSlice:SetAlpha(0)
			RaiderIO_ProfileTooltip:CreateBackdrop("Transparent")
			RaiderIO_ProfileTooltip.backdrop:SetPoint("TOPLEFT", 3, 0)
			RaiderIO_ProfileTooltip.backdrop:SetPoint("BOTTOMRIGHT", -2, 0)
			RaiderIO_ProfileTooltip.styled = true

			if DF_Frame and C.skins.blizzard_frames then
				DF_Frame:StripTextures()
				DF_Frame:SetTemplate("Transparent")
				T.SkinEditBox(DF_Frame.minRioEdit, nil, 15)
				T.SkinEditBox(DF_Frame.maxRioEdit, nil, 15)
				T.SkinCheckBox(DF_Frame.showRIO)
				T.SkinCheckBox(DF_Frame.showClass)
				T.SkinCheckBox(DF_Frame.removeSelfRole)
				T.SkinCheckBox(DF_Frame.showPreviousRIO)
				DF_Frame.applyBtn:SkinButton()
			end
		end
	end)
end

local anchor = CreateFrame("Frame", "TooltipAnchor", UIParent)
anchor:SetSize(200, 40)
anchor:SetPoint(unpack(C.position.tooltip))

-- Hide PVP text
PVP_ENABLED = ""

-- Statusbar
GameTooltipStatusBar:SetStatusBarTexture(C.media.texture)
GameTooltipStatusBar:SetHeight(4)
GameTooltipStatusBar:ClearAllPoints()
GameTooltipStatusBar:SetPoint("TOPLEFT", GameTooltip, "BOTTOMLEFT", 2, 6)
GameTooltipStatusBar:SetPoint("TOPRIGHT", GameTooltip, "BOTTOMRIGHT", -2, 6)

-- Raid icon
local ricon = GameTooltip:CreateTexture("GameTooltipRaidIcon", "OVERLAY")
ricon:SetHeight(18)
ricon:SetWidth(18)
ricon:SetPoint("BOTTOM", GameTooltip, "TOP", 0, 5)

GameTooltip:HookScript("OnHide", function() ricon:SetTexture(0) end)

-- Add "Targeted By" line
local targetedList = {}
local ClassColors = {}
local token
for class, color in next, RAID_CLASS_COLORS do
	if T.Vanilla and class == "SHAMAN" then
		ClassColors[class] = ("|cff%.2x%.2x%.2x"):format(0 * 255, 0.44 * 255, 0.87 * 255)
	else
		ClassColors[class] = ("|cff%.2x%.2x%.2x"):format(color.r * 255, color.g * 255, color.b * 255)
	end
end

local function AddTargetedBy()
	local numParty, numRaid = GetNumSubgroupMembers(), GetNumGroupMembers()
	if numParty > 0 or numRaid > 0 then
		for i = 1, (numRaid > 0 and numRaid or numParty) do
			local unit = (numRaid > 0 and "raid"..i or "party"..i)
			if UnitIsUnit(unit.."target", token) and not UnitIsUnit(unit, "player") then
				local _, class = UnitClass(unit)
				targetedList[#targetedList + 1] = ClassColors[class]
				targetedList[#targetedList + 1] = UnitName(unit)
				targetedList[#targetedList + 1] = "|r, "
			end
		end
		if #targetedList > 0 then
			targetedList[#targetedList] = nil
			GameTooltip:AddLine(" ", nil, nil, nil, 1)
			local line = _G["GameTooltipTextLeft"..GameTooltip:NumLines()]
			if not line then return end
			line:SetFormattedText(L_TOOLTIP_WHO_TARGET.." (|cffffffff%d|r): %s", (#targetedList + 1) / 3, table.concat(targetedList))
			wipe(targetedList)
		end
	end
end

----------------------------------------------------------------------------------------
--	Unit tooltip styling
----------------------------------------------------------------------------------------
local function GetColor(unit)
	if not unit then return end
	local r, g, b

	if UnitIsPlayer(unit) then
		local _, class = UnitClass(unit)
		local color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
		if color then
			r, g, b = color.r, color.g, color.b
			if T.Vanilla and class == "SHAMAN" and not CUSTOM_CLASS_COLORS then
				r, g, b = 0, 0.44, 0.87
			end
		else
			r, g, b = 1, 1, 1
		end
	elseif UnitIsTapDenied(unit) or UnitIsDead(unit) then
		r, g, b = 0.6, 0.6, 0.6
	else
		local reaction = T.Colors.reaction[UnitReaction(unit, "player")]
		if reaction then
			r, g, b = reaction[1], reaction[2], reaction[3]
		else
			r, g, b = 1, 1, 1
		end
	end

	return r, g, b
end

local function GameTooltipDefault(tooltip, parent)
	if C.tooltip.cursor == true then
		tooltip:SetOwner(parent, "ANCHOR_CURSOR_RIGHT", 20, 20)
	else
		tooltip:SetOwner(parent, "ANCHOR_NONE")
		tooltip:ClearAllPoints()
		if C.tooltip.topleft then
			tooltip:ClearAllPoints()
			tooltip:SetPoint("TOPLEFT",TooltipAnchor, "TOPLEFT", 0, -3)				
		elseif C.tooltip.topright then
			tooltip:ClearAllPoints()
			tooltip:SetPoint("BOTTOMRIGHT", TooltipAnchor)		
		elseif C.tooltip.bottomleft then
			tooltip:ClearAllPoints()
			tooltip:SetPoint("BOTTOMLEFT", TooltipAnchor, "BOTTOMLEFT", 0,00)		
		elseif C.tooltip.bottomright then
			tooltip:ClearAllPoints()
			tooltip:SetPoint("BOTTOMRIGHT", TooltipAnchor, "TOPRIGHT", -1, -70)
		end
		tooltip.default = 1
	end
	if not C.tooltip.shift_modifer then
		if InCombatLockdown() and C.tooltip.hide_combat and not IsShiftKeyDown() then
			tooltip:Hide()
		end
	end
end
hooksecurefunc("GameTooltip_SetDefaultAnchor", GameTooltipDefault)

if C.tooltip.shift_modifer == true then
	GameTooltip:SetScript("OnShow", function(self)
		if IsShiftKeyDown() then
			self:Show()
		else
			if not HoverBind.enabled then
				self:Hide()
			end
		end
	end)
end

if C.tooltip.health_value == true then
	GameTooltipStatusBar:SetScript("OnValueChanged", function(self, value)
		if not value then return end
		local min, max = self:GetMinMaxValues()
		if (value < min) or (value > max) then return end
		self:SetStatusBarColor(0, 1, 0)
		local _, unit = GameTooltip:GetUnit()
		if unit then
			min, max = UnitHealth(unit), UnitHealthMax(unit)
			if not self.text then
				self.text = self:CreateFontString(nil, "OVERLAY", "Tooltip_Med")
				self.text:SetPoint("CENTER", GameTooltipStatusBar, 0, 1.5)
			end
			self.text:Show()
			local hp = T.ShortValue(min).." / "..T.ShortValue(max)
			self.text:SetText(hp)
		end
	end)
end

local OnTooltipSetUnit = function(self)
	if self ~= GameTooltip or self:IsForbidden() then return end
	local lines = self:NumLines()
	local unit = (select(2, self:GetUnit())) or (GetMouseFoci() and GetMouseFoci().GetAttribute and GetMouseFoci():GetAttribute("unit")) or (UnitExists("mouseover") and "mouseover") or nil

	if not unit then return end

	local name, realm = UnitName(unit)
	local race, englishRace = UnitRace(unit)
	local level = UnitLevel(unit)
	local levelColor = GetCreatureDifficultyColor(level)
	local classification = UnitClassification(unit)
	local creatureType = UnitCreatureType(unit)
	local _, faction = UnitFactionGroup(unit)
	local _, playerFaction = UnitFactionGroup("player")
	local titleName = UnitPVPName(unit)
	local isPlayer = UnitIsPlayer(unit)

	if level and level == -1 then
		if classification == "worldboss" then
			level = "|cffff0000|r"..ENCOUNTER_JOURNAL_ENCOUNTER
		else
			level = "|cffff0000??|r"
		end
	end

	if classification == "rareelite" then classification = " R+"
	elseif classification == "rare" then classification = " R"
	elseif classification == "elite" then classification = "+"
	else classification = "" end


	if titleName and C.tooltip.title then
		name = titleName
	end

	local r, g, b = GetColor(unit)
	_G["GameTooltipTextLeft1"]:SetFormattedText("|cff%02x%02x%02x%s|r", r * 255, g * 255, b * 255, name or "")

	if realm and realm ~= "" and C.tooltip.realm then
		self:AddLine(FRIENDS_LIST_REALM.."|cffffffff"..realm.."|r")
	end

	if isPlayer then
		if UnitIsAFK(unit) then
			self:AppendText((" %s"):format("|cffE7E716"..L_CHAT_AFK.."|r"))
		elseif UnitIsDND(unit) then
			self:AppendText((" %s"):format("|cffFF0000"..L_CHAT_DND.."|r"))
		end

		if isPlayer and (englishRace == "Pandaren" or englishRace == "Dracthyr") and faction ~= nil and faction ~= playerFaction then
			local hex = "cffff3333"
			if faction == "Alliance" then
				hex = "cff69ccf0"
			end
			self:AppendText((" [|%s%s|r]"):format(hex, faction:sub(1, 2)))
		end

		local guildName, guildRank = GetGuildInfo(unit)
		if guildName then
			_G["GameTooltipTextLeft2"]:SetFormattedText("%s", guildName)
			if UnitIsInMyGuild(unit) then
				_G["GameTooltipTextLeft2"]:SetTextColor(1, 1, 0)
			else
				_G["GameTooltipTextLeft2"]:SetTextColor(0, 1, 1)
			end
			self:AddLine(RANK..": |cffffffff"..guildRank.."|r")
		end

		local n = guildName and 3 or 2
		-- thx TipTac for the fix above with color blind enabled
		if GetCVar("colorblindMode") == "1" then
			n = n + 1
			local class = UnitClass(unit)
			_G["GameTooltipTextLeft"..n]:SetFormattedText("|cff%02x%02x%02x%s|r %s %s", levelColor.r * 255, levelColor.g * 255, levelColor.b * 255, level, race or UNKNOWN, class or "")
		else
			_G["GameTooltipTextLeft"..n]:SetFormattedText("|cff%02x%02x%02x%s|r %s", levelColor.r * 255, levelColor.g * 255, levelColor.b * 255, level, race or UNKNOWN)
		end

		for i = n + 1, lines do
			local line = _G["GameTooltipTextLeft"..i]
			if not line or not line:GetText() then return end
			if line and line:GetText() and (line:GetText() == FACTION_HORDE or line:GetText() == FACTION_ALLIANCE) then
				line:SetText()
				break
			end
		end
	else
		for i = 2, lines do
			local line = _G["GameTooltipTextLeft"..i]
			if not line or not line:GetText() or (T.Mainline and UnitIsBattlePetCompanion(unit)) then return end
			if (level and line:GetText():find("^"..LEVEL)) or (creatureType and line:GetText():find("^"..creatureType)) then
				line:SetFormattedText("|cff%02x%02x%02x%s%s|r %s", levelColor.r * 255, levelColor.g * 255, levelColor.b * 255, level, classification, creatureType or "")
				break
			end
		end
	end

	if C.tooltip.target == true and UnitExists(unit.."target") then
		local r, g, b = GetColor(unit.."target")
		local text = ""

		if UnitIsEnemy("player", unit.."target") then
			r, g, b = unpack(T.Colors.reaction[1])
		elseif not UnitIsFriend("player", unit.."target") then
			r, g, b = unpack(T.Colors.reaction[4])
		end

		if UnitName(unit.."target") == UnitName("player") then
			text = "|cfffed100"..STATUS_TEXT_TARGET..":|r ".."|cffff0000> "..UNIT_YOU.." <|r"
		else
			text = "|cfffed100"..STATUS_TEXT_TARGET..":|r "..UnitName(unit.."target")
		end

		self:AddLine(text, r, g, b)
	end

	if C.tooltip.raid_icon == true then
		local raidIndex = GetRaidTargetIndex(unit)
		if raidIndex then
			ricon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_"..raidIndex)
		else
			ricon:SetTexture(0)
		end
	end

	if C.tooltip.who_targetting == true then
		token = unit AddTargetedBy()
	end
end

if T.Classic then
	GameTooltip:HookScript("OnTooltipSetUnit", OnTooltipSetUnit)
else
	TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, OnTooltipSetUnit)
end

----------------------------------------------------------------------------------------
--	Hide tooltips in combat for action bars, pet bar and stance bar
----------------------------------------------------------------------------------------
if C.tooltip.hidebuttons == true then
	local CombatHideActionButtonsTooltip = function(self)
		if not IsShiftKeyDown() then
			self:Hide()
		end
	end

	hooksecurefunc(GameTooltip, "SetAction", CombatHideActionButtonsTooltip)
	hooksecurefunc(GameTooltip, "SetPetAction", CombatHideActionButtonsTooltip)
	hooksecurefunc(GameTooltip, "SetShapeshift", CombatHideActionButtonsTooltip)
end

----------------------------------------------------------------------------------------
--	Fix compare tooltips(by Blizzard)(../FrameXML/GameTooltip.lua)
----------------------------------------------------------------------------------------
if T.Classic then
	-- TODO: Revisit this
	hooksecurefunc("GameTooltip_AnchorComparisonTooltips", function(_, anchorFrame, shoppingTooltip1, shoppingTooltip2, _, secondaryItemShown)
		local point = shoppingTooltip1:GetPoint(2)
		if secondaryItemShown then
			if point == "TOP" then
				shoppingTooltip1:ClearAllPoints()
				shoppingTooltip2:ClearAllPoints()
				shoppingTooltip1:SetPoint("TOPLEFT", anchorFrame, "TOPRIGHT", 3, -10)
				shoppingTooltip2:SetPoint("TOPLEFT", shoppingTooltip1, "TOPRIGHT", 3, 0)
			elseif point == "RIGHT" then
				shoppingTooltip1:ClearAllPoints()
				shoppingTooltip2:ClearAllPoints()
				shoppingTooltip1:SetPoint("TOPRIGHT", anchorFrame, "TOPLEFT", -3, -10)
				shoppingTooltip2:SetPoint("TOPRIGHT", shoppingTooltip1, "TOPLEFT", -3, 0)
			end
		else
			if point == "LEFT" then
				shoppingTooltip1:ClearAllPoints()
				shoppingTooltip1:SetPoint("TOPLEFT", anchorFrame, "TOPRIGHT", 3, -10)
			elseif point == "RIGHT" then
				shoppingTooltip1:ClearAllPoints()
				shoppingTooltip1:SetPoint("TOPRIGHT", anchorFrame, "TOPLEFT", -3, -10)
			end
		end
	end)
else
	hooksecurefunc(TooltipComparisonManager, "AnchorShoppingTooltips", function(self, primaryShown, secondaryItemShown)
		local tooltip = self.tooltip
		local shoppingTooltip1 = tooltip.shoppingTooltips[1]
		local shoppingTooltip2 = tooltip.shoppingTooltips[2]
		local point = shoppingTooltip1:GetPoint(2)
		if secondaryItemShown then
			if point == "TOP" then
				shoppingTooltip1:ClearAllPoints()
				shoppingTooltip2:ClearAllPoints()
				shoppingTooltip1:SetPoint("TOPLEFT", self.anchorFrame, "TOPRIGHT", 3, -10)
				shoppingTooltip2:SetPoint("TOPLEFT", shoppingTooltip1, "TOPRIGHT", 3, 0)
			elseif point == "RIGHT" then
				shoppingTooltip1:ClearAllPoints()
				shoppingTooltip2:ClearAllPoints()
				shoppingTooltip1:SetPoint("TOPRIGHT", self.anchorFrame, "TOPLEFT", -3, -10)
				shoppingTooltip2:SetPoint("TOPRIGHT", shoppingTooltip1, "TOPLEFT", -3, 0)
			end
		else
			if point == "LEFT" then
				shoppingTooltip1:ClearAllPoints()
				shoppingTooltip1:SetPoint("TOPLEFT", self.anchorFrame, "TOPRIGHT", 3, -10)
			elseif point == "RIGHT" then
				shoppingTooltip1:ClearAllPoints()
				shoppingTooltip1:SetPoint("TOPRIGHT", self.anchorFrame, "TOPLEFT", -3, -10)
			end
		end
	end)
end

----------------------------------------------------------------------------------------
--	Fix GameTooltipMoneyFrame font size
----------------------------------------------------------------------------------------
if T.Classic then
	local function FixFont()
		for i = 1, 2 do
			if _G["GameTooltipMoneyFrame"..i] then
				_G["GameTooltipMoneyFrame"..i.."PrefixText"]:SetFontObject("GameTooltipText")
				_G["GameTooltipMoneyFrame"..i.."SuffixText"]:SetFontObject("GameTooltipText")
				_G["GameTooltipMoneyFrame"..i.."GoldButton"]:SetNormalFontObject("GameTooltipText")
				_G["GameTooltipMoneyFrame"..i.."SilverButton"]:SetNormalFontObject("GameTooltipText")
				_G["GameTooltipMoneyFrame"..i.."CopperButton"]:SetNormalFontObject("GameTooltipText")
			end
		end
		for i = 1, 2 do
			if _G["ItemRefTooltipMoneyFrame"..i] then
				_G["ItemRefTooltipMoneyFrame"..i.."PrefixText"]:SetFontObject("GameTooltipText")
				_G["ItemRefTooltipMoneyFrame"..i.."SuffixText"]:SetFontObject("GameTooltipText")
				_G["ItemRefTooltipMoneyFrame"..i.."GoldButton"]:SetNormalFontObject("GameTooltipText")
				_G["ItemRefTooltipMoneyFrame"..i.."SilverButton"]:SetNormalFontObject("GameTooltipText")
				_G["ItemRefTooltipMoneyFrame"..i.."CopperButton"]:SetNormalFontObject("GameTooltipText")
			end
		end
	end

	GameTooltip:HookScript("OnTooltipSetItem", FixFont)
	ItemRefTooltip:HookScript("OnTooltipSetItem", FixFont)
else
	hooksecurefunc("SetTooltipMoney", function()
		for i = 1, 2 do
			if _G["GameTooltipMoneyFrame"..i] then
				_G["GameTooltipMoneyFrame"..i.."PrefixText"]:SetFontObject("GameTooltipText")
				_G["GameTooltipMoneyFrame"..i.."SuffixText"]:SetFontObject("GameTooltipText")
				_G["GameTooltipMoneyFrame"..i.."GoldButton"]:SetNormalFontObject("GameTooltipText")
				_G["GameTooltipMoneyFrame"..i.."SilverButton"]:SetNormalFontObject("GameTooltipText")
				_G["GameTooltipMoneyFrame"..i.."CopperButton"]:SetNormalFontObject("GameTooltipText")
			end
		end
		for i = 1, 2 do
			if _G["ShoppingTooltip1MoneyFrame"..i] then
				_G["ShoppingTooltip1MoneyFrame"..i.."PrefixText"]:SetFontObject("GameTooltipText")
				_G["ShoppingTooltip1MoneyFrame"..i.."SuffixText"]:SetFontObject("GameTooltipText")
				_G["ShoppingTooltip1MoneyFrame"..i.."GoldButton"]:SetNormalFontObject("GameTooltipText")
				_G["ShoppingTooltip1MoneyFrame"..i.."SilverButton"]:SetNormalFontObject("GameTooltipText")
				_G["ShoppingTooltip1MoneyFrame"..i.."CopperButton"]:SetNormalFontObject("GameTooltipText")
			end
		end
	end)

	-- Custom tooltip from MultiItemRef.lua
	if _G["ItemRefTooltipMoneyFrame1"] then
		_G["ItemRefTooltipMoneyFrame1PrefixText"]:SetFontObject("GameTooltipText")
		_G["ItemRefTooltipMoneyFrame1SuffixText"]:SetFontObject("GameTooltipText")
		_G["ItemRefTooltipMoneyFrame1GoldButton"]:SetNormalFontObject("GameTooltipText")
		_G["ItemRefTooltipMoneyFrame1SilverButton"]:SetNormalFontObject("GameTooltipText")
		_G["ItemRefTooltipMoneyFrame1CopperButton"]:SetNormalFontObject("GameTooltipText")
	end

	for i = 2, 4 do
		if _G["ItemRefTooltip"..i.."MoneyFrame1"] then
			_G["ItemRefTooltip"..i.."MoneyFrame1PrefixText"]:SetFontObject("GameTooltipText")
			_G["ItemRefTooltip"..i.."MoneyFrame1SuffixText"]:SetFontObject("GameTooltipText")
			_G["ItemRefTooltip"..i.."MoneyFrame1GoldButton"]:SetNormalFontObject("GameTooltipText")
			_G["ItemRefTooltip"..i.."MoneyFrame1SilverButton"]:SetNormalFontObject("GameTooltipText")
			_G["ItemRefTooltip"..i.."MoneyFrame1CopperButton"]:SetNormalFontObject("GameTooltipText")
		end
	end
end

----------------------------------------------------------------------------------------
--	Skin GameTooltip.ItemTooltip and EmbeddedItemTooltip
----------------------------------------------------------------------------------------
if T.Mainline then
	GameTooltip.ItemTooltip.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	hooksecurefunc(GameTooltip.ItemTooltip.IconBorder, "SetVertexColor", function(self, r, g, b)
		if r ~= BAG_ITEM_QUALITY_COLORS[1].r ~= r and g ~= BAG_ITEM_QUALITY_COLORS[1].g then
			self:GetParent().backdrop:SetBackdropBorderColor(r, g, b)
		end
		self:SetTexture(0)
	end)

	hooksecurefunc(GameTooltip.ItemTooltip.IconBorder, "Hide", function(self)
		self:GetParent().backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
	end)

	GameTooltip.ItemTooltip:CreateBackdrop("Default")
	GameTooltip.ItemTooltip.backdrop:SetPoint("TOPLEFT", GameTooltip.ItemTooltip.Icon, "TOPLEFT", -2, 2)
	GameTooltip.ItemTooltip.backdrop:SetPoint("BOTTOMRIGHT", GameTooltip.ItemTooltip.Icon, "BOTTOMRIGHT", 2, -2)
	GameTooltip.ItemTooltip.Count:ClearAllPoints()
	GameTooltip.ItemTooltip.Count:SetPoint("BOTTOMRIGHT", GameTooltip.ItemTooltip.Icon, "BOTTOMRIGHT", 1, 0)

	BONUS_OBJECTIVE_REWARD_FORMAT = "|T%1$s:16:16:0:0:64:64:5:59:5:59|t %2$s"
	BONUS_OBJECTIVE_REWARD_WITH_COUNT_FORMAT = "|T%1$s:16:16:0:0:64:64:5:59:5:59|t |cffffffff%2$d|r %3$s"
end

local reward = EmbeddedItemTooltip.ItemTooltip
local icon = reward.Icon
if icon then
	icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	reward:CreateBackdrop("Default")
	reward.backdrop:SetPoint("TOPLEFT", icon, "TOPLEFT", -2, 2)
	reward.backdrop:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 2, -2)

	hooksecurefunc(reward.IconBorder, "SetVertexColor", function(self, r, g, b)
		if r ~= BAG_ITEM_QUALITY_COLORS[1].r ~= r and g ~= BAG_ITEM_QUALITY_COLORS[1].g then
			self:GetParent().backdrop:SetBackdropBorderColor(r, g, b)
		end
		self:SetTexture(0)
	end)

	hooksecurefunc(reward.IconBorder, "Hide", function(self)
		self:GetParent().backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
	end)
end

hooksecurefunc("GameTooltip_ShowProgressBar", function(tt)
	if not tt or tt:IsForbidden() or not tt.progressBarPool then return end

	local frame = tt.progressBarPool:GetNextActive()
	if (not frame or not frame.Bar) or frame.Bar.backdrop then return end

	local bar = frame.Bar
	local label = bar.Label
	if bar then
		bar:StripTextures()
		bar:CreateBackdrop("Transparent")
		bar.backdrop:SetBackdropColor(0.1, 0.1, 0.1, 1)
		bar:SetStatusBarTexture(C.media.texture)
		label:ClearAllPoints()
		label:SetPoint("CENTER", bar, 0, 0)
		label:SetDrawLayer("OVERLAY")
		label:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
	end
end)

hooksecurefunc("GameTooltip_ShowStatusBar", function(tt)
	if not tt or tt:IsForbidden() or not tt.statusBarPool then return end

	local frame = tt.statusBarPool:GetNextActive()

	if frame and not frame.backdrop then
		frame:StripTextures()
		frame:CreateBackdrop("Transparent")
		frame.backdrop:SetBackdropColor(0.1, 0.1, 0.1, 1)
		frame:SetStatusBarTexture(C.media.texture)
	end
end)