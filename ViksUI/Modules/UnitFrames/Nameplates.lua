local T, C, L = unpack(ViksUI)
if C.nameplate.enable ~= true then return end

----------------------------------------------------------------------------------------
--	oUF nameplates
----------------------------------------------------------------------------------------
local _, ns = ...
local oUF = ns.oUF

local frame = CreateFrame("Frame")
frame:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
if C.nameplate.combat == true then
	frame:RegisterEvent("PLAYER_REGEN_ENABLED")
	frame:RegisterEvent("PLAYER_REGEN_DISABLED")
	frame:RegisterEvent("PLAYER_ENTERING_WORLD")

	function frame:PLAYER_REGEN_ENABLED()
		SetCVar("nameplateShowEnemies", 0)
	end

	function frame:PLAYER_REGEN_DISABLED()
		SetCVar("nameplateShowEnemies", 1)
	end

	function frame:PLAYER_ENTERING_WORLD()
		if InCombatLockdown() then
			SetCVar("nameplateShowEnemies", 1)
		else
			SetCVar("nameplateShowEnemies", 0)
		end
	end
end

frame:RegisterEvent("PLAYER_LOGIN")
function frame:PLAYER_LOGIN()
	if C.nameplate.enhance_threat == true then
		SetCVar("threatWarning", 3)
	end
	SetCVar("nameplateGlobalScale", 1)
	SetCVar("namePlateMinScale", 1)
	SetCVar("namePlateMaxScale", 1)
	SetCVar("nameplateLargerScale", 1)
	SetCVar("nameplateSelectedScale", 1)
	SetCVar("nameplateMinAlpha", 1)
	SetCVar("nameplateMaxAlpha", 1)
	SetCVar("nameplateSelectedAlpha", 1)
	SetCVar("nameplateNotSelectedAlpha", 1)
	SetCVar("nameplateLargeTopInset", 0.08)

	SetCVar("nameplateOtherTopInset", C.nameplate.clamp and 0.08 or -1)
	SetCVar("nameplateOtherBottomInset", C.nameplate.clamp and 0.1 or -1)
	SetCVar("clampTargetNameplateToScreen", C.nameplate.clamp and "1" or "0")

	SetCVar("nameplateMaxDistance", C.nameplate.distance or 41)
	SetCVar("nameplatePlayerMaxDistance", 60)

	if C.nameplate.only_name then
		SetCVar("nameplateShowOnlyNames", 1)
	end

	local function changeFont(self, size)
		local mult = size or 1
		self:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * mult * T.noscalemult, C.font.nameplates_font_style)
		self:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
	end
	changeFont(SystemFont_NamePlateFixed)
	changeFont(SystemFont_LargeNamePlateFixed, 2)
end

local healList, exClass, healerSpecs = {}, {}, {}

exClass.DEATHKNIGHT = true
exClass.DEMONHUNTER = true
exClass.HUNTER = true
exClass.MAGE = true
exClass.ROGUE = true
exClass.WARLOCK = true
exClass.WARRIOR = true
if C.nameplate.healer_icon == true then
	local t = CreateFrame("Frame")
	t.factions = {
		["Horde"] = 1,
		["Alliance"] = 0,
	}
	local healerSpecIDs = {
		105,	-- Druid Restoration
		1468,	-- Evoker Preservation
		270,	-- Monk Mistweaver
		65,		-- Paladin Holy
		256,	-- Priest Discipline
		257,	-- Priest Holy
		264,	-- Shaman Restoration
	}
	local healerClassTokens = {
		["DRUID"] = true,
		["PALADIN"] = true,
		["PRIEST"] = true,
		["SHAMAN"] = true,
	}
	if T.Mainline then
		for _, specID in pairs(healerSpecIDs) do
			local _, name = GetSpecializationInfoByID(specID)
			if name and not healerSpecs[name] then
				healerSpecs[name] = true
			end
		end
	end

	local lastCheck = 20
	local function CheckHealers(_, elapsed)
		lastCheck = lastCheck + elapsed
		if lastCheck > 25 then
			lastCheck = 0
			healList = {}
			for i = 1, GetNumBattlefieldScores() do
				if T.Classic then
					local name, _, _, _, _, faction, _, _, _, classToken, damageDone, healingDone = GetBattlefieldScore(i)

					if name and healerClassTokens[classToken] and (healingDone > damageDone * 1.2) and t.factions[UnitFactionGroup("player")] == faction then
						name = name:match("(.+)%-.+") or name
						healList[name] = true
					end
				else
					local name, _, _, _, _, faction, _, _, _, _, _, _, _, _, _, talentSpec = GetBattlefieldScore(i)

					if name and healerSpecs[talentSpec] and t.factions[UnitFactionGroup("player")] == faction then
						name = name:match("(.+)%-.+") or name
						healList[name] = talentSpec
					end
				end
			end
		end
	end

	local function CheckArenaHealers(_, elapsed)
		if T.Mainline then
			lastCheck = lastCheck + elapsed
			if lastCheck > 10 then
				lastCheck = 0
				healList = {}
				for i = 1, 5 do
					local specID = GetArenaOpponentSpec(i)
					if specID and specID > 0 then
						local name = UnitName(format("arena%d", i))
						local _, talentSpec = GetSpecializationInfoByID(specID)
						if name and healerSpecs[talentSpec] then
							healList[name] = talentSpec
							local nameplate = C_NamePlate.GetNamePlateForUnit(format("arena%d", i))
							if nameplate then
								nameplate.unitFrame:UpdateAllElements("UNIT_NAME_UPDATE")
							end
						end
					end
				end
			end
		end
	end

	local function CheckLoc(_, event)
		if event == "PLAYER_ENTERING_WORLD" then
			local _, instanceType = IsInInstance()
			if instanceType == "pvp" then
				t:SetScript("OnUpdate", CheckHealers)
			elseif instanceType == "arena" then
				t:SetScript("OnUpdate", CheckArenaHealers)
			else
				healList = {}
				t:SetScript("OnUpdate", nil)
			end
		end
	end

	t:RegisterEvent("PLAYER_ENTERING_WORLD")
	t:SetScript("OnEvent", CheckLoc)
end

