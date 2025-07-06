local T, C, L = unpack(ViksUI)
if C.unitframe.enable ~= true or T.class ~= "MONK" then return end

local _, ns = ...
local oUF = ns.oUF

local SPELL_POWER_CHI = Enum.PowerType and Enum.PowerType.Chi or 12
local MAX_CHI = 5

local function HasAscension()
    -- For MoP Classic, Ascension is always Tier 3, Column 2 for Monk
    local tier, col = 3, 2
    local name, _, _, selected = GetTalentInfo(tier, col, 1)
    return selected
end

local function Update(self, _, unit, powerType)
    if (self.unit ~= unit and (powerType and (powerType ~= "CHI" and powerType ~= "DARK_FORCE"))) then return end

    local element = self.HarmonyBar

    if element.PreUpdate then
        element:PreUpdate(unit)
    end

    local cur = UnitPower("player", SPELL_POWER_CHI)
    local max = 5
    local barWidth = element:GetWidth()
    local spacing = 1 -- Adjust if you use other spacing
    local orbWidth = (barWidth - spacing * (max - 1)) / max

    -- Show/hide and resize all 5 orbs
    for i = 1, MAX_CHI do
        if element[i] then
            if i <= max then
                element[i]:Show()
                element[i]:SetWidth(orbWidth)
                if i == 1 then
                    element[i]:SetPoint("LEFT", element, "LEFT", 0, 0)
                else
                    element[i]:SetPoint("LEFT", element[i-1], "RIGHT", spacing, 0)
                end
                element[i]:SetAlpha(i <= cur and 1 or 0.2)
            else
                element[i]:Hide()
            end
        end
    end

    if element.PostUpdate then
        return element:PostUpdate(cur)
    end
end

local function Path(self, ...)
    return (self.HarmonyBar.Override or Update)(self, ...)
end

local function ForceUpdate(element)
    return Path(element.__owner, "ForceUpdate", element.__owner.unit, "CHI")
end

local function Visibility(self)
    local element = self.HarmonyBar
    element:Show()
    if self.Debuffs then
        self.Debuffs:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 2, 19)
    end
end

local function Enable(self, unit)
    local element = self.HarmonyBar
    if element and unit == "player" then
        element.__owner = self
        element.ForceUpdate = ForceUpdate

        self:RegisterEvent("UNIT_POWER_UPDATE", Path)
        self:RegisterEvent("UNIT_DISPLAYPOWER", Path)
        self:RegisterEvent("UNIT_MAXPOWER", Path)

        if not element.handler then
            element.handler = CreateFrame("Frame", nil, element)
        end
        element.handler:RegisterEvent("PLAYER_TALENT_UPDATE")
        element.handler:RegisterEvent("PLAYER_ENTERING_WORLD")
        element.handler:SetScript("OnEvent", function() Visibility(self); ForceUpdate(element) end)

        element.maxChi = 0

        return true
    end
end

local function Disable(self)
    local element = self.HarmonyBar
    if element then
        self:UnregisterEvent("UNIT_POWER_UPDATE", Path)
        self:UnregisterEvent("UNIT_DISPLAYPOWER", Path)
        self:UnregisterEvent("UNIT_MAXPOWER", Path)
        if element.handler then
            element.handler:UnregisterEvent("PLAYER_TALENT_UPDATE")
            element.handler:UnregisterEvent("PLAYER_ENTERING_WORLD")
        end
    end
end

oUF:AddElement("HarmonyBar", Path, Enable, Disable)