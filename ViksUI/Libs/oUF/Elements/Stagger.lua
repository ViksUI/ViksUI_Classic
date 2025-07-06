-- Stagger element for oUF, updated for WoW Classic: Mists of Pandaria
if (select(2, UnitClass("player")) ~= "MONK") then return end

local _, ns = ...
local oUF = ns.oUF

-- Ensure UnitStagger exists (MoP+ only)
if not UnitStagger then return end

-- MoP Classic: specialization indices
local SPEC_MONK_BREWMASTER = 1

-- Bar color thresholds (MoP default: green/yellow/red)
local STAGGER_YELLOW_TRANSITION = 0.3
local STAGGER_RED_TRANSITION = 0.6
local STAGGER_GREEN_INDEX = 1
local STAGGER_YELLOW_INDEX = 2
local STAGGER_RED_INDEX = 3

-- Default colors for stagger (if oUF colors not set)
local defaultColors = {
    {0.52, 1.00, 0.52}, -- Green
    {1.00, 0.98, 0.72}, -- Yellow
    {1.00, 0.42, 0.42}, -- Red
}

local function UpdateColor(element, cur, max)
    local colors = (element.__owner.colors and element.__owner.colors.power and element.__owner.colors.power.STAGGER) or defaultColors
    local perc = max > 0 and (cur / max) or 0

    local t
    if perc >= STAGGER_RED_TRANSITION then
        t = colors[STAGGER_RED_INDEX]
    elseif perc > STAGGER_YELLOW_TRANSITION then
        t = colors[STAGGER_YELLOW_INDEX]
    else
        t = colors[STAGGER_GREEN_INDEX]
    end

    if t then
        element:SetStatusBarColor(t[1], t[2], t[3])
        if element.bg then
            local mu = element.bg.multiplier or 1
            element.bg:SetVertexColor(t[1] * mu, t[2] * mu, t[3] * mu)
        end
    end
end

local function Update(self, event, unit)
    if unit and unit ~= self.unit then return end
    local element = self.Stagger

    if element.PreUpdate then element:PreUpdate() end

    local cur = UnitStagger("player") or 0
    local max = UnitHealthMax("player")

    element:SetMinMaxValues(0, max)
    element:SetValue(cur)

    if element.UpdateColor then
        element:UpdateColor(cur, max)
    end

    if element.PostUpdate then
        element:PostUpdate(cur, max)
    end
end

local function Path(self, ...)
    return (self.Stagger.Override or Update)(self, ...)
end

-- MoP Classic specialization check
local function IsBrewmaster()
    return (GetPrimaryTalentTree and GetPrimaryTalentTree() == SPEC_MONK_BREWMASTER)
end

local function Visibility(self, event, unit)
    if not IsBrewmaster() or UnitHasVehiclePlayerFrameUI("player") then
        if self.Stagger:IsShown() then
            self.Stagger:Hide()
            self:UnregisterEvent("UNIT_AURA", Path)
        end
    else
        if not self.Stagger:IsShown() then
            self.Stagger:Show()
            self:RegisterEvent("UNIT_AURA", Path)
        end
        return Path(self, event, unit)
    end
end

local function VisibilityPath(self, ...)
    return (self.Stagger.OverrideVisibility or Visibility)(self, ...)
end

local function ForceUpdate(element)
    return VisibilityPath(element.__owner, "ForceUpdate", element.__owner.unit)
end

local function Enable(self)
    local element = self.Stagger
    if element then
        element.__owner = self
        element.ForceUpdate = ForceUpdate

        self:RegisterEvent("UNIT_DISPLAYPOWER", VisibilityPath)
        self:RegisterEvent("PLAYER_TALENT_UPDATE", VisibilityPath, true)
        self:RegisterEvent("PLAYER_ENTERING_WORLD", VisibilityPath, true)

        if element:IsObjectType("StatusBar") and not element:GetStatusBarTexture() then
            element:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]])
        end

        if not element.UpdateColor then
            element.UpdateColor = UpdateColor
        end

        element:Hide()
        return true
    end
end

local function Disable(self)
    local element = self.Stagger
    if element then
        element:Hide()
        self:UnregisterEvent("UNIT_AURA", Path)
        self:UnregisterEvent("UNIT_DISPLAYPOWER", VisibilityPath)
        self:UnregisterEvent("PLAYER_TALENT_UPDATE", VisibilityPath)
        self:UnregisterEvent("PLAYER_ENTERING_WORLD", VisibilityPath)
    end
end

oUF:AddElement("Stagger", VisibilityPath, Enable, Disable)