local totemData = {}
if T.Vanilla or T.TBC then
	totemData = {
		-- Earth
		[GetSpellInfo(2484)]   = 136102,	-- Earthbind Totem
		[GetSpellInfo(5730)]   = 136097,	-- Stoneclaw Totem
		[GetSpellInfo(8071)]   = 136098,	-- Stoneskin Totem
		[GetSpellInfo(8075)]   = 136023,	-- Strength of Earth Totem
		[GetSpellInfo(8143)]   = 136108,	-- Tremor Totem
		-- Fire
		[GetSpellInfo(1535)]   = 135824,	-- Fire Nova Totem
		[GetSpellInfo(3599)]   = 135825,	-- Searing Totem
		[GetSpellInfo(8181)]   = 135866,	-- Frost Resistance Totem
		[GetSpellInfo(8190)]   = 135826,	-- Magma Totem
		[GetSpellInfo(8227)]   = 136040,	-- Flametongue Totem
		-- Water
		[GetSpellInfo(5394)]   = 135127,	-- Healing Stream Totem
		[GetSpellInfo(5675)]   = 136053,	-- Mana Spring Totem
		[GetSpellInfo(8166)]   = 136070,	-- Poison Cleansing Totem
		[GetSpellInfo(8170)]   = 136019,	-- Disease Cleansing Totem
		[GetSpellInfo(8184)]   = 135832,	-- Fire Resistance Totem
		[GetSpellInfo(16190)]  = 135861,	-- Mana Tide Totem
		-- Air
		[GetSpellInfo(6495)]   = 136082,	-- Sentry Totem
		[GetSpellInfo(8177)]   = 136039,	-- Grounding Totem
		[GetSpellInfo(8512)]   = 136114,	-- Windfury Totem
		[GetSpellInfo(8835)]   = 136046,	-- Grace of Air Totem
		[GetSpellInfo(10595)]  = 136061,	-- Nature Resistance Totem
		[GetSpellInfo(15107)]  = 136022,	-- Windwall Totem
		[GetSpellInfo(25908)]  = 136013,	-- Tranquil Air Totem
	}

	if T.TBC then
		totemData[GetSpellInfo(2062)] = 136024 -- Earth Elemental Totem
		totemData[GetSpellInfo(2894)] = 135790 -- Fire Elemental Totem
		totemData[GetSpellInfo(3738)] = 136092 -- Wrath of Air Totem
	end
elseif T.Wrath then
	totemData = {
		-- Earth
		[GetSpellInfo(2062)]   = 136024,	-- Earth Elemental Totem
		[GetSpellInfo(2484)]   = 136102,	-- Earthbind Totem
		[GetSpellInfo(5730)]   = 136097,	-- Stoneclaw Totem
		[GetSpellInfo(8071)]   = 136098,	-- Stoneskin Totem
		[GetSpellInfo(8075)]   = 136023,	-- Strength of Earth Totem
		[GetSpellInfo(8143)]   = 136108,	-- Tremor Totem
		-- Fire
		[GetSpellInfo(2894)]   = 135790,	-- Fire Elemental Totem
		[GetSpellInfo(1535)]   = 135824,	-- Fire Nova Totem
		[GetSpellInfo(3599)]   = 135825,	-- Searing Totem
		[GetSpellInfo(8181)]   = 135866,	-- Frost Resistance Totem
		[GetSpellInfo(8190)]   = 135826,	-- Magma Totem
		[GetSpellInfo(8227)]   = 136040,	-- Flametongue Totem
		-- Water
		[GetSpellInfo(5394)]   = 135127,	-- Healing Stream Totem
		[GetSpellInfo(5675)]   = 136053,	-- Mana Spring Totem
		[GetSpellInfo(8170)]   = 136019,	-- Cleansing Totem
		[GetSpellInfo(8184)]   = 135832,	-- Fire Resistance Totem
		[GetSpellInfo(16190)]  = 135861,	-- Mana Tide Totem
		-- Air
		[GetSpellInfo(3738)]   = 136092,	-- Wrath of Air Totem
		[GetSpellInfo(6495)]   = 136082,	-- Sentry Totem
		[GetSpellInfo(8177)]   = 136039,	-- Grounding Totem
		[GetSpellInfo(8512)]   = 136114,	-- Windfury Totem
		[GetSpellInfo(10595)]  = 136061,	-- Nature Resistance Totem
	}
elseif T.Cata then
	totemData = {
		-- Earth
		[GetSpellInfo(2062)]   = 136024,	-- Earth Elemental Totem
		[GetSpellInfo(2484)]   = 136102,	-- Earthbind Totem
		[GetSpellInfo(5730)]   = 136097,	-- Stoneclaw Totem
		[GetSpellInfo(8071)]   = 136098,	-- Stoneskin Totem
		[GetSpellInfo(8075)]   = 136023,	-- Strength of Earth Totem
		[GetSpellInfo(8143)]   = 136108,	-- Tremor Totem
		-- Fire
		[GetSpellInfo(2894)]   = 135790,	-- Fire Elemental Totem
		[GetSpellInfo(3599)]   = 135825,	-- Searing Totem
		[GetSpellInfo(8190)]   = 135826,	-- Magma Totem
		[GetSpellInfo(8227)]   = 136040,	-- Flametongue Totem
		-- Water
		[GetSpellInfo(5394)]   = 135127,	-- Healing Stream Totem
		[GetSpellInfo(5675)]   = 136053,	-- Mana Spring Totem
		[GetSpellInfo(8184)]   = 135832,	-- Elemental Resistance Totem
		[GetSpellInfo(16190)]  = 135861,	-- Mana Tide Totem
		-- Air
		[GetSpellInfo(3738)]   = 136092,	-- Wrath of Air Totem
		[GetSpellInfo(8177)]   = 136039,	-- Grounding Totem
		[GetSpellInfo(8512)]   = 136114,	-- Windfury Totem
		[GetSpellInfo(87718)]  = 136013,	-- Totem of Tranquil Mind
		[GetSpellInfo(98008)]  = 237586,	-- Spirit Link Totem
	}
	elseif T.Mists then
	totemData = {
		-- Earth
		[GetSpellInfo(2062)]   = 136024,	-- Earth Elemental Totem
		[GetSpellInfo(2484)]   = 136102,	-- Earthbind Totem
		[GetSpellInfo(8143)]   = 136108,	-- Tremor Totem
		-- Fire
		[GetSpellInfo(2894)]   = 135790,	-- Fire Elemental Totem
		[GetSpellInfo(3599)]   = 135825,	-- Searing Totem
		[GetSpellInfo(8190)]   = 135826,	-- Magma Totem
		-- Water
		[GetSpellInfo(5394)]   = 135127,	-- Healing Stream Totem
		[GetSpellInfo(16190)]  = 135861,	-- Mana Tide Totem
		-- Air
		[GetSpellInfo(8177)]   = 136039,	-- Grounding Totem
											-- Stormlash Totem
											-- Capacitor Totem

	}
