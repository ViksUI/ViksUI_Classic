local T, C, L = unpack(ViksUI)
if C.actionbar.enable ~= true then return end

----------------------------------------------------------------------------------------
--	PetActionBar(by Tukz)
----------------------------------------------------------------------------------------
-- Hide bar
if C.actionbar.petbar_hide then PetActionBarAnchor:Hide() return end

-- Create bar
local bar = CreateFrame("Frame", "PetHolder", UIParent, "SecureHandlerStateTemplate")
bar:SetAllPoints(PetActionBarAnchor)

bar:RegisterEvent("PLAYER_LOGIN")
bar:RegisterEvent("PLAYER_CONTROL_LOST")
bar:RegisterEvent("PLAYER_CONTROL_GAINED")
bar:RegisterEvent("PLAYER_FARSIGHT_FOCUS_CHANGED")
bar:RegisterEvent("PET_BAR_UPDATE")
bar:RegisterEvent("PET_BAR_UPDATE_USABLE")
bar:RegisterEvent("PET_BAR_UPDATE_COOLDOWN")
bar:RegisterEvent("SPELLS_CHANGED")
bar:RegisterUnitEvent("UNIT_PET", "player", "")
bar:RegisterEvent("UNIT_FLAGS")
bar:RegisterUnitEvent("UNIT_AURA", "pet", "")
bar:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_LOGIN" then
		T.StylePet()
		PetActionBar_ShowGrid = T.dummy
		PetActionBar_HideGrid = T.dummy
		if T.Classic then
			PetActionBarFrame.showgrid = nil
		else
			PetActionBar.showgrid = nil
		end
		for i = 1, 10 do
			local button = _G["PetActionButton"..i]
			button:ClearAllPoints()
			button:SetParent(self)
			if i == 1 then
				if C.actionbar.petbar_horizontal == true then
					button:SetPoint("BOTTOMLEFT", 0, 0)
				else
					button:SetPoint("TOPLEFT", 0, 0)
				end
			else
				local previous = _G["PetActionButton"..i-1]
				if C.actionbar.petbar_horizontal == true then
					button:SetPoint("LEFT", previous, "RIGHT", C.actionbar.button_space, 0)
				else
					button:SetPoint("TOP", previous, "BOTTOM", 0, -C.actionbar.button_space)
				end
			end
			button:Show()
			self:SetAttribute("addchild", button)
		end
		if T.Classic then
			RegisterStateDriver(self, "visibility", "[pet,nooverridebar,novehicleui,nopossessbar] show; hide")
		else
			RegisterStateDriver(self, "visibility", "[pet,novehicleui,nopossessbar,nopetbattle] show; hide")
		end
		if T.Classic then
			hooksecurefunc("PetActionBar_Update", T.PetBarUpdate)
		else
			hooksecurefunc(PetActionBar, "Update", T.PetBarUpdate)
		end
	elseif event == "PET_BAR_UPDATE" or event == "PLAYER_CONTROL_LOST" or event == "PLAYER_CONTROL_GAINED" or event == "PLAYER_FARSIGHT_FOCUS_CHANGED"
	or event == "UNIT_FLAGS" or event == "UNIT_PET" or event == "UNIT_AURA" then
		T.PetBarUpdate()
	elseif event == "PET_BAR_UPDATE_COOLDOWN" then
		if T.Classic then
			PetActionBar_UpdateCooldowns()
		else
			PetActionBar:UpdateCooldowns()
		end
	end
end)

hooksecurefunc(PetActionButton10, "SetPoint", function(_, _, anchor)
	if InCombatLockdown() then return end
	if anchor and anchor == PetActionBar then
		for i = 1, 10 do
			local button = _G["PetActionButton"..i]
			button:ClearAllPoints()
			if i == 1 then
				if C.actionbar.petbar_horizontal == true then
					button:SetPoint("BOTTOMLEFT", 0, 0)
				else
					button:SetPoint("TOPLEFT", 0, 0)
				end
			else
				local previous = _G["PetActionButton"..i-1]
				if C.actionbar.petbar_horizontal == true then
					button:SetPoint("LEFT", previous, "RIGHT", C.actionbar.button_space, 0)
				else
					button:SetPoint("TOP", previous, "BOTTOM", 0, -C.actionbar.button_space)
				end
			end
		end
	end
end)

-- Mouseover bar
if C.actionbar.rightbars_mouseover == true and C.actionbar.petbar_horizontal == false then
	PetActionBarAnchor:SetAlpha(0)
	PetActionBarAnchor:SetScript("OnEnter", function() if PetHolder:IsShown() then RightBarMouseOver(1) end end)
	PetActionBarAnchor:SetScript("OnLeave", function() if not HoverBind.enabled then RightBarMouseOver(0) end end)
	for i = 1, NUM_PET_ACTION_SLOTS do
		local b = _G["PetActionButton"..i]
		b:SetAlpha(0)
		b:HookScript("OnEnter", function() RightBarMouseOver(1) end)
		b:HookScript("OnLeave", function() if not HoverBind.enabled then RightBarMouseOver(0) end end)
	end
end
if C.actionbar.petbar_mouseover == true and (C.actionbar.petbar_horizontal == true or C.actionbar.editor) then
	PetActionBarAnchor:SetAlpha(0)
	PetActionBarAnchor:SetScript("OnEnter", function() PetBarMouseOver(1) end)
	PetActionBarAnchor:SetScript("OnLeave", function() if not HoverBind.enabled then PetBarMouseOver(0) end end)
	for i = 1, NUM_PET_ACTION_SLOTS do
		local b = _G["PetActionButton"..i]
		b:SetAlpha(0)
		b:HookScript("OnEnter", function() PetBarMouseOver(1) end)
		b:HookScript("OnLeave", function() if not HoverBind.enabled then PetBarMouseOver(0) end end)
	end
end