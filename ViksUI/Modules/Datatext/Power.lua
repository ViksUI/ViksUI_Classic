local T, C, L = unpack(ViksUI)
--------------------------------------------------------------------
-- Primary Stat
--------------------------------------------------------------------

if not C.datatext.Power and not C.datatext.Power > 0 then return end

local Stat = CreateFrame("Frame", "DataTextPower", UIParent)
Stat:SetFrameStrata("BACKGROUND")
Stat:SetFrameLevel(3)

local Text  = Stat:CreateFontString(nil, "OVERLAY")
if C.datatext.Power >= 6 then
	Text:SetTextColor(unpack(C.media.pxcolor1))
	Text:SetFont(C.media.pxfontHeader, C.media.pxfontHsize, C.media.pxfontHFlag)
else
	Text:SetTextColor(unpack(C.media.pxcolor1))
	Text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
end

PP(C.datatext.Power, Text)

local int = 1

local function Update(self, t)
	int = int - t
	local base, posBuff, negBuff = UnitAttackPower("player")
	local effective = base + posBuff + negBuff
	local Rbase, RposBuff, RnegBuff = UnitRangedAttackPower("player")
	local Reffective = Rbase + RposBuff + RnegBuff


	healpwr = GetSpellBonusHealing()

	Rattackpwr = Reffective
	spellpwr2 = GetSpellBonusDamage(7)
	attackpwr = effective

	if healpwr > spellpwr2 then
		spellpwr = healpwr
	else
		spellpwr = spellpwr2
	end

	if attackpwr > spellpwr and select(2, UnitClass("Player")) ~= "HUNTER" then
		pwr = attackpwr
		tp_pwr = "AP"
	elseif select(2, UnitClass("Player")) == "HUNTER" then
		pwr = Reffective
		tp_pwr = "RAP"
	else
		pwr = spellpwr
		tp_pwr = "SP"
	end
	if int < 0 then
		Text:SetText(qColor..pwr..qColor2.." ".. tp_pwr)      
		int = 1
	end
end

Stat:SetScript("OnUpdate", Update)
Update(Stat, 10)