else
	totemData = {
		[GetSpellInfo(192058)] = 136013,	-- Capacitor Totem
		[GetSpellInfo(98008)]  = 237586,	-- Spirit Link Totem
		[GetSpellInfo(192077)] = 538576,	-- Wind Rush Totem
		[GetSpellInfo(204331)] = 511726,	-- Counterstrike Totem
		[GetSpellInfo(204332)] = 136114,	-- Windfury Totem
		[GetSpellInfo(204336)] = 136039,	-- Grounding Totem
		[GetSpellInfo(157153)] = 971076,	-- Cloudburst Totem
		[GetSpellInfo(5394)]   = 135127,	-- Healing Stream Totem
		[GetSpellInfo(108280)] = 538569,	-- Healing Tide Totem
		[GetSpellInfo(207399)] = 136080,	-- Ancestral Protection Totem
		[GetSpellInfo(198838)] = 136098,	-- Earthen Wall Totem
		[GetSpellInfo(51485)]  = 136100,	-- Earthgrab Totem
		[GetSpellInfo(196932)] = 136232,	-- Voodoo Totem
		[GetSpellInfo(192222)] = 971079,	-- Liquid Magma Totem
		[GetSpellInfo(204330)] = 135829,	-- Skyfury Totem
	}
end

local function CreateBorderFrame(frame, point)
	if point == nil then point = frame end
	if point.backdrop then return end

	frame.backdrop = frame:CreateTexture(nil, "BORDER")
	frame.backdrop:SetDrawLayer("BORDER", -8)
	frame.backdrop:SetPoint("TOPLEFT", point, "TOPLEFT", -T.noscalemult * 3, T.noscalemult * 3)
	frame.backdrop:SetPoint("BOTTOMRIGHT", point, "BOTTOMRIGHT", T.noscalemult * 3, -T.noscalemult * 3)
	frame.backdrop:SetColorTexture(unpack(C.media.backdrop_color))

	frame.bordertop = frame:CreateTexture(nil, "BORDER")
	frame.bordertop:SetPoint("TOPLEFT", point, "TOPLEFT", -T.noscalemult * 2, T.noscalemult * 2)
	frame.bordertop:SetPoint("TOPRIGHT", point, "TOPRIGHT", T.noscalemult * 2, T.noscalemult * 2)
	frame.bordertop:SetHeight(T.noscalemult)
	frame.bordertop:SetColorTexture(unpack(C.media.border_color))
	frame.bordertop:SetDrawLayer("BORDER", -7)

	frame.borderbottom = frame:CreateTexture(nil, "BORDER")
	frame.borderbottom:SetPoint("BOTTOMLEFT", point, "BOTTOMLEFT", -T.noscalemult * 2, -T.noscalemult * 2)
	frame.borderbottom:SetPoint("BOTTOMRIGHT", point, "BOTTOMRIGHT", T.noscalemult * 2, -T.noscalemult * 2)
	frame.borderbottom:SetHeight(T.noscalemult)
	frame.borderbottom:SetColorTexture(unpack(C.media.border_color))
	frame.borderbottom:SetDrawLayer("BORDER", -7)

	frame.borderleft = frame:CreateTexture(nil, "BORDER")
	frame.borderleft:SetPoint("TOPLEFT", point, "TOPLEFT", -T.noscalemult * 2, T.noscalemult * 2)
	frame.borderleft:SetPoint("BOTTOMLEFT", point, "BOTTOMLEFT", T.noscalemult * 2, -T.noscalemult * 2)
	frame.borderleft:SetWidth(T.noscalemult)
	frame.borderleft:SetColorTexture(unpack(C.media.border_color))
	frame.borderleft:SetDrawLayer("BORDER", -7)

	frame.borderright = frame:CreateTexture(nil, "BORDER")
	frame.borderright:SetPoint("TOPRIGHT", point, "TOPRIGHT", T.noscalemult * 2, T.noscalemult * 2)
	frame.borderright:SetPoint("BOTTOMRIGHT", point, "BOTTOMRIGHT", -T.noscalemult * 2, -T.noscalemult * 2)
	frame.borderright:SetWidth(T.noscalemult)
	frame.borderright:SetColorTexture(unpack(C.media.border_color))
	frame.borderright:SetDrawLayer("BORDER", -7)
end

local function SetColorBorder(frame, r, g, b)
	frame.bordertop:SetColorTexture(r, g, b)
	frame.borderbottom:SetColorTexture(r, g, b)
	frame.borderleft:SetColorTexture(r, g, b)
	frame.borderright:SetColorTexture(r, g, b)
end

-- Auras functions
-- TODO: Revisit this when we eventually consolidate oUF's Auras element between Classic and Mainline
local AurasCustomFilter
if T.Classic then
	AurasCustomFilter = function(_, unit, button, name, _, _, _, _, _, _, isStealable, nameplateShowSelf, _, _, _, _, nameplateShowAll)
		local allow = false

		if not UnitIsFriend("player", unit) then
			if button.isHarmful then
				if button.isPlayer or button.caster == "pet" then
					if ((nameplateShowAll or nameplateShowSelf) and not T.DebuffBlackList[name]) then
						allow = true
					elseif T.DebuffWhiteList[name] then
						allow = true
					end
					if C.nameplate.track_buffs then
						SetColorBorder(button, unpack(C.media.border_color))
					end
				end
			else
				if T.BuffWhiteList[name] then
					allow = true
					SetColorBorder(button, 0, 0.5, 0)
				elseif isStealable then
					allow = true
					SetColorBorder(button, 1, 0.85, 0)
				end
			end
		end

		return allow
	end
else
	AurasCustomFilter = function(element, unit, data)
		local allow = false

		if not UnitIsFriend("player", unit) then
			if data.isHarmful then
				if C.nameplate.track_debuffs and data.isPlayerAura or data.sourceUnit == "pet" then
					if ((data.nameplateShowAll or data.nameplateShowPersonal) and not T.DebuffBlackList[data.name]) then
						allow = true
					elseif T.DebuffWhiteList[data.name] then
						allow = true
					end
				end
			else
				if T.BuffWhiteList[data.name] then
					allow = true
				elseif data.isStealable then
					allow = true
				end
			end
		end

		return allow
	end
