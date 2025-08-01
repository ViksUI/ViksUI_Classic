local T, C, L = unpack(ViksUI)
if C_AddOns.IsAddOnLoaded("ncHoverBind") then return end

----------------------------------------------------------------------------------------
--	Binding buttons(ncHoverBind by Nightcracker)
----------------------------------------------------------------------------------------
local bind, oneBind, localmacros = CreateFrame("Frame", "HoverBind", UIParent), true, 0

SlashCmdList.MOUSEOVERBIND = function()
	if InCombatLockdown() then print("|cffffff00"..ERR_NOT_IN_COMBAT.."|r") return end
	if not bind.loaded then
		bind:SetFrameStrata("DIALOG")
		bind:EnableMouse(true)
		bind:EnableKeyboard(true)
		bind:EnableMouseWheel(true)
		bind.texture = bind:CreateTexture()
		bind.texture:SetPoint("TOPLEFT", bind, 2, -2)
		bind.texture:SetPoint("BOTTOMRIGHT", bind, -2, 2)
		bind.texture:SetColorTexture(1, 1, 1, 0.3)
		bind:Hide()

		local elapsed = 0
		GameTooltip:HookScript("OnUpdate", function(self, e)
			elapsed = elapsed + e
			if elapsed < 0.2 then return else elapsed = 0 end
			if not self.comparing and IsModifiedClick("COMPAREITEMS") then
				GameTooltip_ShowCompareItem(self)
				self.comparing = true
			elseif self.comparing and not IsModifiedClick("COMPAREITEMS") then
				for _, frame in pairs(self.shoppingTooltips) do
					frame:Hide()
				end
				self.comparing = false
			end
		end)

		hooksecurefunc(GameTooltip, "Hide", function(self) for _, tt in pairs(self.shoppingTooltips) do tt:Hide() end end)

		bind:SetScript("OnEnter", function()
			GameTooltip:SetOwner(bind, "ANCHOR_NONE")
			GameTooltip:SetPoint("BOTTOM", bind, "TOP", 0, 2)
			GameTooltip:AddLine(bind.button.name, 1, 1, 1)

			if #bind.button.bindings == 0 then
				GameTooltip:AddLine(L_BIND_NO_SET, 0.6, 0.6, 0.6)
			else
				GameTooltip:AddDoubleLine(L_BIND_BINDING, L_BIND_KEY, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6)
				for i = 1, #bind.button.bindings do
					GameTooltip:AddDoubleLine(i, bind.button.bindings[i])
				end
			end
			GameTooltip:Show()
		end)

		bind:SetScript("OnEvent", function(self) self:Deactivate(false) end)
		bind:SetScript("OnLeave", function(self) self:HideFrame() end)
		bind:SetScript("OnKeyDown", function(self, key) self:Listener(key) end)
		bind:SetScript("OnMouseDown", function(self, key) self:Listener(key) end)
		bind:SetScript("OnMouseWheel", function(self, delta) if delta > 0 then self:Listener("MOUSEWHEELUP") else self:Listener("MOUSEWHEELDOWN") end end)

		function bind:Update(b, spellmacro)
			if not self.enabled or InCombatLockdown() then return end
			self.button = b
			self.spellmacro = spellmacro

			self:ClearAllPoints()
			self:SetAllPoints(b)
			self:Show()

			ShoppingTooltip1:Hide()

			if spellmacro == "SPELL" then
				self.button.id = SpellBook_GetSpellBookSlot(self.button)
				self.button.name = GetSpellBookItemName(self.button.id, SpellBookFrame.bookType)

				GameTooltip:Show()
				GameTooltip:SetScript("OnHide", function(self)
					self:SetOwner(bind, "ANCHOR_NONE")
					self:SetPoint("BOTTOM", bind, "TOP", 0, 1)
					self:AddLine(bind.button.name, 1, 1, 1)
					bind.button.bindings = {GetBindingKey(spellmacro.." "..bind.button.name)}
					if #bind.button.bindings == 0 then
						self:AddLine(L_BIND_NO_SET, 0.6, 0.6, 0.6)
					else
						self:AddDoubleLine(L_BIND_BINDING, L_BIND_KEY, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6)
						for i = 1, #bind.button.bindings do
							self:AddDoubleLine(i, bind.button.bindings[i])
						end
					end
					self:Show()
					self:SetScript("OnHide", nil)
				end)
			elseif spellmacro == "MACRO" then
				self.button.id = self.button.selectionIndex or self.button:GetID()

				if localmacros == 1 then self.button.id = self.button.id + MAX_ACCOUNT_MACROS end

				self.button.name = GetMacroInfo(self.button.id)

				GameTooltip:SetOwner(bind, "ANCHOR_NONE")
				GameTooltip:SetPoint("BOTTOM", bind, "TOP", 0, 1)
				GameTooltip:AddLine(bind.button.name, 1, 1, 1)

				bind.button.bindings = {GetBindingKey(spellmacro.." "..bind.button.name)}
				if #bind.button.bindings == 0 then
					GameTooltip:AddLine(L_BIND_NO_SET, 0.6, 0.6, 0.6)
				else
					GameTooltip:AddDoubleLine(L_BIND_BINDING, L_BIND_KEY, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6)
					for i = 1, #bind.button.bindings do
						GameTooltip:AddDoubleLine(i, bind.button.bindings[i], 1, 1, 1)
					end
				end
				GameTooltip:Show()
			elseif spellmacro == "STANCE" or spellmacro == "PET" then
				self.button.id = tonumber(b:GetID())
				self.button.name = b:GetName()

				if not self.button.name then return end

				if not self.button.id or self.button.id < 1 or self.button.id > (spellmacro == "STANCE" and 10 or 12) then
					self.button.bindstring = "CLICK "..self.button.name..":LeftButton"
				else
					self.button.bindstring = (spellmacro == "STANCE" and "SHAPESHIFTBUTTON" or "BONUSACTIONBUTTON")..self.button.id
				end

				GameTooltip:Show()
				GameTooltip:SetScript("OnHide", function(self)
					self:SetOwner(bind, "ANCHOR_NONE")
					self:SetPoint("BOTTOM", bind, "TOP", 0, 1)
					self:AddLine(bind.button.name, 1, 1, 1)
					bind.button.bindings = {GetBindingKey(bind.button.bindstring)}
					if #bind.button.bindings == 0 then
						self:AddLine(L_BIND_NO_SET, 0.6, 0.6, 0.6)
					else
						self:AddDoubleLine(L_BIND_BINDING, L_BIND_KEY, 0.6, 0.6, 0.6, 0.6, 0.6, 0.6)
						for i = 1, #bind.button.bindings do
							self:AddDoubleLine(i, bind.button.bindings[i])
						end
					end
					self:Show()
					self:SetScript("OnHide", nil)
				end)
			else
				self.button.action = tonumber(b.action)
				self.button.name = b:GetName()

				if not self.button.name then return end

				if not self.button.action or self.button.action < 1 or self.button.action > 132 then
					self.button.bindstring = "CLICK "..self.button.name..":LeftButton"
				else
					local modact = 1 + (self.button.action - 1) % 12
					if self.button.name == "ExtraActionButton1" then
						self.button.bindstring = "EXTRAACTIONBUTTON1"
					elseif self.button.action < 13 or self.button.action > 72 then
						self.button.bindstring = "ACTIONBUTTON"..modact
					elseif self.button.action < 73 and self.button.action > 60 then
						self.button.bindstring = "MULTIACTIONBAR1BUTTON"..modact
					elseif self.button.action < 61 and self.button.action > 48 then
						self.button.bindstring = "MULTIACTIONBAR2BUTTON"..modact
					elseif self.button.action < 49 and self.button.action > 36 then
						self.button.bindstring = "MULTIACTIONBAR4BUTTON"..modact
					elseif self.button.action < 37 and self.button.action > 24 then
						self.button.bindstring = "MULTIACTIONBAR3BUTTON"..modact
					elseif self.button.action < 25 and self.button.action > 12 then
						self.button.bindstring = "CLICK "..self.button.name..":LeftButton"
					end
				end

				bind.button.bindings = {GetBindingKey(bind.button.bindstring)}
				bind:GetScript("OnEnter")()
			end
		end

		function bind:Listener(key)
			if GetBindingKey(key) == "OPENCHAT" then
				DEFAULT_CHAT_FRAME.editBox:Show()
				return
			end
			if GetBindingByKey(key) == "SCREENSHOT" then
				RunBinding("SCREENSHOT")
				return
			end
			if #self.button.bindings > 0 and oneBind then
				for i = 1, #self.button.bindings do
					SetBinding(self.button.bindings[i])
				end
				self:Update(self.button, self.spellmacro)
				if self.spellmacro ~= "MACRO" then GameTooltip:Hide() end
			end
			if key == "ESCAPE" or key == "RightButton" then
				for i = 1, #self.button.bindings do
					SetBinding(self.button.bindings[i])
				end
				print("|cffffff00"..L_BIND_CLEARED.."|r".." |cff00ff00"..self.button.name.."|r|cffffff00.|r")
				self:Update(self.button, self.spellmacro)
				if self.spellmacro ~= "MACRO" then GameTooltip:Hide() end
				return
			end

			if key == "LSHIFT" or key == "RSHIFT" or key == "LCTRL" or key == "RCTRL" or key == "LALT"
			or key == "RALT" or key == "UNKNOWN" or key == "LeftButton" then return end
			if key == "MiddleButton" then key = "BUTTON3" end
			if key:find("Button%d") then key = key:upper() end

			local alt = IsAltKeyDown() and "ALT-" or ""
			local ctrl = IsControlKeyDown() and "CTRL-" or ""
			local shift = IsShiftKeyDown() and "SHIFT-" or ""

			if not self.spellmacro or self.spellmacro == "PET" or self.spellmacro == "STANCE" then
				SetBinding(alt..ctrl..shift..key, self.button.bindstring)
			else
				SetBinding(alt..ctrl..shift..key, self.spellmacro.." "..self.button.name)
			end
			print(alt..ctrl..shift..key.." |cff00ff00bound to |r"..self.button.name..".")
			self:Update(self.button, self.spellmacro)
			if self.spellmacro ~= "MACRO" then GameTooltip:Hide() end
		end

		function bind:HideFrame()
			self:ClearAllPoints()
			self:Hide()
			GameTooltip:Hide()
		end

		function bind:Activate()
			self.enabled = true
			self:RegisterEvent("PLAYER_REGEN_DISABLED")
			if C.actionbar.enable then
				if C.actionbar.bottombars_mouseover == true then
					BottomBarMouseOver(1)
				end
				if C.actionbar.rightbars_mouseover == true then
					RightBarMouseOver(1)
				end
				if C.actionbar.stancebar_mouseover == true then
					StanceBarMouseOver(1)
				end
				if C.actionbar.petbar_mouseover == true and C.actionbar.petbar_horizontal == true then
					PetBarMouseOver(1)
				end
				if T.Mainline and C.actionbar.bar7_enable and C.actionbar.bar7_mouseover then
					Bar7MouseOver(1)
				end
				if T.Mainline and C.actionbar.bar8_enable and C.actionbar.bar8_mouseover then
					Bar8MouseOver(1)
				end
			end
		end

		function bind:Deactivate(save)
			local which = GetCurrentBindingSet()
			if save then
				SaveBindings(which)
				print("|cffffff00"..L_BIND_SAVED.."|r")
			else
				LoadBindings(which)
				print("|cffffff00"..L_BIND_DISCARD.."|r")
			end
			self.enabled = false
			self:HideFrame()
			self:UnregisterEvent("PLAYER_REGEN_DISABLED")
			StaticPopup_Hide("KEYBIND_MODE")
			if C.actionbar.enable then
				if C.actionbar.bottombars_mouseover == true then
					BottomBarMouseOver(0)
				end
				if C.actionbar.rightbars_mouseover == true then
					RightBarMouseOver(0)
				end
				if C.actionbar.stancebar_mouseover == true and C.actionbar.stancebar_horizontal == true and C.actionbar.stancebar_hide ~= true then
					StanceBarMouseOver(C.actionbar.stancebar_mouseover_alpha)
				end
				if C.actionbar.petbar_mouseover == true and C.actionbar.petbar_horizontal == true then
					PetBarMouseOver(0)
				end
				if T.Mainline and C.actionbar.bar7_enable and C.actionbar.bar7_mouseover then
					Bar7MouseOver(0)
				end
				if T.Mainline and C.actionbar.bar8_enable and C.actionbar.bar8_mouseover then
					Bar8MouseOver(0)
				end
			end
		end

		StaticPopupDialogs.KEYBIND_MODE = {
			text = L_BIND_INSTRUCT,
			button1 = APPLY,
			button2 = CANCEL,
			OnAccept = function() bind:Deactivate(true) ReloadUI() end,
			OnCancel = function() bind:Deactivate(false) end,
			timeout = 0,
			whileDead = 1,
			hideOnEscape = false,
			preferredIndex = STATICPOPUPS_NUMDIALOGS,
		}

		-- Registering
		for i = 1, 12 do
			local b = _G["ActionButton"..i]
			b:HookScript("OnEnter", function(self) bind:Update(self) end)

			b = _G["MultiBarBottomLeftButton"..i]
			b:HookScript("OnEnter", function(self) bind:Update(self) end)

			b = _G["MultiBarLeftButton"..i]
			b:HookScript("OnEnter", function(self) bind:Update(self) end)

			b = _G["MultiBarRightButton"..i]
			b:HookScript("OnEnter", function(self) bind:Update(self) end)

			b = _G["MultiBarBottomRightButton"..i]
			b:HookScript("OnEnter", function(self) bind:Update(self) end)

			if T.Mainline then
				b = _G["MultiBar5Button"..i]
				b:HookScript("OnEnter", function(self) bind:Update(self) end)
			end
		end

		if T.Mainline and C.actionbar.bar7_enable then
			for i = 1, 12 do
				local b = _G["MultiBar6Button"..i]
				b:HookScript("OnEnter", function(self) bind:Update(self) end)
			end
		end

		if T.Mainline and C.actionbar.bar8_enable then
			for i = 1, 12 do
				local b = _G["MultiBar7Button"..i]
				b:HookScript("OnEnter", function(self) bind:Update(self) end)
			end
		end

		for i = 1, 10 do
			local b = _G["StanceButton"..i]
			b:HookScript("OnEnter", function(self) bind:Update(self, "STANCE") end)
		end

		for i = 1, NUM_PET_ACTION_SLOTS do
			local b = _G["PetActionButton"..i]
			b:HookScript("OnEnter", function(self) bind:Update(self, "PET") end)
		end

		for i = 1, 12 do
			local b = _G["SpellButton"..i]
			b:HookScript("OnEnter", function(self) bind:Update(self, "SPELL") end)
		end

		if T.Mainline then
			ExtraActionButton1:HookScript("OnEnter", function(self) bind:Update(self) end)
		end

		local function registermacro()
			hooksecurefunc(MacroFrame, "Update", function(frame)
				for _, button in next, {frame.MacroSelector.ScrollBox.ScrollTarget:GetChildren()} do
					if button and not button.hook then
						button:HookScript("OnEnter", function(self) bind:Update(button, "MACRO") end)
						button.hook = true
					end
				end
			end)

			MacroFrameTab1:HookScript("OnMouseUp", function() localmacros = 0 end)
			MacroFrameTab2:HookScript("OnMouseUp", function() localmacros = 1 end)
		end

		if not C_AddOns.IsAddOnLoaded("Blizzard_MacroUI") then
			hooksecurefunc("LoadAddOn", function(addon)
				if addon == "Blizzard_MacroUI" then
					registermacro()
				end
			end)
		else
			registermacro()
		end
		bind.loaded = 1
	end
	if not bind.enabled then
		bind:Activate()
		StaticPopup_Show("KEYBIND_MODE")
	end
end

SLASH_MOUSEOVERBIND1 = "/bindkey"
SLASH_MOUSEOVERBIND2 = "/hoverbind"
SLASH_MOUSEOVERBIND3 = "/bk"

if not C_AddOns.IsAddOnLoaded("Bartender4") and not C_AddOns.IsAddOnLoaded("Dominos") then
	SLASH_MOUSEOVERBIND4 = "/kb"
end

if not C_AddOns.IsAddOnLoaded("HealBot") then
	SLASH_MOUSEOVERBIND5 = "/hb"
end
