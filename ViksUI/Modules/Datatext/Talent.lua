local T, C, L = unpack(ViksUI)
if not T.Mainline then return end

if not C.datatext.Talents or C.datatext.Talents == 0 then return end

local Stat = CreateFrame("Frame", "ViksUIStatTalent", UIParent)
Stat:EnableMouse(true)
Stat:SetFrameStrata("BACKGROUND")
Stat:SetFrameLevel(3)
Stat.Option = C.datatext.Talents

local Text  = Stat:CreateFontString(nil, "OVERLAY")

if C.datatext.Talents >= 9 then
Text:SetTextColor(unpack(C.media.pxcolor1))
Text:SetFont(C.media.pxfontHeader, C.media.pxfontHsize, C.media.pxfontHFlag)
else
Text:SetTextColor(unpack(C.media.pxcolor1))
Text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
end
PP(C.datatext.Talents, Text)


local LeftClickMenu = { }
LeftClickMenu[1] = { text = "ViksUI Specialization Selector", isTitle = true, notCheckable = true}

local ViksUISpecSwap = CreateFrame("Frame", "ViksUISpecSwap", UIParent, "UIDropDownMenuTemplate") --Setting up the menu for later for each spec regardless of class, thanks to Simca for helping out with the function.
ViksUISpecSwap:SetTemplate("Transparent")
ViksUISpecSwap:RegisterEvent("PLAYER_LOGIN")
ViksUISpecSwap:SetScript("OnEvent", function(...)
	if T.Cata then
		return GetPrimaryTalentTree(isInspect, isPet, specGroup)
	else
		if (isInspect or isPet) then
			return
		end
		local specIndex
		local max = 0
		for tabIndex = 1, GetNumTalentTabs() do
			local spent = select(5, GetTalentTabInfo(tabIndex, "player", T.Wrath and specGroup))
			if spent > max then
				specIndex = tabIndex
				max = spent
			end
		end
		return specIndex
	end
end)

local function Update(self) --The pretty part of the data text, displays the name of the spec.
	if not GetSpecialization() then
		Text:SetText(L_TOOLTIP_NO_TALENT) 
	else
		local tree = GetSpecialization()
		local spec = select(2,GetSpecializationInfo(tree)) or ""
		Text:SetText("|r "..spec.."|r")
	end
	self:SetAllPoints(Text)
end

Stat:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
Stat:RegisterEvent("CONFIRM_TALENT_WIPE")
Stat:RegisterEvent("PLAYER_TALENT_UPDATE")
Stat:SetScript("OnEvent", Update)
Stat:SetScript("OnMouseDown", function(self, btn)
	if btn == "LeftButton" then 
		EasyMenu(LeftClickMenu, ViksUISpecSwap, "cursor", 0, 0, "MENU", 2) --Dropdown/popup menu for spec selection.
	end
end)