end

local Mult = 1
if T.screenHeight > 1200 then
	Mult = T.mult
end

local auraFontHeight = (T.Classic and T.HiDPI) and (C.font.auras_font_size * T.noscalemult * (2/3) / Mult) or (C.font.auras_font_size * T.noscalemult / Mult)

local AurasPostCreateButton = function(element, button)
	CreateBorderFrame(button)

	button.remaining = T.SetFontString(button, C.font.auras_font, auraFontHeight, C.font.auras_font_style)
	button.remaining:SetShadowOffset(C.font.auras_font_shadow and 1 or 0, C.font.auras_font_shadow and -1 or 0)
	button.remaining:SetPoint("CENTER", button, "CENTER", T.Classic and 0 or 1, 0)
	button.remaining:SetJustifyH("CENTER")

	button.Cooldown.noCooldownCount = true

	button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	button.Count:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", T.Classic and 2 or 1, T.Classic and -6 or 0)
	button.Count:SetJustifyH("RIGHT")
	button.Count:SetFont(C.font.auras_font, auraFontHeight, C.font.auras_font_style)
	button.Count:SetShadowOffset(C.font.auras_font_shadow and 1 or 0, C.font.auras_font_shadow and -1 or 0)

	if C.aura.show_spiral == true then
		element.disableCooldown = false
		button.Cooldown:SetReverse(true)
		button.parent = CreateFrame("Frame", nil, button)
		button.parent:SetFrameLevel(button.Cooldown:GetFrameLevel() + 1)
		button.Count:SetParent(button.parent)
		button.remaining:SetParent(button.parent)
	else
		element.disableCooldown = true
	end
end

-- TODO: Revisit this when we eventually consolidate oUF's Auras element between Classic and Mainline
local AurasPostUpdateButton
if T.Classic then
	AurasPostUpdateButton = function(_, unit, button, _, _, duration, expiration)
		if duration and duration > 0 and C.aura.show_timer == true then
			button.remaining:Show()
			button.timeLeft = expiration
			button:SetScript("OnUpdate", T.CreateAuraTimer)
		else
			button.remaining:Hide()
			button.timeLeft = math.huge
			button:SetScript("OnUpdate", nil)
		end
		button.first = true
	end
else
	AurasPostUpdateButton = function(_, button, unit, data)
		if not UnitIsFriend("player", unit) then
			if data.isHarmful then
				if C.nameplate.track_debuffs and data.isPlayerAura or data.sourceUnit == "pet" then
					if C.nameplate.track_buffs then
						SetColorBorder(button, unpack(C.media.border_color))
					end
				end
			else
				if T.BuffWhiteList[data.name] then
					SetColorBorder(button, 0, 0.5, 0)
				elseif data.isStealable then
					SetColorBorder(button, 1, 0.85, 0)
				end
			end
		end

		if data.duration and data.duration > 0 and C.aura.show_timer == true then
			button.remaining:Show()
			button.timeLeft = data.expirationTime
			button:SetScript("OnUpdate", T.CreateAuraTimer)
		else
			button.remaining:Hide()
			button.timeLeft = math.huge
			button:SetScript("OnUpdate", nil)
		end
	end
end

local function UpdateTarget(self)
	local isTarget = UnitIsUnit(self.unit, "target")
	local isMe = UnitIsUnit(self.unit, "player")

	if isTarget and not isMe then
		if C.nameplate.ad_height > 0 or C.nameplate.ad_width > 0 then
			self:SetSize((C.nameplate.width + C.nameplate.ad_width) * T.noscalemult, (C.nameplate.height + C.nameplate.ad_height) * T.noscalemult)
			self.Castbar:SetPoint("BOTTOMLEFT", self.Health, "BOTTOMLEFT", 0, -8-((C.nameplate.height + C.nameplate.ad_height) * T.noscalemult))
			self.Castbar.Icon:SetSize(((C.nameplate.height + C.nameplate.ad_height) * 2 * T.noscalemult) + 8, ((C.nameplate.height + C.nameplate.ad_height) * 2 * T.noscalemult) + 8)
			if C.nameplate.class_icons == true then
				self.Class.Icon:SetSize(((C.nameplate.height + C.nameplate.ad_height) * 2 * T.noscalemult) + 8, ((C.nameplate.height + C.nameplate.ad_height) * 2 * T.noscalemult) + 8)
			end
		end
		if C.nameplate.target_glow then
			self.Glow:Show()
		end
		self:SetAlpha(1)
	else
		if C.nameplate.ad_height > 0 or C.nameplate.ad_width > 0 then
			self:SetSize(C.nameplate.width * T.noscalemult, C.nameplate.height * T.noscalemult)
			self.Castbar:SetPoint("BOTTOMLEFT", self.Health, "BOTTOMLEFT", 0, -8-(C.nameplate.height * T.noscalemult))
			self.Castbar.Icon:SetSize((C.nameplate.height * 2 * T.noscalemult) + 8, (C.nameplate.height * 2 * T.noscalemult) + 8)
			if C.nameplate.class_icons == true then
				self.Class.Icon:SetSize((C.nameplate.height * 2 * T.noscalemult) + 8, (C.nameplate.height * 2 * T.noscalemult) + 8)
			end
		end
		if C.nameplate.target_glow then
			self.Glow:Hide()
		end
		if not UnitExists("target") or isMe then
			self:SetAlpha(1)
		else
			self:SetAlpha(C.nameplate.alpha)
		end
	end
end

local function UpdateName(self)
	if C.nameplate.healer_icon == true then
		local name = self.unitName
		if name then
			if healList[name] then
				if exClass[healList[name]] then
					self.HealerIcon:Hide()
				else
					self.HealerIcon:Show()
				end
			else
				self.HealerIcon:Hide()
			end
		end
	end

	if C.nameplate.class_icons == true and self.Class then
		local reaction = UnitReaction(self.unit, "player")
		if UnitIsPlayer(self.unit) and (reaction and reaction <= 4) then
			local _, class = UnitClass(self.unit)
			local texcoord = CLASS_ICON_TCOORDS[class]
			self.Class.Icon:SetTexCoord(texcoord[1] + 0.015, texcoord[2] - 0.02, texcoord[3] + 0.018, texcoord[4] - 0.02)
			self.Class:Show()
			self.Level:SetPoint("RIGHT", self.Name, "LEFT", -2, 0)
		else
			self.Class.Icon:SetTexCoord(0, 0, 0, 0)
			self.Class:Hide()
			self.Level:SetPoint("RIGHT", self.Health, "LEFT", -2, 0)
		end
	end

	if C.nameplate.totem_icons == true and self.Totem then
		local name = self.unitName
		if name then
			if totemData[name] then
				self.Totem.Icon:SetTexture(totemData[name])
				self.Totem:Show()
			else
				self.Totem:Hide()
			end
		end
	end
