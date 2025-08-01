local T, C, L = unpack(ViksUI)
if C.misc.click_cast ~= true then return end

----------------------------------------------------------------------------------------
--	Simple click2cast spell binder(sBinder by Fernir)
----------------------------------------------------------------------------------------
local SpellBinder = CreateFrame("Frame", "SpellBinder", SpellBookFrame, "ButtonFrameTemplate")
SpellBinder:SetPoint("TOPLEFT", SpellBookFrame, "TOPRIGHT", 100, -1)
SpellBinder:SetSize(300, 400)
SpellBinder:Hide()

SpellBinderPortrait:SetAlpha(0)

SpellBinder.title = _G["SpellBinderTitle"] or SpellBinder:CreateFontString("SpellBinderTitle", "OVERLAY", "GameFontNormal")
SpellBinder.title:SetPoint("TOP", _G["SpellBinder"], "TOP", 0, -5)
SpellBinder.title:SetText(L_MISC_BINDER_OPEN)

SpellBinder.sbOpen = false
SpellBinder.spellbuttons = {}

local DB
ClickCastFrames = _G.ClickCastFrames or {}
for _, v in pairs({
	"PlayerFrame", "PetFrame",
	-- Party members
	"PartyMemberFrame1", "PartyMemberFrame2", "PartyMemberFrame3", "PartyMemberFrame4", "PartyMemberFrame5",
	-- Party pets
	"PartyMemberFrame1PetFrame", "PartyMemberFrame2PetFrame", "PartyMemberFrame3PetFrame", "PartyMemberFrame4PetFrame", "PartyMemberFrame5PetFrame",
	-- Compact party member frame
	"CompactPartyFrameMemberSelf", "CompactPartyFrameMemberSelfBuff1", "CompactPartyFrameMemberSelfBuff2", "CompactPartyFrameMemberSelfBuff3", "CompactPartyFrameMemberSelfDebuff1", "CompactPartyFrameMemberSelfDebuff2", "CompactPartyFrameMemberSelfDebuff3",
	"CompactPartyFrameMember1Buff1", "CompactPartyFrameMember1Buff2", "CompactPartyFrameMember1Buff3", "CompactPartyFrameMember1Debuff1", "CompactPartyFrameMember1Debuff2", "CompactPartyFrameMember1Debuff3",
	"CompactPartyFrameMember2Buff1", "CompactPartyFrameMember2Buff2", "CompactPartyFrameMember2Buff3", "CompactPartyFrameMember2Debuff1", "CompactPartyFrameMember2Debuff2", "CompactPartyFrameMember2Debuff3",
	"CompactPartyFrameMember3Buff1", "CompactPartyFrameMember3Buff2", "CompactPartyFrameMember3Buff3", "CompactPartyFrameMember3Debuff1", "CompactPartyFrameMember3Debuff2", "CompactPartyFrameMember3Debuff3",
	"CompactPartyFrameMember4Buff1", "CompactPartyFrameMember4Buff2", "CompactPartyFrameMember4Buff3", "CompactPartyFrameMember4Debuff1", "CompactPartyFrameMember4Debuff2", "CompactPartyFrameMember4Debuff3",
	"CompactPartyFrameMember5Buff1", "CompactPartyFrameMember5Buff2", "CompactPartyFrameMember5Buff3", "CompactPartyFrameMember5Debuff1", "CompactPartyFrameMember5Debuff2", "CompactPartyFrameMember5Debuff3",
	-- Target and focus frames
	"TargetFrame", "TargetFrameToT",
	"FocusFrame", "FocusFrameToT",
	-- Boss and arena frames
	"Boss1TargetFrame", "Boss2TargetFrame", "Boss3TargetFrame", "Boss4TargetFrame",
	"ArenaEnemyFrame1", "ArenaEnemyFrame2", "ArenaEnemyFrame3", "ArenaEnemyFrame4", "ArenaEnemyFrame5",
}) do
	if _G[v] then ClickCastFrames[_G[v]] = true end
end

hooksecurefunc("CreateFrame", function(_, name, _, template)
	if template and name and template:find("SecureUnitButtonTemplate") then
		ClickCastFrames[_G[name]] = true
	end
end)

hooksecurefunc("CompactUnitFrame_SetUpFrame", function(frame)
	if frame.IsForbidden and frame:IsForbidden() then
		return
	end
	ClickCastFrames[frame] = true
end)

