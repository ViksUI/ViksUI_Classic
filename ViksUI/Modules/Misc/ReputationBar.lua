local T, C, L, _ = unpack(select(2, ...))

if C.XPBar.enable ~= true then return end

--local Miscellaneous = T["Miscellaneous"]
local ExperienceEnable = true
local ReputationEnable = true
local Reputation = CreateFrame("Frame", nil, UIParent)
local HideTooltip = GameTooltip_Hide
local Panels = CreateFrame("Frame")
local Bars = 20
local barTex = C.media.texture

local Colors = FACTION_BAR_COLORS

Reputation.NumBars = 2

function Reputation:SetTooltip()
	if (not GetWatchedFactionInfo()) then
		return
	end

	local Name, ID, Min, Max, Value = GetWatchedFactionInfo()

	if (self == Reputation.RepBar1) then
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", -1, 5)
	else
		GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT", 1, 5)
	end

	GameTooltip:AddLine(string.format("%s (%s)", Name, _G["FACTION_STANDING_LABEL" .. ID]))

	if (Min ~= Max) and (Min > 0) then
		local Val1 = Value - Min
		local Val2 = Max - Min
		local Val3 = (Value - Min) / (Max - Min) * 100

		GameTooltip:AddLine(Val1 .. " / " .. Val2 .. " (" .. floor(Val3) .. "%)")
	end

	GameTooltip:Show()
end

function Reputation:Update()
	if GetWatchedFactionInfo() then
		self:Enable()
	else
		self:Disable()

		return
	end

	local Name, ID, Min, Max, Value = GetWatchedFactionInfo()

	for i = 1, self.NumBars do
		self["RepBar"..i]:SetMinMaxValues(Min, Max)
		self["RepBar"..i]:SetValue(Value)
		self["RepBar"..i]:SetStatusBarColor(Colors[ID].r, Colors[ID].g, Colors[ID].b)
	end
end

function Reputation:Create()
	for i = 1, self.NumBars do
		local RepBar = CreateFrame("StatusBar", nil, UIParent)
		local XPBar1 = C.Experience.XPBar1
		local XPBar2 = C.Experience.XPBar2

		RepBar:SetStatusBarTexture(C.Medias.Normal)
		RepBar:EnableMouse()
		RepBar:SetFrameStrata("MEDIUM")
		RepBar:SetFrameLevel(4)
		RepBar:CreateBackdrop()
		RepBar:SetScript("OnEnter", Reputation.SetTooltip)
		RepBar:SetScript("OnLeave", HideTooltip)
		RepBar:SetSize(i == 1 and (LChat:GetWidth()-4) or (RChat:GetWidth()-4), 6)
		RepBar:SetAllPoints(i == 1 and XPBar1 or i == 2 and XPBar2)
		RepBar:SetReverseFill(i == 2 and true)

		self["RepBar"..i] = RepBar
	end

	self:RegisterEvent("UPDATE_FACTION")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")

	self:SetScript("OnEvent", self.Update)
end

function Reputation:Enable()
	if not ExperienceEnable then
		return -- it need xp bar enabled
	end
	
	if not ReputationEnable then
		return
	end
	
	if not self.IsCreated then
		self:Create()

		self.IsCreated = true
	end
	if not T.classic then
		local ShowArtifact = HasArtifactEquipped()
		local PlayerLevel = UnitLevel("player")

		self.RepBar1:Show()

		if ShowArtifact ~= true and PlayerLevel ~= MAX_PLAYER_LEVEL then
			self.RepBar2:Show()
		else
			self.RepBar2:Hide()
		end
	end
end

function Reputation:Disable()
	for i = 1, self.NumBars do
		if self["RepBar"..i]:IsShown() then
			self["RepBar"..i]:Hide()
		end
	end
end

Reputation:Enable()
