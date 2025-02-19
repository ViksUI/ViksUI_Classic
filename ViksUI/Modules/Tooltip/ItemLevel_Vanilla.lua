local T, C, L = unpack(ViksUI)
if C.tooltip.enable ~= true or C.tooltip.average_lvl ~= true then return end

----------------------------------------------------------------------------------------
--	Equipped average item level(Cloudy Unit Info by Cloudyfa)
----------------------------------------------------------------------------------------
--- Variables
local currentUNIT, currentGUID
local GearDB, ItemDB = {}, {}

local prefixColor = "|cffF9D700"
local detailColor = "|cffffffff"

local gearPrefix = STAT_AVERAGE_ITEM_LEVEL..": "

--- Create Frame
local f = CreateFrame("Frame", "CloudyUnitInfo")
f:RegisterEvent("UNIT_INVENTORY_CHANGED")

--- Set Unit Info
local function SetUnitInfo(gear)
	if not gear then return end

	local _, unit = GameTooltip:GetUnit()
	if (not unit) or (UnitGUID(unit) ~= currentGUID) then return end

	local gearLine
	for i = 2, GameTooltip:NumLines() do
		local line = _G["GameTooltipTextLeft" .. i]
		local text = line:GetText()

		if text and strfind(text, gearPrefix) then
			gearLine = line
		end
	end

	if gear then
		gear = prefixColor..gearPrefix..detailColor..gear

		if gearLine then
			gearLine:SetText(gear)
		else
			GameTooltip:AddLine(gear)
		end
	end

	GameTooltip:Show()
end

--- PVP Item Detect
local function IsPVPItem(link)
	local itemStats = GetItemStats(link)
	for stat in pairs(itemStats) do
		if stat == "ITEM_MOD_RESILIENCE_RATING_SHORT" or stat == "ITEM_MOD_PVP_POWER_SHORT" then
			return true
		end
	end

	return false
end

-- Tooltip and scanning by Phanx @ http://www.wowinterface.com/forums/showthread.php?p=271406
local S_ITEM_LEVEL = "^" .. gsub(ITEM_LEVEL, "%%d", "(%%d+)")

local scantip = CreateFrame("GameTooltip", "iLvlScanningTooltip", nil, "GameTooltipTemplate")
scantip:SetOwner(UIParent, "ANCHOR_NONE")

local function _getRealItemLevel(slotId, unit, link, forced)
	if (not forced) and ItemDB[link] then return ItemDB[link] end

	local realItemLevel
	local hasItem = scantip:SetInventoryItem(unit, slotId)
	if not hasItem then return nil end -- With this we don't get ilvl for offhand if we equip 2h weapon

	for i = 2, scantip:NumLines() do -- Line 1 is always the name so you can skip it.
		local text = _G["iLvlScanningTooltipTextLeft"..i]:GetText()
		if text and text ~= "" then
			realItemLevel = realItemLevel or strmatch(text, S_ITEM_LEVEL)

			if realItemLevel then
				ItemDB[link] = tonumber(realItemLevel)
				return tonumber(realItemLevel)
			end
		end
	end

	return realItemLevel
end

