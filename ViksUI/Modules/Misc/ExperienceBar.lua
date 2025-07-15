local T, C, L = unpack(ViksUI)
if C.misc.XPBar ~= true then return end

local ExperienceEnable = true
local Experience = CreateFrame("Frame", nil, UIParent)
local Menu = CreateFrame("Frame", "ViksUIExperienceMenu", UIParent, "UIDropDownMenuTemplate")
local HideTooltip = GameTooltip_Hide
local Panels = CreateFrame("Frame")
local BarSelected
local Bars = 20
local barTex = C.media.texture

Experience.NumBars = 2
Experience.RestedColor = {75 / 255, 175 / 255, 76 / 255}
Experience.XPColor = {0 / 255, 144 / 255, 255 / 255}
Experience.PetXPColor = {255 / 255, 255 / 255, 105 / 255}
Experience.HonorColor = {222 / 255, 22 / 255, 22 / 255}
Experience.RepColor = {0.6, 0.4, 0.1}

Experience.Menu = {
    {
        text = XP,
        func = function()
            BarSelected.BarType = "XP"
            Experience:Update()
            ViksUISettingsPerChar.experiencebar[BarSelected:GetName()] = BarSelected.BarType
        end,
        notCheckable = true
    },
    {
        text = HONOR,
        func = function()
            BarSelected.BarType = "HONOR"
            Experience:Update()
            ViksUISettingsPerChar.experiencebar[BarSelected:GetName()] = BarSelected.BarType
        end,
        notCheckable = true
    },
    {
        text = PET.." "..XP,
        func = function()
            BarSelected.BarType = "PETXP"
            Experience:Update()
            ViksUISettingsPerChar.experiencebar[BarSelected:GetName()] = BarSelected.BarType
        end,
        notCheckable = true
    },
    {
        text = REPUTATION,
        func = function()
            BarSelected.BarType = "REP"
            Experience:Update()
            ViksUISettingsPerChar.experiencebar[BarSelected:GetName()] = BarSelected.BarType
        end,
        notCheckable = true
    },
}

Experience.Standing = {
    [1] = FACTION_STANDING_LABEL1,
    [2] = FACTION_STANDING_LABEL2,
    [3] = FACTION_STANDING_LABEL3,
    [4] = FACTION_STANDING_LABEL4,
    [5] = FACTION_STANDING_LABEL5,
    [6] = FACTION_STANDING_LABEL6,
    [7] = FACTION_STANDING_LABEL7,
    [8] = FACTION_STANDING_LABEL8,
}

function Experience:SetTooltip()
    local BarType = self.BarType
    local Current, Max

    if (self == Experience.XPBar1) then
        GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", -1, 5)
    else
        GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT", 1, 5)
    end

    if BarType == "XP" then
        local Rested = GetXPExhaustion()
        Current, Max = Experience:GetExperience()
        if Max == 0 then return end
        GameTooltip:AddLine("Experience:")
        GameTooltip:AddLine("|cffA335EE"..XP..": " .. Current .. " / " .. Max .. " (" .. math.floor(Current / Max * 100) .. "%)")
        if Rested and Rested > 0 then
            GameTooltip:AddLine("|cff0090FF"..TUTORIAL_TITLE26..": +" .. Rested .." (" .. math.floor(Rested / Max * 100) .. "%)|r")
        end
    elseif BarType == "PETXP" then
        Current, Max = GetPetExperience()
        if Max == 0 then return end
        GameTooltip:AddLine("|cff0090FF"..PET.." "..XP..":|r " .. Current .. " / " .. Max .. " (" .. math.floor(Current / Max * 100) .. "%)")
    elseif BarType == "REP" then
        local name, standing, min, max, value = GetWatchedFactionInfo()
        if not name then return end
        GameTooltip:AddLine(name)
        GameTooltip:AddLine("|cffffffff" .. (value-min) .. " / " .. (max-min) .. "|r")
        GameTooltip:AddLine(Experience.Standing[standing] or "")
	elseif BarType == "HONOR" then
		local honor, maxHonor = Experience:GetHonor()
		GameTooltip:AddLine(HONOR .. ": " .. honor .. " / " .. maxHonor)
	end
    GameTooltip:Show()
end

function Experience:GetExperience()
    return UnitXP("player"), UnitXPMax("player")
end

function Experience:GetHonor()
    local info = C_CurrencyInfo.GetCurrencyInfo and C_CurrencyInfo.GetCurrencyInfo(392)
    if info then
        return info.quantity, info.maxQuantity or 4000 -- 4000 is cap in MoP
    else
        return 0, 4000
    end
end

function Experience:GetReputation()
    local name, standing, min, max, value = GetWatchedFactionInfo()
    return (value-min), (max-min), Experience.Standing[standing]
end