end

local kickID = 0
if C.nameplate.kick_color then
	if T.Classic then
		if T.class == "DRUID" and T.SoD then
			kickID = 410176 -- Skull Bash [Season of Discovery]
		elseif T.class == "DRUID" then
			kickID = 0 -- TODO: Check for S3/S4 Arena Gloves which give Maim an Interrupt
		elseif T.class == "HUNTER" then
			kickID = 34490
		elseif T.class == "MAGE" then
			kickID = 2139
		elseif T.class == "PALADIN" and T.SoD then
			kickID = 425609 -- Rebuke [Season of Discovery]
		elseif T.class == "PALADIN" and T.race == "BloodElf" then
			kickID = 28730 -- Arcane Torrent
		elseif T.class == "PRIEST" then
			kickID = 15487
		elseif T.class == "ROGUE" then
			kickID = 1766
		elseif T.class == "SHAMAN" then
			kickID = 8042
		elseif T.class == "WARLOCK" then
			kickID = 24259 -- Spell Lock (Felhunter)
		elseif T.class == "WARRIOR" then -- TODO: Check for Improved Shield Bash in Protection
			kickID = 6552
		end
	else
		if T.class == "DEATHKNIGHT" then
			kickID = 47528
		elseif T.class == "DEMONHUNTER" then
			kickID = 183752
		elseif T.class == "DRUID" then
			kickID = 106839
		elseif T.class == "EVOKER" then
			kickID = 351338
		elseif T.class == "HUNTER" then
			kickID = GetSpecialization() == 3 and 187707 or 147362
		elseif T.class == "MAGE" then
			kickID = 2139
		elseif T.class == "MONK" then
			kickID = 116705
		elseif T.class == "PALADIN" then
			kickID = 96231
		elseif T.class == "PRIEST" then
			kickID = 15487
		elseif T.class == "ROGUE" then
			kickID = 1766
		elseif T.class == "SHAMAN" then
			kickID = 57994
		elseif T.class == "WARLOCK" then
			kickID = 119910
		elseif T.class == "WARRIOR" then
			kickID = 6552
		end
	end
end

-- Cast color
local function castColor(self)
	if self.notInterruptible then
		self:SetStatusBarColor(0.78, 0.25, 0.25)
		self.bg:SetColorTexture(0.78, 0.25, 0.25, 0.2)
	else
		if C.nameplate.kick_color then
			local start = GetSpellCooldown(kickID)
			if start ~= 0 then
				self:SetStatusBarColor(1, 0.5, 0)
				self.bg:SetColorTexture(1, 0.5, 0, 0.2)
			else
				self:SetStatusBarColor(1, 0.8, 0)
				self.bg:SetColorTexture(1, 0.8, 0, 0.2)
			end
		else
			self:SetStatusBarColor(1, 0.8, 0)
			self.bg:SetColorTexture(1, 0.8, 0, 0.2)
		end
	end

	if C.nameplate.cast_color then
		if T.InterruptCast[self.spellID] then
			SetColorBorder(self, 1, 0.8, 0)
		elseif T.ImportantCast[self.spellID] then
			SetColorBorder(self, 1, 0, 0)
		else
			SetColorBorder(self, unpack(C.media.border_color))
		end
	end
end

-- Health color
local function threatColor(self, forced)
	if UnitIsPlayer(self.unit) then return end

	if C.nameplate.enhance_threat ~= true then
		SetColorBorder(self.Health, unpack(C.media.border_color))
	end
	if UnitIsTapDenied(self.unit) then
		self.Health:SetStatusBarColor(0.6, 0.6, 0.6)
	elseif UnitAffectingCombat("player") then
		local threatStatus = UnitThreatSituation("player", self.unit)
		if self.npcID == "120651" then	-- Explosives affix
			self.Health:SetStatusBarColor(unpack(C.nameplate.extra_color))
		elseif self.npcID == "174773" then	-- Spiteful Shade affix
			if threatStatus == 3 then
				self.Health:SetStatusBarColor(unpack(C.nameplate.extra_color))
			else
				self.Health:SetStatusBarColor(unpack(C.nameplate.good_color))
			end
		elseif threatStatus == 3 then	-- securely tanking, highest threat
			if T.Role == "Tank" then
				if C.nameplate.enhance_threat == true then
					if C.nameplate.mob_color_enable and T.ColorPlate[self.npcID] then
						self.Health:SetStatusBarColor(unpack(T.ColorPlate[self.npcID]))
					else
						self.Health:SetStatusBarColor(unpack(C.nameplate.good_color))
					end
				else
					SetColorBorder(self.Health, unpack(C.nameplate.bad_color))
				end
			else
				if C.nameplate.enhance_threat == true then
					self.Health:SetStatusBarColor(unpack(C.nameplate.bad_color))
				else
					SetColorBorder(self.Health, unpack(C.nameplate.bad_color))
				end
			end
		elseif threatStatus == 2 then	-- insecurely tanking, another unit have higher threat but not tanking
			if C.nameplate.enhance_threat == true then
				self.Health:SetStatusBarColor(unpack(C.nameplate.near_color))
			else
				SetColorBorder(self.Health, unpack(C.nameplate.near_color))
			end
		elseif threatStatus == 1 then	-- not tanking, higher threat than tank
			if C.nameplate.enhance_threat == true then
				self.Health:SetStatusBarColor(unpack(C.nameplate.near_color))
			else
				SetColorBorder(self.Health, unpack(C.nameplate.near_color))
			end
		elseif threatStatus == 0 then	-- not tanking, lower threat than tank
			if C.nameplate.enhance_threat == true then
				if T.Role == "Tank" then
					local offTank = false
					if IsInRaid() then
						for i = 1, GetNumGroupMembers() do
							if T.Vanilla or T.TBC then
								if UnitExists("raid"..i) and not UnitIsUnit("raid"..i, "player") and T.Role == "TANK" then
									local isTanking = UnitDetailedThreatSituation("raid"..i, self.unit)
									if isTanking then
										offTank = true
										break
									end
								end
							else
								if UnitExists("raid"..i) and not UnitIsUnit("raid"..i, "player") and UnitGroupRolesAssigned("raid"..i) == "TANK" then
									local isTanking = UnitDetailedThreatSituation("raid"..i, self.unit)
									if isTanking then
										offTank = true
										break
									end
								end
							end
						end
					end
					if offTank then
						self.Health:SetStatusBarColor(unpack(C.nameplate.offtank_color))
					else
						self.Health:SetStatusBarColor(unpack(C.nameplate.bad_color))
					end
				else
					if C.nameplate.mob_color_enable and T.ColorPlate[self.npcID] then
						self.Health:SetStatusBarColor(unpack(T.ColorPlate[self.npcID]))
					else
						self.Health:SetStatusBarColor(unpack(C.nameplate.good_color))
					end
				end
			end
		end
	elseif not forced then
		self.Health:ForceUpdate()
	end
