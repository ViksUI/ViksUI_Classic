local T, C, L = unpack(ViksUI)
if C.unitframe.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Based on oUF_DebuffHighlight(by Ammo)
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

local CanDispel = {
	DRUID = {Magic = false, Curse = true, Poison = true},
	EVOKER = {Magic = false, Curse = true, Poison = true, Disease = true},
	MAGE = {Magic = false, Curse = true},
	MONK = {Magic = false, Poison = true, Disease = true},
	PALADIN = {Magic = false, Poison = true, Disease = true},
	PRIEST = {Magic = false, Disease = true},
	SHAMAN = {Magic = false, Curse = true, Poison = false, Disease = false},
	WARLOCK = {Magic = false}
}

local dispellist = CanDispel[T.class] or {}
local origColors = {}
local origBorderColors = {}

local function GetDebuffType(unit, filter)
	if not UnitCanAssist("player", unit) then return nil end
	local i = 1
	while true do
		local _, texture, _, debufftype = UnitAura(unit, i, "HARMFUL")
		if not texture then break end
		if debufftype and not filter or (filter and dispellist[debufftype]) then
			return debufftype, texture
		end
		i = i + 1
	end
end

local function CheckSpec()
	if T.Classic then
		if T.class == "MAGE" and T.SoD then
			if IsSpellKnown(412113) then
				dispellist.Magic = true
			end
		elseif T.class == "PALADIN" then
			dispellist.Magic = true
		elseif T.class == "PRIEST" then
			dispellist.Magic = true
		elseif T.class == "SHAMAN" then
			dispellist.Curse = false
			dispellist.Poison = true
			dispellist.Disease = true
		elseif T.class == "WARLOCK" then
			dispellist.Magic = true
		end
	else
		local spec = GetSpecialization()

		if T.class == "DRUID" then
			if spec == 4 then
				dispellist.Magic = true
			else
				dispellist.Magic = false
			end
		elseif T.class == "MONK" then
			if spec == 2 then
				dispellist.Magic = true
			else
				dispellist.Magic = false
			end
		elseif T.class == "PALADIN" then
			if spec == 1 then
				dispellist.Magic = true
			else
				dispellist.Magic = false
			end
		elseif T.class == "PRIEST" then
			if spec == 3 then
				dispellist.Magic = false
			else
				dispellist.Magic = true
			end
		elseif T.class == "SHAMAN" then
			if spec == 3 then
				dispellist.Magic = true
			else
				dispellist.Magic = false
			end
		end
	end
end

local function Update(object, _, unit)
	if object.unit ~= unit then return end
	local debuffType, texture = GetDebuffType(unit, object.DebuffHighlightFilter)
	if debuffType then
		local color = DebuffTypeColor[debuffType]
		if object.DebuffHighlightBackdrop or object.DebuffHighlightBackdropBorder then
			if object.DebuffHighlightBackdrop then
				object:SetBackdropColor(color.r, color.g, color.b, object.DebuffHighlightAlpha or 1)
			end
			if object.DebuffHighlightBackdropBorder then
				object:SetBackdropBorderColor(color.r, color.g, color.b, object.DebuffHighlightAlpha or 1)
			end
		elseif object.DebuffHighlightUseTexture then
			object.DebuffHighlight:SetTexture(texture)
		else
			object.DebuffHighlight:SetVertexColor(color.r, color.g, color.b, object.DebuffHighlightAlpha or 0.5)
		end
	else
		if object.DebuffHighlightBackdrop or object.DebuffHighlightBackdropBorder then
			local color
			if object.DebuffHighlightBackdrop then
				color = origColors[object]
				object:SetBackdropColor(color.r, color.g, color.b, color.a)
			end
			if object.DebuffHighlightBackdropBorder then
				color = origBorderColors[object]
				object:SetBackdropBorderColor(color.r, color.g, color.b, color.a)
			end
		elseif object.DebuffHighlightUseTexture then
			object.DebuffHighlight:SetTexture(0)
		else
			local color = origColors[object]
			object.DebuffHighlight:SetVertexColor(color.r, color.g, color.b, color.a)
		end
	end
end

local function Enable(object)
	-- If we're not highlighting this unit return
	if not object.DebuffHighlightBackdrop and not object.DebuffHighlightBackdropBorder and not object.DebuffHighlight then
		return
	end
	-- If we're filtering highlights and we're not of the dispelling type, return
	if object.DebuffHighlightFilter and not CanDispel[T.class] then
		return
	end

	-- Make sure aura scanning is active for this object
	object:RegisterEvent("UNIT_AURA", Update)
	if oUF:IsVanilla() or oUF:IsTBC() then
		object:RegisterEvent("CHARACTER_POINTS_CHANGED", CheckSpec, true)
	else
		object:RegisterEvent("PLAYER_TALENT_UPDATE", CheckSpec, true)
	end
	CheckSpec()

	if object.DebuffHighlightBackdrop or object.DebuffHighlightBackdropBorder then
		local r, g, b, a = object:GetBackdropColor()
		origColors[object] = {r = r, g = g, b = b, a = a}
		r, g, b, a = object:GetBackdropBorderColor()
		origBorderColors[object] = {r = r, g = g, b = b, a = a}
	elseif not object.DebuffHighlightUseTexture then
		local r, g, b, a = object.DebuffHighlight:GetVertexColor()
		origColors[object] = {r = r, g = g, b = b, a = a}
	end

	return true
end

local function Disable(object)
	if object.DebuffHighlightBackdrop or object.DebuffHighlightBackdropBorder or object.DebuffHighlight then
		object:UnregisterEvent("UNIT_AURA", Update)
		if oUF:IsVanilla() or oUF:IsTBC() then
			object:UnregisterEvent("CHARACTER_POINTS_CHANGED", CheckSpec)
		else
			object:UnregisterEvent("PLAYER_TALENT_UPDATE", CheckSpec)
		end
	end
end

oUF:AddElement("DebuffHighlight", Update, Enable, Disable)

for _, frame in ipairs(oUF.objects) do Enable(frame) end