local ScrollSpells = CreateFrame("ScrollFrame", "SpellBinderScrollFrameSpellList", _G["SpellBinderInset"], "ScrollFrameTemplate")
ScrollSpells:SetPoint("TOPLEFT", _G["SpellBinderInset"], "TOPLEFT", 0, -5)
ScrollSpells:SetPoint("BOTTOMRIGHT", _G["SpellBinderInset"], "BOTTOMRIGHT", -30, 5)
ScrollSpells.child = CreateFrame("Frame", "SpellBinderScrollFrameSpellListChild", ScrollSpells)
ScrollSpells.child:SetSize(270, 300)
ScrollSpells:SetScrollChild(ScrollSpells.child)

SpellBinder.makeSpellsList = function(_, delete)
	local oldb
	local scroll = ScrollSpells.child

	if delete then
		local i = 1
		while _G["SpellBinder"..i.."_cbs"] do
			_G["SpellBinder"..i.."_fs"]:SetText("")
			_G["SpellBinder"..i.."_texture"]:SetTexture(nil)
			_G["SpellBinder"..i.."_cbs"].checked = false
			_G["SpellBinder"..i.."_cbs"]:ClearAllPoints()
			_G["SpellBinder"..i.."_cbs"]:Hide()
			i = i + 1
		end
	end

	for i, spell in ipairs(DB.spells) do
		local v = spell.spell
		if v then
			local bf = _G["SpellBinder"..i.."_cbs"] or CreateFrame("Button", "SpellBinder"..i.."_cbs", scroll, "BackdropTemplate")
			spell.checked = spell.checked or false

			if i == 1 then
				bf:SetPoint("TOPLEFT", scroll, "TOPLEFT", 10, -10)
				bf:SetPoint("BOTTOMRIGHT", scroll, "TOPRIGHT", -10, -34)
			else
				bf:SetPoint("TOPLEFT", oldb, "BOTTOMLEFT", 0, -2)
				bf:SetPoint("BOTTOMRIGHT", oldb, "BOTTOMRIGHT", 0, -26)
			end

			bf:EnableMouse(true)

			bf.tex = bf.tex or bf:CreateTexture("SpellBinder"..i.."_texture", "OVERLAY")
			bf.tex:SetSize(22, 22)
			bf.tex:SetPoint("LEFT")
			bf.tex:SetTexture(spell.texture)
			if C_AddOns.IsAddOnLoaded("Aurora") or C.skins.blizzard_frames == true then
				bf.tex:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			end

			bf.delete = bf.delete or CreateFrame("Button", "SpellBinder"..i.."_delete", bf)
			bf.delete:SetSize(16, 16)
			bf.delete:SetPoint("RIGHT")
			bf.delete:SetNormalTexture("Interface\\BUTTONS\\UI-GroupLoot-Pass-Up")
			bf.delete:GetNormalTexture():SetVertexColor(0.8, 0, 0)
			bf.delete:SetPushedTexture("Interface\\BUTTONS\\UI-GroupLoot-Pass-Up")
			bf.delete:SetHighlightTexture("Interface\\BUTTONS\\UI-GroupLoot-Pass-Up")
			bf.delete:SetScript("OnClick", function()
				for j, k in ipairs(DB.spells) do
					if k ~= spell then
						k.checked = false
						_G["SpellBinder"..j.."_cbs"]:SetBackdropColor(0, 0, 0, 0)
					end
				end
				spell.checked = not spell.checked
				SpellBinder.DeleteSpell()
			end)

			bf:SetScript("OnEnter", function(self) bf.delete:GetNormalTexture():SetVertexColor(1, 0, 0) self:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8x8"}) self:SetBackdropColor(0.2, 0.2, 0.2, 0.7) end)
			bf:SetScript("OnLeave", function(self) bf.delete:GetNormalTexture():SetVertexColor(0.8, 0, 0) self:SetBackdrop(nil) end)

			bf.fs = bf.fs or bf:CreateFontString("SpellBinder"..i.."_fs", "OVERLAY", "GameFontNormal")
			bf.fs:SetText(spell.modifier..spell.origbutton)
			bf.fs:SetPoint("RIGHT", bf.delete, "LEFT", -4, 0)

			if GetSpellInfo(v) then
				bf:SetAlpha(1)
				for frame in pairs(ClickCastFrames) do
					local f
					if frame and type(frame) == "table" then f = frame:GetName() end
					if f and SpellBinder.frames[frame] then
						if _G[f]:CanChangeAttribute() or _G[f]:CanChangeProtectedState() then
							if _G[f]:GetAttribute(spell.modifier.."type"..spell.button) ~= "menu" then
								_G[f]:RegisterForClicks("AnyDown")

								if spell.button:find("harmbutton") then
									_G[f]:SetAttribute(spell.modifier..spell.button, spell.spell)
									_G[f]:SetAttribute(spell.modifier.."type-"..spell.spell, "spell")
									_G[f]:SetAttribute(spell.modifier.."spell-"..spell.spell, spell.spell)

									DB.keys[spell.modifier..spell.button] = spell.spell
									DB.keys[spell.modifier.."type-"..spell.spell] = "spell"
									DB.keys[spell.modifier.."spell-"..spell.spell] = spell.spell
								else
									_G[f]:SetAttribute(spell.modifier.."type"..spell.button, "spell")
									_G[f]:SetAttribute(spell.modifier.."spell"..spell.button, spell.spell)

									DB.keys[spell.modifier.."type"..spell.button] = "spell"
									DB.keys[spell.modifier.."spell"..spell.button] = spell.spell
								end
							end
						end
					end
				end
			else
				bf:SetAlpha(0.3)
			end

			bf:Show()
			oldb = bf
		end
	end
end

SpellBinder.makeFramesList = function()
	for frame in pairs(ClickCastFrames) do
		local v
		if frame and type(frame) == "table" then v = frame:GetName() end
		if C.misc.click_cast_filter ~= true then
			if v then SpellBinder.frames[frame] = SpellBinder.frames[frame] or true end
		else
			if v ~= "oUF_Target" and v ~= "oUF_Player" then SpellBinder.frames[frame] = SpellBinder.frames[frame] or true end
		end
	end
end

SpellBinder.ToggleButtons = function()
	for i = 1, SPELLS_PER_PAGE do
		SpellBinder.spellbuttons[i]:Hide()
		if SpellBinder.sbOpen and SpellBookFrame.bookType ~= BOOKTYPE_PROFESSION then
			local slot = SpellBook_GetSpellBookSlot(SpellBinder.spellbuttons[i]:GetParent())
			if slot then
				local spellname = GetSpellBookItemName(slot, SpellBookFrame.bookType)
				if spellname then
					SpellBinder.spellbuttons[i]:Show()
					AutoCastShine_AutoCastStart(SpellBinder.spellbuttons[i])
				end
			end
		end
	end
	SpellBinder:makeFramesList()
	SpellBinder:makeSpellsList(true)
	if SpellBinder:IsVisible() then SpellBinder.OpenButton:SetChecked(true) else SpellBinder.OpenButton:SetChecked(false) end
end

--FIXME hooksecurefunc("SpellBookFrame_Update", function() if SpellBinder.sbOpen then SpellBinder:ToggleButtons() end end)

SpellBinder.OpenButton = CreateFrame("CheckButton", "SpellBinderOpenButton", _G["SpellBookSkillLineTab1"], "SpellBookSkillLineTabTemplate")
SpellBinder.OpenButton:SetNormalTexture("Interface\\ICONS\\Achievement_Guild_Doctorisin")

SpellBinder.OpenButton:SetScript("OnShow", function(self)
	if SpellBinder:IsVisible() then self:SetChecked(true) end
	local num = GetNumSpellTabs()
	local lastTab = _G["SpellBookSkillLineTab"..num]

	self:ClearAllPoints()
	self:SetPoint("TOPLEFT", lastTab, "BOTTOMLEFT", 0, -17)

	self:SetScript("OnEnter", function(self) GameTooltip:ClearLines() GameTooltip:SetOwner(self, "ANCHOR_RIGHT") GameTooltip:AddLine(L_MISC_BINDER_OPEN) GameTooltip:Show() end)
	self:SetScript("OnLeave", function() GameTooltip:Hide() end)
end)

SpellBinder.OpenButton:SetScript("OnClick", function()
	if InCombatLockdown() then SpellBinder:Hide() return end
	if SpellBinder:IsVisible() then
		SpellBinder:Hide()
		SpellBinder.sbOpen = false
	else
		SpellBinder:Show()
		SpellBinder.sbOpen = true
	end
	SpellBinder:ToggleButtons()
end)
SpellBinder.OpenButton:Show()

_G["SpellBinderCloseButton"]:SetScript("OnClick", function()
	SpellBinder:Hide()
	SpellBinder.sbOpen = false
	SpellBinder:ToggleButtons()
end)

hooksecurefunc(SpellBookFrame, "Hide", function()
	SpellBinder:Hide()
	SpellBinder.sbOpen = false
	SpellBinder:ToggleButtons()
end)

SpellBinder.DeleteSpell = function()
	for i, spell in ipairs(DB.spells) do
		if spell.checked then
			for frame in pairs(ClickCastFrames) do
				local f
				if frame and type(frame) == "table" then f = frame:GetName() end
				if f then
					if _G[f]:CanChangeAttribute() or _G[f]:CanChangeProtectedState() then
						if _G[f]:GetAttribute(spell.modifier.."type"..spell.button) ~= "menu" then
							if spell.button:find("harmbutton") then
								_G[f]:SetAttribute(spell.modifier..spell.button, nil)
								_G[f]:SetAttribute(spell.modifier.."type-"..spell.spell, nil)
								_G[f]:SetAttribute(spell.modifier.."spell-"..spell.spell, nil)
							else
								_G[f]:SetAttribute(spell.modifier.."type"..spell.button, nil)
								_G[f]:SetAttribute(spell.modifier.."spell"..spell.button, nil)
							end
						end
					end
				end
			end
			tremove(DB.spells, i)
		end
	end
	SpellBinder:makeSpellsList(true)
end

local addSpell = function(self, button)
	if SpellBinder.sbOpen then
		local slot = SpellBook_GetSpellBookSlot(self:GetParent())
		local spellname = GetSpellBookItemName(slot, SpellBookFrame.bookType)
		local texture = GetSpellBookItemTexture(slot, SpellBookFrame.bookType)

		if spellname ~= 0 and ((SpellBookFrame.bookType == BOOKTYPE_PET) or (SpellBookFrame.selectedSkillLine > 1)) then
			local originalbutton = button
			local modifier = ""

			if IsShiftKeyDown() then modifier = "Shift-"..modifier end
			if IsControlKeyDown() then modifier = "Ctrl-"..modifier end
			if IsAltKeyDown() then modifier = "Alt-"..modifier end

			if IsHarmfulSpell(slot, SpellBookFrame.bookType) then
				button = format("%s%d", "harmbutton", SecureButton_GetButtonSuffix(button))
				originalbutton = "|cffff2222(harm)|r "..originalbutton
			else
				button = SecureButton_GetButtonSuffix(button)
			end

			for _, v in pairs(DB.spells) do if v.spell == spellname then return end end

			tinsert(DB.spells, {["id"] = slot, ["modifier"] = modifier, ["button"] = button, ["spell"] = spellname, ["texture"] = texture, ["origbutton"] = originalbutton,})
			SpellBinder:makeSpellsList(false)
		end
	end
end

SpellBinder.UpdateAll = function()
	if InCombatLockdown() then
		SpellBinder:RegisterEvent("PLAYER_REGEN_ENABLED")
		return
	end
	SpellBinder:makeFramesList()
	SpellBinder:makeSpellsList(true)
end

SpellBinder:RegisterEvent("PLAYER_LOGIN")
SpellBinder:RegisterEvent("PLAYER_ENTERING_WORLD")
SpellBinder:RegisterEvent("GROUP_ROSTER_UPDATE")
SpellBinder:RegisterEvent("ZONE_CHANGED")
SpellBinder:RegisterEvent("ZONE_CHANGED_NEW_AREA")
SpellBinder:RegisterEvent("PLAYER_TALENT_UPDATE")
SpellBinder:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_LOGIN" then
		ViksUIBindings = _G.ViksUIBindings or {}
		ViksUIBindings[UnitName("player")] = _G.ViksUIBindings[UnitName("player")] or {}
		DB = ViksUIBindings[UnitName("player")]
		DB.spells = DB.spells or {}
		DB.keys = DB.keys or {}
		SpellBinder.frames = SpellBinder.frames or {}
		SpellBinder:makeFramesList()
		SpellBinder:makeSpellsList(true)

		for i = 1, SPELLS_PER_PAGE do
			local parent = _G["SpellButton"..i]
			local button = CreateFrame("Button", "SpellBinderFakeButton"..i, parent, "AutoCastShineTemplate")
			button:SetID(parent:GetID())
			button:RegisterForClicks("AnyDown")
			button:SetAllPoints(parent)
			button:SetScript("OnClick", addSpell)

			button:Hide()
			SpellBinder.spellbuttons[i] = button
		end

		self:UnregisterEvent("PLAYER_LOGIN")
	elseif event == "PLAYER_ENTERING_WORLD" or event == "GROUP_ROSTER_UPDATE" or event == "ZONE_CHANGED" or event == "ZONE_CHANGED_NEW_AREA" then
		C_Timer.After(0.5, function() SpellBinder.UpdateAll() end)
	elseif event == "PLAYER_REGEN_ENABLED" then
		SpellBinder.UpdateAll()
		self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	elseif event == "PLAYER_TALENT_UPDATE" then
		if DB then
			for _, spell in ipairs(DB.spells) do
				for frame in pairs(ClickCastFrames) do
					local f
					if frame and type(frame) == "table" then f = frame:GetName() end
					if f then
						if _G[f]:CanChangeAttribute() or _G[f]:CanChangeProtectedState() then
							if _G[f]:GetAttribute(spell.modifier.."type"..spell.button) ~= "menu" then
								if spell.button:find("harmbutton") then
									_G[f]:SetAttribute(spell.modifier..spell.button, nil)
									_G[f]:SetAttribute(spell.modifier.."type-"..spell.spell, nil)
									_G[f]:SetAttribute(spell.modifier.."spell-"..spell.spell, nil)
								else
									_G[f]:SetAttribute(spell.modifier.."type"..spell.button, nil)
									_G[f]:SetAttribute(spell.modifier.."spell"..spell.button, nil)
								end
							end
						end
					end
				end
			end
			SpellBinder:makeSpellsList(true)
		end
	end
end)