end

local function HealthPostUpdateColor(self, unit, r, g, b)
	local main = self:GetParent()
	local mu = self.bg.multiplier
	local isPlayer = UnitIsPlayer(unit)
	local unitReaction = UnitReaction(unit, "player")
	if not UnitIsUnit("player", unit) and isPlayer and (unitReaction and unitReaction >= 5) then
		r, g, b = unpack(T.Colors.power["MANA"])
		self:SetStatusBarColor(r, g, b)
		self.bg:SetVertexColor(r * mu, g * mu, b * mu)
	elseif not UnitIsTapDenied(unit) and not isPlayer then
		local reaction = T.Colors.reaction[unitReaction]
		if reaction then
			r, g, b = reaction[1], reaction[2], reaction[3]
		else
			r, g, b = UnitSelectionColor(unit, true)
		end

		self:SetStatusBarColor(r, g, b)
		self.bg:SetVertexColor(r * mu, g * mu, b * mu)
	end

	threatColor(main, true)
end

local function HealthPostUpdate(self, unit, cur, max)
	local perc = 0
	if max and max > 0 then
		perc = cur / max
	end

	local isPlayer = UnitIsPlayer(unit)
	if isPlayer then
		if perc <= 0.5 and perc >= 0.2 then
			SetColorBorder(self, 1, 1, 0)
		elseif perc < 0.2 then
			SetColorBorder(self, 1, 0, 0)
		else
			SetColorBorder(self, unpack(C.media.border_color))
		end
	elseif not isPlayer and C.nameplate.enhance_threat == true then
		if C.nameplate.low_health then
			if perc < C.nameplate.low_health_value then
				SetColorBorder(self, unpack(C.nameplate.low_health_color))
			else
				SetColorBorder(self, unpack(C.media.border_color))
			end
		else
			SetColorBorder(self, unpack(C.media.border_color))
		end
	end
end

local function callback(self, event, unit)
	if not self then return end
	if unit then
		local unitGUID = UnitGUID(unit)
		self.npcID = unitGUID and select(6, strsplit('-', unitGUID))
		self.unitName = UnitName(unit)
		if T.Mainline then
			self.widgetsOnly = UnitNameplateShowsWidgetsOnly(unit)
		end
		if self.npcID and T.PlateBlacklist[self.npcID] then
			self:Hide()
		else
			self:Show()
		end

		if UnitIsUnit(unit, "player") then
			self.Power:Show()
			self.Name:Hide()
			self.Castbar:SetAlpha(0)
			self.RaidTargetIndicator:SetAlpha(0)
		else
			self.Power:Hide()
			self.Name:Show()
			self.Castbar:SetAlpha(1)
			self.RaidTargetIndicator:SetAlpha(1)

			if T.Classic then
				self.Health:SetAlpha(1)
				self.Level:SetAlpha(1)
				self.Name:SetAlpha(1)
				self.Castbar:SetAlpha(1)
			else
				if self.widgetsOnly or (UnitWidgetSet(unit) and UnitIsOwnerOrControllerOfUnit("player", unit)) then
					self.Health:SetAlpha(0)
					self.Level:SetAlpha(0)
					self.Name:SetAlpha(0)
					self.Castbar:SetAlpha(0)
				else
					self.Health:SetAlpha(1)
					self.Level:SetAlpha(1)
					self.Name:SetAlpha(1)
					self.Castbar:SetAlpha(1)
				end
			end

			local nameplate = C_NamePlate.GetNamePlateForUnit(unit)
			if nameplate.UnitFrame then
				if nameplate.UnitFrame.WidgetContainer then
					nameplate.UnitFrame.WidgetContainer:SetParent(nameplate)
				end
			end

			if C.nameplate.only_name then
				if UnitIsFriend("player", unit) then
					self.Health:SetAlpha(0)
					self.Name:ClearAllPoints()
					self.Name:SetPoint("CENTER", self, "CENTER", 0, 0)
					self.Level:SetAlpha(0)
					self.Castbar:SetAlpha(0)
					if C.nameplate.target_glow then
						self.Glow:SetAlpha(0)
					end
				else
					self.Health:SetAlpha(1)
					self.Name:ClearAllPoints()
					self.Name:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -3, 4)
					self.Name:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 3, 4)
					self.Level:SetAlpha(1)
					self.Castbar:SetAlpha(1)
					if C.nameplate.target_glow then
						self.Glow:SetAlpha(1)
					end
				end
			end
		end
	end
end