function Experience:Update()
    local Current, Max
    local Rested = GetXPExhaustion()

    for i = 1, self.NumBars do
        local Bar = self["XPBar"..i]
        local RestedBar = self["RestedBar"..i]
        local R, G, B

        if Bar.BarType == "HONOR" then
            Current, Max = self:GetHonor()
            R, G, B = unpack(self.HonorColor)
        elseif Bar.BarType == "PETXP" then
            Current, Max = GetPetExperience()
            R, G, B = unpack(self.PetXPColor)
        elseif Bar.BarType == "REP" then
            Current, Max = self:GetReputation()
            R, G, B = unpack(self.RepColor)
        else
            Current, Max = self:GetExperience()
            R, G, B = unpack(self.XPColor)
        end

        Bar:SetMinMaxValues(0, Max)
        Bar:SetValue(Current)

        if (Bar.BarType == "XP" and Rested and Rested > 0) then
            RestedBar:Show()
            RestedBar:SetMinMaxValues(0, Max)
            RestedBar:SetValue(Rested + Current)
        else
            RestedBar:Hide()
        end

        Bar:SetStatusBarColor(R, G, B)
    end
end

function Experience:DisplayMenu()
    BarSelected = self
    EasyMenu(Experience.Menu, Menu, "cursor", 0, 0, "MENU")
end

function Experience:Create()
    for i = 1, self.NumBars do
        local XPBar = CreateFrame("StatusBar", "ViksUIExperienceBar" .. i, UIParent)
        local RestedBar = CreateFrame("StatusBar", nil, XPBar)
        XPBar:SetStatusBarTexture(barTex)
        XPBar:EnableMouse()
        XPBar:SetFrameStrata("MEDIUM")
        XPBar:SetFrameLevel(2)
        XPBar:CreateBackdrop()
        XPBar:SetScript("OnEnter", Experience.SetTooltip)
        XPBar:SetScript("OnLeave", HideTooltip)
        XPBar:SetScript("OnMouseUp", Experience.DisplayMenu)

        RestedBar:SetStatusBarTexture(barTex)
        RestedBar:SetFrameStrata("MEDIUM")
        RestedBar:SetStatusBarColor(unpack(self.RestedColor))
        RestedBar:SetAllPoints(XPBar)
        RestedBar:SetOrientation("HORIZONTAL")
        RestedBar:SetFrameLevel(XPBar:GetFrameLevel() - 1)
        RestedBar:SetAlpha(.5)
        RestedBar:SetReverseFill(i == 2 and true)
        if C.panels.NoPanels == true then
            XPBar:SetSize(i == 1 and (LEFTChatline:GetWidth()-4) or (RIGHTChatline:GetWidth()-4), 6)
            XPBar:Point("BOTTOMLEFT", i == 1 and LEFTChatline or RIGHTChatline, "TOPLEFT", 2, 6)
        else
            XPBar:SetSize(i == 1 and (LChat:GetWidth()-4) or (RChat:GetWidth()-4), 6)
            XPBar:Point("BOTTOMLEFT", i == 1 and LChatTab or RChatTab, "TOPLEFT", 2, 4)
        end
        XPBar.backdrop:SetFrameLevel(XPBar:GetFrameLevel() - 2)
        XPBar.backdrop:SetOutside()
        XPBar:SetReverseFill(i == 2 and true)
        -- Default settings
        if ViksUISettingsPerChar.experiencebar["ViksUIExperienceBar" .. i] ~= nil then
            XPBar.BarType = ViksUISettingsPerChar.experiencebar["ViksUIExperienceBar" .. i]
        else
            XPBar.BarType = (i == 1) and "XP" or "HONOR"
        end

        self["XPBar"..i] = XPBar
        self["RestedBar"..i] = RestedBar
    end

    self:RegisterEvent("PLAYER_XP_UPDATE")
    self:RegisterEvent("UPDATE_FACTION")
    self:RegisterEvent("PLAYER_LEVEL_UP")
    self:RegisterEvent("UPDATE_EXHAUSTION")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("PLAYER_UPDATE_RESTING")
    self:RegisterEvent("UNIT_PET")
    self:RegisterEvent("UNIT_PET_EXPERIENCE")
    self:RegisterEvent("ADDON_LOADED")
    self:SetScript("OnEvent", self.Update)
end

function Experience:Enable()
    if not ExperienceEnable then
        return
    end

    if not self.XPBar1 then
        self:Create()
    end

    for i = 1, self.NumBars do
        if not self["XPBar"..i]:IsShown() then
            self["XPBar"..i]:Show()
        end

        if not self["RestedBar"..i]:IsShown() then
            self["RestedBar"..i]:Show()
        end
    end
end

function Experience:Disable()
    for i = 1, self.NumBars do
        if self["XPBar"..i]:IsShown() then
            self["XPBar"..i]:Hide()
        end

        if self["RestedBar"..i]:IsShown() then
            self["RestedBar"..i]:Hide()
        end
    end
end

-- Force update after login
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function()
    Experience:Enable()
    Experience:Update()
end)

C.Experience = Experience