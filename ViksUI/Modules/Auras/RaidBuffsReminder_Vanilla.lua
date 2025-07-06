local T, C, L = unpack(ViksUI)
if C.reminder.raid_buffs_enable ~= true then return end

----------------------------------------------------------------------------------------
--	Raid buffs on player(by Elv22)
----------------------------------------------------------------------------------------
-- Locals
local flaskBuffs = T.ReminderBuffs["Flask"]
local battleElixirBuffs = T.ReminderBuffs["BattleElixir"]
local guardianElixirBuffs = T.ReminderBuffs["GuardianElixir"]
local otherBuffs = T.ReminderBuffs["Other"]
local foodBuffs = T.ReminderBuffs["Food"]
local spell3Buffs = T.ReminderBuffs["Spell3Buff"]
local spell4Buffs = T.ReminderBuffs["Spell4Buff"]
local spell5Buffs = T.ReminderBuffs["Spell5Buff"]
local spell6Buffs = T.ReminderBuffs["Spell6Buff"]
local spell7Buffs = T.ReminderBuffs["Spell7Buff"]
local customBuffs = T.ReminderBuffs["Custom"]

local visible
local icons = {}
local UpdatePositions

local isPresent = {
	flask = false,
	battleElixir = false,
	guardianElixir = false,
	food = false,
	spell3 = false,
	spell4 = false,
	spell5 = false,
	spell6 = false,
	spell7 = false,
	custom = false,
}

-- Aura Checks
local function CheckVanillaElixir()
	local requireFlask, otherBuffsRequired = T.ReminderFlaskRequirements()
	local hasFlask, otherBuffsCount, meetsRequirements = false, 0, false

	FlaskFrame.t:SetTexture(0)

	if requireFlask then
		if #flaskBuffs > 0 then
			for i = 1, #flaskBuffs do
				local name, icon = unpack(flaskBuffs[i])
				if i == 1 then
					FlaskFrame.t:SetTexture(icon)
				end
				if T.CheckPlayerBuff(name) then
					FlaskFrame:SetAlpha(C.reminder.raid_buffs_alpha)
					hasFlask = true
					break
				end
			end
		end
	else
		hasFlask = true
	end

	if FlaskFrame.t:GetTexture() == "" then
		FlaskFrame.t:SetTexture(134821)
	end

	if not hasFlask then
		FlaskFrame:SetAlpha(1)
		isPresent.flask = false
		return
	end

	if otherBuffsRequired > 0 then
		if #otherBuffs > 0 then
			for i = 1, #otherBuffs do
				local name = unpack(otherBuffs[i])
				if T.CheckPlayerBuff(name) then
					otherBuffsCount = otherBuffsCount + 1
					if otherBuffsCount >= otherBuffsRequired then
						meetsRequirements = true
						break
					end
				end
			end
		end
	else
		meetsRequirements = true
	end

	if hasFlask and meetsRequirements then
		FlaskFrame:SetAlpha(C.reminder.raid_buffs_alpha)
		isPresent.flask = true
		return
	else
		FlaskFrame:SetAlpha(1)
		isPresent.flask = false
		return
	end
end

local function CheckElixir()
	if #battleElixirBuffs > 0 then
		for i = 1, #battleElixirBuffs do
			local name, icon = unpack(battleElixirBuffs[i])
			if T.CheckPlayerBuff(name) then
				FlaskFrame.t:SetTexture(icon)
				isPresent.battleElixir = true
				break
			else
				isPresent.battleElixir = false
			end
		end
	end

	if #guardianElixirBuffs > 0 then
		for i = 1, #guardianElixirBuffs do
			local name, icon = unpack(guardianElixirBuffs[i])
			if T.CheckPlayerBuff(name) then
				isPresent.guardianElixir = true
				if not isPresent.battleElixir then
					FlaskFrame.t:SetTexture(icon)
				end
				break
			else
				isPresent.guardianElixir = true
			end
		end
	end

	if FlaskFrame.t:GetTexture() == "" then
		FlaskFrame.t:SetTexture(134821)
	end

	if isPresent.guardianElixir == true and isPresent.battleElixir == true then
		FlaskFrame:SetAlpha(C.reminder.raid_buffs_alpha)
		isPresent.flask = true
		return
	else
		FlaskFrame:SetAlpha(1)
		isPresent.flask = false
		return
	end
end

local function CheckBuff(list, frame, n)
	if T.Vanilla and list == flaskBuffs then
		CheckVanillaElixir()
	else
		if list and #list > 0 then
			for i = 1, #list do
				local name, icon = unpack(list[i])
				if i == 1 then
					frame.t:SetTexture(icon)
				end
				if T.CheckPlayerBuff(name) then
					frame:SetAlpha(C.reminder.raid_buffs_alpha)
					isPresent[n] = true
					break
				elseif list == flaskBuffs then
					CheckElixir()
				else
					frame:SetAlpha(1)
					isPresent[n] = false
				end
			end
		end
	end
end

