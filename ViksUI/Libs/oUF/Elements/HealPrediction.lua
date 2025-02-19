local _, ns = ...
local oUF = ns.oUF

if(oUF:IsClassic()) then return end

local UnitGetTotalAbsorbs = UnitGetTotalAbsorbs
local UnitGetTotalHealAbsorbs = UnitGetTotalHealAbsorbs

if(oUF:IsClassic()) then
	UnitGetTotalAbsorbs = function()
		return 0
	end
	UnitGetTotalHealAbsorbs = function()
		return 0
	end
end

local function UpdateFillBar(frame, previousTexture, bar, amount, maxHealth, reverse)
	if amount == 0 then
		bar:Hide()
		return previousTexture
	end

	local totalWidth, totalHeight = frame.Health:GetSize()
	if frame.Health:GetOrientation() == "VERTICAL" then
		if reverse then
			bar:SetPoint("TOP", previousTexture, "TOP", 0, 0)
		else
			bar:SetPoint("BOTTOM", previousTexture, "TOP", 0, 0)
		end

		local barSize = (amount / maxHealth) * totalHeight
		bar:SetHeight(barSize)
	else
		if reverse then
			bar:SetPoint("TOPRIGHT", previousTexture, "TOPRIGHT", 0, 0)
			bar:SetPoint("BOTTOMRIGHT", previousTexture, "BOTTOMRIGHT", 0, 0)
		else
			bar:SetPoint("TOPLEFT", previousTexture, "TOPRIGHT", 0, 0)
			bar:SetPoint("BOTTOMLEFT", previousTexture, "BOTTOMRIGHT", 0, 0)
		end

		local barSize = (amount / maxHealth) * totalWidth
		bar:SetWidth(barSize)
	end
	bar:Show()

	return bar
end

local function Update(self, event, unit)
	if(self.unit ~= unit) then return end

	local element = self.HealthPrediction

	if(element.PreUpdate) then
		element:PreUpdate(unit)
	end

	local myIncomingHeal = UnitGetIncomingHeals(unit, 'player') or 0
	local allIncomingHeal = UnitGetIncomingHeals(unit) or 0
	local absorb = UnitGetTotalAbsorbs(unit) or 0
	local healAbsorb = UnitGetTotalHealAbsorbs(unit) or 0
	local otherIncomingHeal = 0
	local health, maxHealth = UnitHealth(unit), UnitHealthMax(unit)
	local overAbsorb = 0
	local overHealAbsorb = 0

	if healAbsorb > allIncomingHeal then
		healAbsorb = healAbsorb - allIncomingHeal
		allIncomingHeal = 0
		myIncomingHeal = 0
		absorb = 0

		if health + healAbsorb > maxHealth then
			overHealAbsorb = min(maxHealth, healAbsorb)
			healAbsorb = maxHealth - health
			overHealAbsorb = overHealAbsorb - healAbsorb
		end
	else
		allIncomingHeal = allIncomingHeal - healAbsorb
		healAbsorb = 0

		if health + allIncomingHeal > maxHealth then
			allIncomingHeal = maxHealth - health
		end

		if(allIncomingHeal < myIncomingHeal) then
			myIncomingHeal = allIncomingHeal
			allIncomingHeal = 0
		else
			allIncomingHeal = allIncomingHeal - myIncomingHeal
		end

		if health + myIncomingHeal + allIncomingHeal + absorb >= maxHealth then
			overAbsorb = min(maxHealth, absorb)
			absorb = max(0, maxHealth - (health + myIncomingHeal + allIncomingHeal))
			overAbsorb = overAbsorb - absorb
		end
	end

	local previousTexture = self.Health:GetStatusBarTexture()

	if element.healAbsorbBar then
		previousTexture = UpdateFillBar(self, previousTexture, element.healAbsorbBar, healAbsorb, maxHealth)
	end

	if element.myBar then
		previousTexture = UpdateFillBar(self, previousTexture, element.myBar, myIncomingHeal, maxHealth)
	end

	if element.otherBar then
		previousTexture = UpdateFillBar(self, previousTexture, element.otherBar, allIncomingHeal, maxHealth)
	end

	if element.absorbBar then
		previousTexture = UpdateFillBar(self, previousTexture, element.absorbBar, absorb, maxHealth)
	end

	if element.overAbsorb then
		previousTexture = UpdateFillBar(self, self.Health, element.overAbsorb, overAbsorb, maxHealth, true)
	end

	if element.overHealAbsorb then
		previousTexture = UpdateFillBar(self, self.Health, element.overHealAbsorb, overHealAbsorb, maxHealth, true)
	end

	if(element.PostUpdate) then
		return element:PostUpdate(unit, myIncomingHeal, otherIncomingHeal, absorb, healAbsorb)
	end