--- Unit Gear Info
local function UnitGear(unit)
	if (not unit) or (UnitGUID(unit) ~= currentGUID) then return end

	local class = select(2, UnitClass(unit))

	local ilvl, boa, pvp = 0, 0, 0
	local total, delay = 0, nil
	local wlvl, wslot = 0, 0

	for i = 1, 17 do
		if i ~= 4 then
			local id = GetInventoryItemTexture(unit, i)

			if id then
				local itemLink = GetInventoryItemLink(unit, i)

				if not itemLink then
					delay = true
				else
					local _, _, quality, level, _, _, _, _, slot = GetItemInfo(itemLink)

					if (not quality) or (not level) then
						delay = true
					else
						if (quality == 6) and (i == 16 or i == 17) then
							local relics = {select(4, strsplit(":", itemLink))}
							for i = 1, 3 do
								local relicID = relics[i] ~= "" and relics[i]
								local relicLink = select(2, GetItemGem(itemLink, i))
								if relicID and not relicLink then
									delay = true
									break
								end
							end
							level = _getRealItemLevel(i, unit, itemLink, true) or level
							if level >= 900 and ScannedGUID ~= UnitGUID('player') then
								level = level + 15
							end
						elseif quality == 7 then
							level = _getRealItemLevel(i, unit, itemLink) or level
							boa = boa + 1
						else
							level = _getRealItemLevel(i, unit, itemLink) or level
							if IsPVPItem(itemLink) then
								pvp = pvp + 1
							end
						end

						if i == 16 then
							if (quality == 6) then
								wlvl = level
								wslot = slot
							end
							if (slot == "INVTYPE_2HWEAPON") or (slot == "INVTYPE_RANGED") or ((slot == "INVTYPE_RANGEDRIGHT") and (class == "HUNTER")) then
								level = level * 2
							end
						end

						if i == 17 then
							if quality == 6 and wlvl then
								if level > wlvl then
									level = level * 2 - wlvl
								else
									level = wlvl
								end
							end
						end

						total = total + level
					end
				end
			end
		end
	end

	if not delay then
		if unit == "player" and GetAverageItemLevel() > 0 then
			_, ilvl = GetAverageItemLevel()
		else
			ilvl = total / 16
		end

		if ilvl > 0 then ilvl = string.format("%.1f", ilvl) end
		if boa > 0 then ilvl = ilvl.."  |cffe6cc80"..boa.." "..HEIRLOOMS end
		if pvp > 0 then ilvl = ilvl.."  |cffa335ee"..pvp.." "..PVP end
	else
		ilvl = nil
	end

	return ilvl
end

--- Scan Current Unit
local function ScanUnit(unitID)
    if not CanInspect(unitID) then return end
    ScannedGUID = UnitGUID(unitID)
    wipe(SlotCache)
    wipe(ItemCache)
    local numEquipped = 0
    for _, slot in pairs(InventorySlots) do
        if GetInventoryItemTexture(unitID, slot) then
            SlotCache[slot] = false
            numEquipped = numEquipped + 1
        end
    end

    if numEquipped > 0 then
        for slot in pairs(SlotCache) do
            TestTips[slot].itemLink = GetInventoryItemLink(unitID, slot)
            TestTips[slot]:SetOwner(WorldFrame, "ANCHOR_NONE")
            TestTips[slot]:SetInventoryItem(unitID, slot)
        end
    else
        local guid = ScannedGUID
        if not GuidCache[guid] then GuidCache[guid] = {} end
        GuidCache[guid].ilevel = 0
        GuidCache[guid].weaponLevel = 0
        GuidCache[guid].timestamp = GetTime()
        E("ItemScanComplete", guid, GuidCache[guid])
    end
end

--- Handle Events
f:SetScript("OnEvent", function(self, event, ...)
	if event == "UNIT_INVENTORY_CHANGED" then
		local unit = ...
		if UnitGUID(unit) == currentGUID then
			ScanUnit(unit, true)
		end
	elseif event == "INSPECT_READY" then
		local guid = ...
		if guid == currentGUID then
			local gear = UnitGear(currentUNIT)
			GearDB[guid] = gear

			if (not gear) then
				ScanUnit(currentUNIT, true)
			else
				SetUnitInfo(gear)
			end
		end
		self:UnregisterEvent("INSPECT_READY")
	end
end)

f:SetScript("OnUpdate", function(self, elapsed)
	self.nextUpdate = (self.nextUpdate or 0) - elapsed
	if (self.nextUpdate > 0) then return end

	self:Hide()
	ClearInspectPlayer()

	if currentUNIT and (UnitGUID(currentUNIT) == currentGUID) then
		self.lastUpdate = GetTime()
		self:RegisterEvent("INSPECT_READY")
		NotifyInspect(currentUNIT)
	end
end)

GameTooltip:HookScript("OnTooltipSetUnit", function(self)
	if C.tooltip.show_shift and not IsShiftKeyDown() then return end

	local _, unit = self:GetUnit()

	if (not unit) or (not CanInspect(unit)) then return end
	if (UnitLevel(unit) > 0) and (UnitLevel(unit) < 10) then return end

	currentUNIT, currentGUID = unit, UnitGUID(unit)
	ScanUnit(unit)
end)