if C_AddOns.IsAddOnLoaded("Aurora") then
	local F, C = unpack(Aurora)
	SpellBinder:StripTextures()
	SpellBinderInset:StripTextures()

	SpellBinder.OpenButton:StripTextures()
	SpellBinder.OpenButton:SetNormalTexture("Interface\\ICONS\\Achievement_Guild_Doctorisin")
	SpellBinder.OpenButton:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)

	SpellBinder.OpenButton:SetCheckedTexture(C.media.checked)
	SpellBinder.OpenButton:GetHighlightTexture():SetColorTexture(1, 1, 1, 0.3)
	SpellBinder.OpenButton:GetHighlightTexture():SetAllPoints(SpellBinder.OpenButton:GetNormalTexture())

	F.CreateBG(SpellBinder.OpenButton)
	F.CreateBD(SpellBinder)
	F.ReskinClose(SpellBinderCloseButton)
	F.ReskinScroll(SpellBinderScrollFrameSpellList.ScrollBar)
elseif C.skins.blizzard_frames == true then
	SpellBinder:StripTextures()
	SpellBinder:CreateBackdrop("Transparent")
	SpellBinder.backdrop:SetPoint("TOPLEFT", -18, 0)
	SpellBinder.backdrop:SetPoint("BOTTOMRIGHT", 0, 9)

	SpellBinder.OpenButton:StripTextures()
	SpellBinder.OpenButton:SetNormalTexture("Interface\\ICONS\\Achievement_Guild_Doctorisin")
	SpellBinder.OpenButton:GetNormalTexture():ClearAllPoints()
	SpellBinder.OpenButton:GetNormalTexture():SetPoint("TOPLEFT", 2, -2)
	SpellBinder.OpenButton:GetNormalTexture():SetPoint("BOTTOMRIGHT", -2, 2)
	SpellBinder.OpenButton:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)

	SpellBinder.OpenButton:CreateBackdrop("Default")
	SpellBinder.OpenButton.backdrop:SetAllPoints()
	SpellBinder.OpenButton:StyleButton(true)

	SpellBinderScrollFrameSpellList:StripTextures()
	SpellBinderScrollFrameSpellList:CreateBackdrop("Overlay")
	SpellBinderScrollFrameSpellList.backdrop:SetPoint("TOPLEFT", 2, 3)
	SpellBinderScrollFrameSpellList.backdrop:SetPoint("BOTTOMRIGHT", 2, -3)
	T.SkinCloseButton(SpellBinderCloseButton)

	SpellBinderScrollFrameSpellList.ScrollBar:SetPoint("TOPLEFT", SpellBinderScrollFrameSpellList, "TOPRIGHT", 9, 3)
	SpellBinderScrollFrameSpellList.ScrollBar:SetPoint("BOTTOMLEFT", SpellBinderScrollFrameSpellList, "BOTTOMRIGHT", 9, -4)
	T.SkinScrollBar(SpellBinderScrollFrameSpellList.ScrollBar)
end