end

local function Path(self, ...)
	--[[ Override: HealthPrediction.Override(self, event, unit)
	Used to completely override the internal update function.
	* self  - the parent object
	* event - the event triggering the update (string)
	* unit  - the unit accompanying the event
	--]]
	return (self.HealthPrediction.Override or Update) (self, ...)
end

local function ForceUpdate(element)
	return Path(element.__owner, 'ForceUpdate', element.__owner.unit)
end

--[[ HealthPrediction:SetFrequentUpdates(state, isForced)
Used to toggle frequent updates.
* self     - the Health element
* state    - the desired state (boolean)
* isForced - forces the event update even if the state wasn't changed (boolean)
--]]
local function SetFrequentUpdates(element, state, isForced)
	if(element.frequentUpdates ~= state or isForced) then
		element.frequentUpdates = state
		if(state) then
			element.__owner:UnregisterEvent('UNIT_HEALTH', Path)
			element.__owner:RegisterEvent('UNIT_HEALTH_FREQUENT', Path)
		else
			element.__owner:UnregisterEvent('UNIT_HEALTH_FREQUENT', Path)
			element.__owner:RegisterEvent('UNIT_HEALTH', Path)
		end
	end
end

local function Enable(self)
	local element = self.HealthPrediction
	if(element) then
		element.__owner = self
		element.ForceUpdate = ForceUpdate
		element.SetFrequentUpdates = SetFrequentUpdates

		if(element.frequentUpdates and oUF:IsClassic()) then
			self:RegisterEvent('UNIT_HEALTH_FREQUENT', Path)
		else
			self:RegisterEvent('UNIT_HEALTH', Path)
		end

		self:RegisterEvent('UNIT_MAXHEALTH', Path)

		if element.myBar or element.otherBar then
			self:RegisterEvent('UNIT_HEAL_PREDICTION', Path)
		end

		if(oUF:IsMainline()) then
			if element.absorbBar then
				self:RegisterEvent('UNIT_ABSORB_AMOUNT_CHANGED', Path)
			end

			if element.healAbsorbBar then
				self:RegisterEvent('UNIT_HEAL_ABSORB_AMOUNT_CHANGED', Path)
			end
		end

		return true
	end
end

local function Disable(self)
	local element = self.HealthPrediction
	if(element) then
		if(element.myBar) then
			element.myBar:Hide()
		end

		if(element.otherBar) then
			element.otherBar:Hide()
		end

		if(element.absorbBar) then
			element.absorbBar:Hide()
		end

		if(element.healAbsorbBar) then
			element.healAbsorbBar:Hide()
		end

		self:UnregisterEvent('UNIT_HEALTH', Path)
		self:UnregisterEvent('UNIT_MAXHEALTH', Path)
		self:UnregisterEvent('UNIT_HEAL_PREDICTION', Path)
		if(oUF:IsClassic()) then
			self:UnregisterEvent('UNIT_HEALTH_FREQUENT', Path)
		else
			self:UnregisterEvent('UNIT_ABSORB_AMOUNT_CHANGED', Path)
			self:UnregisterEvent('UNIT_HEAL_ABSORB_AMOUNT_CHANGED', Path)
		end
	end
end

oUF:AddElement('HealthPrediction', Path, Enable, Disable)