local function style(self, unit)
	local nameplate = C_NamePlate.GetNamePlateForUnit(unit)
	local main = self
	self.unit = unit

	self:SetPoint("CENTER", nameplate, "CENTER")
	self:SetSize(C.nameplate.width * T.noscalemult, C.nameplate.height * T.noscalemult)

	-- Health Bar
	self.Health = CreateFrame("StatusBar", nil, self)
	self.Health:SetAllPoints(self)
	self.Health:SetStatusBarTexture(C.media.texture)
	self.Health.colorTapping = true
	self.Health.colorDisconnected = true
	self.Health.colorClass = true
	self.Health.colorReaction = true
	self.Health.colorHealth = true
	CreateBorderFrame(self.Health)

	if T.Classic then
		self.Health.frequentUpdates = true
	end

	self.Health.bg = self.Health:CreateTexture(nil, "BORDER")
	self.Health.bg:SetAllPoints()
	self.Health.bg:SetTexture(C.media.texture)
	self.Health.bg.multiplier = 0.2

	-- Health Text
	if C.nameplate.health_value == true then
		self.Health.value = self.Health:CreateFontString(nil, "OVERLAY")
		self.Health.value:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * T.noscalemult, C.font.nameplates_font_style)
		self.Health.value:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
		self.Health.value:SetPoint("RIGHT", self.Health, "RIGHT", 0, 0)
		self:Tag(self.Health.value, "[NameplateHealth]")
	end

	-- Player Power Bar
	self.Power = CreateFrame("StatusBar", nil, self)
	self.Power:SetStatusBarTexture(C.media.texture)
	self.Power:SetPoint("TOPLEFT", self.Health, "BOTTOMLEFT", 0, -6)
	self.Power:SetPoint("BOTTOMRIGHT", self.Health, "BOTTOMRIGHT", 0, -6-(C.nameplate.height * T.noscalemult / 2))
	self.Power.frequentUpdates = true
	self.Power.colorPower = true
	self.Power.PostUpdate = T.PreUpdatePower
	CreateBorderFrame(self.Power)

	self.Power.bg = self.Power:CreateTexture(nil, "BORDER")
	self.Power.bg:SetAllPoints()
	self.Power.bg:SetTexture(C.media.texture)
	self.Power.bg.multiplier = 0.2

	-- Hide Blizzard Power Bar
	if T.Mainline then
		hooksecurefunc(_G.NamePlateDriverFrame, "SetupClassNameplateBars", function(frame)
			if not frame or frame:IsForbidden() then
				return
			end
			if frame.classNamePlatePowerBar then
				frame.classNamePlatePowerBar:Hide()
				frame.classNamePlatePowerBar:UnregisterAllEvents()
			end
		end)
	end

	-- Name Text
	self.Name = self:CreateFontString(nil, "OVERLAY")
	self.Name:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * T.noscalemult, C.font.nameplates_font_style)
	self.Name:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
	self.Name:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -3, 4)
	self.Name:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", 3, 4)
	self.Name:SetWordWrap(false)

	if C.nameplate.name_abbrev then
		self:Tag(self.Name, "[NameplateNameColor][NameLongAbbrev]")
	elseif C.nameplate.short_name then
		self:Tag(self.Name, "[NameplateNameColor][NameplateNameShort]")
	else
		self:Tag(self.Name, "[NameplateNameColor][NameLong]")
	end

	-- Target Glow
	if C.nameplate.target_glow then
		self.Glow = CreateFrame("Frame", nil, self, BackdropTemplateMixin and "BackdropTemplate")
		self.Glow:SetBackdrop({edgeFile = [[Interface\AddOns\ViksUI\Media\Textures\Glow.tga]], edgeSize = 4 * T.noscalemult})
		self.Glow:SetPoint("TOPLEFT", -7 * T.noscalemult, 7 * T.noscalemult)
		self.Glow:SetPoint("BOTTOMRIGHT", 7 * T.noscalemult, -7 * T.noscalemult)
		self.Glow:SetBackdropBorderColor(0.8, 0.8, 0.8)
		self.Glow:SetFrameLevel(0)
		self.Glow:Hide()
	end

	-- Level Text
	self.Level = self:CreateFontString(nil, "ARTWORK")
	self.Level:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * T.noscalemult, C.font.nameplates_font_style)
	self.Level:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
	self.Level:SetPoint("RIGHT", self.Health, "LEFT", -2, 0)
	self:Tag(self.Level, "[DiffColor][NameplateLevel][shortclassification]")

	-- Cast Bar
	self.Castbar = CreateFrame("StatusBar", nil, self)
	self.Castbar:SetFrameLevel(3)
	self.Castbar:SetStatusBarTexture(C.media.texture)
	self.Castbar:SetStatusBarColor(1, 0.8, 0)
	self.Castbar:SetPoint("TOPLEFT", self.Health, "BOTTOMLEFT", 0, -8)
	self.Castbar:SetPoint("BOTTOMRIGHT", self.Health, "BOTTOMRIGHT", 0, -8-(C.nameplate.height * T.noscalemult))
	CreateBorderFrame(self.Castbar)

	self.Castbar.bg = self.Castbar:CreateTexture(nil, "BORDER")
	self.Castbar.bg:SetAllPoints()
	self.Castbar.bg:SetTexture(C.media.texture)
	self.Castbar.bg:SetColorTexture(1, 0.8, 0, 0.2)

	self.Castbar.PostCastStart = castColor
	self.Castbar.PostCastInterruptible = castColor

	-- Cast Time Text
	self.Castbar.Time = self.Castbar:CreateFontString(nil, "ARTWORK")
	self.Castbar.Time:SetPoint("RIGHT", self.Castbar, "RIGHT", 0, 0)
	self.Castbar.Time:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * T.noscalemult, C.font.nameplates_font_style)
	self.Castbar.Time:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)

	self.Castbar.CustomTimeText = function(self, duration)
		self.Time:SetText(("%.1f"):format(self.channeling and duration or self.max - duration))
	end

	-- Cast Name Text
	if C.nameplate.show_castbar_name == true then
		self.Castbar.Text = self.Castbar:CreateFontString(nil, "OVERLAY")
		self.Castbar.Text:SetPoint("LEFT", self.Castbar, "LEFT", 3, 0)
		self.Castbar.Text:SetPoint("RIGHT", self.Castbar.Time, "LEFT", -1, 0)
		self.Castbar.Text:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * T.noscalemult, C.font.nameplates_font_style)
		self.Castbar.Text:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)
		self.Castbar.Text:SetHeight(C.font.nameplates_font_size)
		self.Castbar.Text:SetJustifyH("LEFT")
	end

	-- Cast Bar Icon
	self.CastbarIcon = CreateFrame("Frame", nil, self.Castbar)
	self.Castbar.Icon = self.CastbarIcon:CreateTexture(nil, "OVERLAY")
	self.Castbar.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	self.Castbar.Icon:SetDrawLayer("ARTWORK")
	self.Castbar.Icon:SetSize((C.nameplate.height * 2 * T.noscalemult) + 8, (C.nameplate.height * 2 * T.noscalemult) + 8)
	self.Castbar.Icon:SetPoint("TOPLEFT", self.Health, "TOPRIGHT", 8, 0)
	CreateBorderFrame(self.CastbarIcon, self.Castbar.Icon)

	-- Raid Icon
	self.RaidTargetIndicator = self:CreateTexture(nil, "OVERLAY", nil, 7)
	self.RaidTargetIndicator:SetSize((C.nameplate.height * 2 * T.noscalemult) + 8, (C.nameplate.height * 2 * T.noscalemult) + 8)
	self.RaidTargetIndicator:SetPoint("BOTTOM", self.Health, "TOP", 0, C.nameplate.track_debuffs == true and 38 or 16)

	-- Class Icon
	if C.nameplate.class_icons == true then
		self.Class = CreateFrame("Frame", nil, self)
		self.Class.Icon = self.Class:CreateTexture(nil, "OVERLAY")
		self.Class.Icon:SetSize((C.nameplate.height * 2 * T.noscalemult) + 8, (C.nameplate.height * 2 * T.noscalemult) + 8)
		self.Class.Icon:SetPoint("TOPRIGHT", self.Health, "TOPLEFT", -8, 0)
		self.Class.Icon:SetTexture("Interface\\WorldStateFrame\\Icons-Classes")
		self.Class.Icon:SetTexCoord(0, 0, 0, 0)
		CreateBorderFrame(self.Class, self.Class.Icon)
	end

	-- Totem Icon
	if C.nameplate.totem_icons == true then
		self.Totem = CreateFrame("Frame", nil, self)
		self.Totem.Icon = self.Totem:CreateTexture(nil, "OVERLAY")
		self.Totem.Icon:SetSize((C.nameplate.height * 2 * T.noscalemult) + 8, (C.nameplate.height * 2 * T.noscalemult) + 8)
		self.Totem.Icon:SetPoint("BOTTOM", self.Health, "TOP", 0, 16)
		self.Totem.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		CreateBorderFrame(self.Totem, self.Totem.Icon)
	end

	-- Healer Icon
	if C.nameplate.healer_icon == true then
		self.HealerIcon = self.Health:CreateFontString(nil, "OVERLAY")
		self.HealerIcon:SetFont(C.font.nameplates_font, 32, C.font.nameplates_font_style)
		self.HealerIcon:SetText("|cFFD53333+|r")
		self.HealerIcon:SetPoint("BOTTOM", self.Name, "TOP", 0, C.nameplate.track_debuffs == true and 13 or 0)
	end

	-- Quest Icon
	if T.Mainline and C.nameplate.quests then
		self.QuestIcon = self:CreateTexture(nil, "OVERLAY", nil, 7)
		self.QuestIcon:SetSize((C.nameplate.height * 2 * T.noscalemult), (C.nameplate.height * 2 * T.noscalemult))
		self.QuestIcon:SetPoint("RIGHT", self.Health, "LEFT", -5, 0)
		self.QuestIcon:Hide()

		self.QuestIcon.Text = self:CreateFontString(nil, "OVERLAY")
		self.QuestIcon.Text:SetPoint("RIGHT", self.QuestIcon, "LEFT", -1, 0)
		self.QuestIcon.Text:SetFont(C.font.nameplates_font, C.font.nameplates_font_size * T.noscalemult * 2, C.font.nameplates_font_style)
		self.QuestIcon.Text:SetShadowOffset(C.font.nameplates_font_shadow and 1 or 0, C.font.nameplates_font_shadow and -1 or 0)

		self.QuestIcon.Item = self:CreateTexture(nil, "OVERLAY")
		self.QuestIcon.Item:SetSize((C.nameplate.height * 2 * T.noscalemult) - 2, (C.nameplate.height * 2 * T.noscalemult) - 2)
		self.QuestIcon.Item:SetPoint("RIGHT", self.QuestIcon.Text, "LEFT", -2, 0)
		self.QuestIcon.Item:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	end

	-- Aura tracking
	if C.nameplate.track_debuffs == true or C.nameplate.track_buffs == true then
		self.Auras = CreateFrame("Frame", nil, self)
		self.Auras:SetPoint("BOTTOMRIGHT", self.Health, "TOPRIGHT", 0, C.font.nameplates_font_size + 7)
		self.Auras.initialAnchor = "BOTTOMRIGHT"
		self.Auras["growth-y"] = "UP"
		self.Auras["growth-x"] = "LEFT"
		self.Auras.numDebuffs = C.nameplate.track_debuffs and 6 or 0
		self.Auras.numBuffs = C.nameplate.track_buffs and 4 or 0
		self.Auras:SetSize(20 + C.nameplate.width, C.nameplate.auras_size)
		self.Auras.spacing = 5 * T.noscalemult
		self.Auras.size = C.nameplate.auras_size * T.noscalemult - 3
		self.Auras.disableMouse = true

		self.Auras.FilterAura = AurasCustomFilter
		self.Auras.PostCreateButton = AurasPostCreateButton
		self.Auras.PostUpdateButton = AurasPostUpdateButton
	end

	-- Health color
	self.Health:RegisterEvent("PLAYER_REGEN_DISABLED")
	self.Health:RegisterEvent("PLAYER_REGEN_ENABLED")
	self.Health:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE")
	self.Health:RegisterEvent("UNIT_THREAT_LIST_UPDATE")

	self.Health:SetScript("OnEvent", function()
		threatColor(main)
	end)

	self.Health.PostUpdate = HealthPostUpdate
	self.Health.PostUpdateColor = HealthPostUpdateColor

	-- Absorb
	if C.unitframe.plugins_healcomm == true then
		if T.Mainline then
			local ahpb = self.Health:CreateTexture(nil, "ARTWORK")
			ahpb:SetTexture(C.media.texture)
			ahpb:SetVertexColor(1, 1, 0, 1)
			self.HealthPrediction = {
				absorbBar = ahpb
			}
		end
	end

	-- Every event should be register with this
	table.insert(self.__elements, UpdateName)
	self:RegisterEvent("UNIT_NAME_UPDATE", UpdateName)

	table.insert(self.__elements, UpdateTarget)
	self:RegisterEvent("PLAYER_TARGET_CHANGED", UpdateTarget, true)

	-- Disable movement via /moveui
	self.disableMovement = true

	if T.PostCreateNameplates then
		T.PostCreateNameplates(self, unit)
	end
end

oUF:RegisterStyle("ViksUINameplate", style)
oUF:SetActiveStyle("ViksUINameplate")
oUF:SpawnNamePlates("ViksUINameplate", callback)