-- Main Script
local function OnAuraChange(_, event, unit)
	-- If We're a caster we may want to see different buffs
	if T.Role == "Caster" or T.Role == "Healer" then
		T.ReminderCasterBuffs()
	else
		T.ReminderPhysicalBuffs()
	end

	spell4Buffs = T.ReminderBuffs["Spell4Buff"]
	spell5Buffs = T.ReminderBuffs["Spell5Buff"]
	spell6Buffs = T.ReminderBuffs["Spell6Buff"]

	-- Start checking buffs to see if we can find a match from the list
	CheckBuff(flaskBuffs, FlaskFrame, "flask")

	CheckBuff(foodBuffs, FoodFrame, "food")
	CheckBuff(spell3Buffs, Spell3Frame, "spell3")
	CheckBuff(spell4Buffs, Spell4Frame, "spell4")
	CheckBuff(spell5Buffs, Spell5Frame, "spell5")
	if not T.Cata then
		CheckBuff(spell6Buffs, Spell6Frame, "spell6")
	end
	if not T.Wrath and not T.Cata then
		CheckBuff(spell7Buffs, Spell7Frame, "spell7")
	end

	if customBuffs and #customBuffs > 0 then
		CheckBuff(customBuffs, CustomFrame, "custom")
	else
		CustomFrame:Hide()
		isPresent.custom = true
	end

	UpdatePositions()
	local _, instanceType = IsInInstance()
	if (not IsInGroup() or instanceType ~= "raid") and C.reminder.raid_buffs_always == false then
		RaidBuffReminder:SetAlpha(0)
		visible = false
	elseif isPresent.flask == true and isPresent.food == true and isPresent.spell3 == true and isPresent.spell4 == true and isPresent.spell5 == true and (T.Cata or isPresent.spell6 == true) and (T.Wrath or T.Cata or T.Mists or isPresent.spell7 == true) and isPresent.custom == true then
		if not visible then
			RaidBuffReminder:SetAlpha(0)
			visible = false
		end
		if visible then
			UIFrameFadeOut(RaidBuffReminder, 0.5)
			visible = false
		end
	else
		if not visible then
			UIFrameFadeIn(RaidBuffReminder, 0.5)
			visible = true
		end
	end
end

-- Create Anchor
local RaidBuffsAnchor = CreateFrame("Frame", "RaidBuffsAnchor", UIParent)
RaidBuffsAnchor:SetWidth((C.reminder.raid_buffs_size * 6) + 15)
RaidBuffsAnchor:SetHeight(C.reminder.raid_buffs_size)
RaidBuffsAnchor:SetPoint(unpack(C.position.raid_buffs))

-- Create Main bar
local raidbuff_reminder = CreateFrame("Frame", "RaidBuffReminder", UIParent)
raidbuff_reminder:CreatePanel("Invisible", (C.reminder.raid_buffs_size * 6) + 15, C.reminder.raid_buffs_size + 4, "TOPLEFT", RaidBuffsAnchor, "TOPLEFT", 0, 4)
raidbuff_reminder:RegisterUnitEvent("UNIT_AURA", "player", "")
raidbuff_reminder:RegisterEvent("PLAYER_ENTERING_WORLD")
raidbuff_reminder:RegisterEvent("CHARACTER_POINTS_CHANGED")
raidbuff_reminder:RegisterEvent("ZONE_CHANGED_NEW_AREA")
raidbuff_reminder:SetScript("OnEvent", OnAuraChange)

local buffButtons = {
	"FlaskFrame",
	"FoodFrame",
	"Spell3Frame",
	"Spell4Frame",
	"Spell5Frame",
	"Spell6Frame",
	"Spell7Frame",
	"CustomFrame"
}

if T.Wrath or T.Cata or T.Mists then
	tremove(buffButtons, 7)
end
if T.Cata or T.Mists then
	tremove(buffButtons, 6)
end

local line = math.ceil(C.minimap.size / (C.reminder.raid_buffs_size + 2))

for i = 1, #buffButtons do
	local name = buffButtons[i]
	local button = CreateFrame("Frame", name, RaidBuffReminder)
	if i == 1 then
		button:CreatePanel("Default", C.reminder.raid_buffs_size, C.reminder.raid_buffs_size, "BOTTOMLEFT", RaidBuffReminder, "BOTTOMLEFT", 0, 0)
	elseif i == line then
		button:CreatePanel("Default", C.reminder.raid_buffs_size, C.reminder.raid_buffs_size, "BOTTOM", buffButtons[1], "TOP", 0, 3)
	else
		button:CreatePanel("Default", C.reminder.raid_buffs_size, C.reminder.raid_buffs_size, "LEFT", buffButtons[i-1], "RIGHT", 3, 0)
	end
	button:SetFrameLevel(RaidBuffReminder:GetFrameLevel() + 2)

	button.t = button:CreateTexture(name..".t", "OVERLAY")
	button.t:CropIcon()
end

function UpdatePositions()
	local first, previousBuff
	for i = 1, #icons do
		local buff = icons[i]
		buff:ClearAllPoints()
		if buff:GetAlpha() == C.reminder.raid_buffs_alpha then
			-- buff:SetPoint("TOP", UIParent, "TOP", 0, 900)
			line = line + 1
		else
			if not first then
				buff:SetPoint("BOTTOMLEFT", RaidBuffReminder, "BOTTOMLEFT", 0, 0)
				first = true
			else
				buff:SetPoint("LEFT", previousBuff, "RIGHT", 3, 0)
			end
			previousBuff = buff
			if i >= line then
				buff:SetAlpha(0)
			else
				buff:SetAlpha(1)
			end
		end
	end
end