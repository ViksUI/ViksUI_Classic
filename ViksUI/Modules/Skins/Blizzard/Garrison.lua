local T, C, L = unpack(ViksUI)

----------------------------------------------------------------------------------------
--	Garrison, OrderHall and BFA Mission skin
----------------------------------------------------------------------------------------
local LoadTootlipSkin = CreateFrame("Frame")
LoadTootlipSkin:RegisterEvent("ADDON_LOADED")
LoadTootlipSkin:SetScript("OnEvent", function(self, _, addon)
	if C_AddOns.IsAddOnLoaded("Skinner") or C_AddOns.IsAddOnLoaded("Aurora") or not C.tooltip.enable then
		self:UnregisterEvent("ADDON_LOADED")
		return
	end

	if addon == "ViksUI" then
		local Tooltips = {
			FloatingGarrisonFollowerTooltip,
			FloatingGarrisonFollowerAbilityTooltip,
			FloatingGarrisonMissionTooltip,
			FloatingGarrisonShipyardFollowerTooltip,
			GarrisonFollowerTooltip,
			GarrisonFollowerAbilityTooltip,
			GarrisonShipyardFollowerTooltip,
			GarrisonFollowerMissionAbilityWithoutCountersTooltip,
			GarrisonFollowerAbilityWithoutCountersTooltip
		}

		for _, tt in pairs(Tooltips) do
			tt.NineSlice:SetAlpha(0)
			tt:SetTemplate("Transparent")
		end
		T.SkinCloseButton(FloatingGarrisonFollowerTooltip.CloseButton)
		T.SkinCloseButton(FloatingGarrisonFollowerAbilityTooltip.CloseButton)
		T.SkinCloseButton(FloatingGarrisonMissionTooltip.CloseButton)
		T.SkinCloseButton(FloatingGarrisonShipyardFollowerTooltip.CloseButton)

		GarrisonFollowerMissionAbilityWithoutCountersTooltip.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		GarrisonFollowerAbilityWithoutCountersTooltip.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	end

	if addon == "Blizzard_GarrisonUI" then
		GarrisonBuildingFrame.BuildingLevelTooltip:StripTextures()
		GarrisonBuildingFrame.BuildingLevelTooltip:SetTemplate("Transparent")

		GarrisonShipyardMapMissionTooltip:StripTextures()
		GarrisonShipyardMapMissionTooltip:SetTemplate("Transparent")
		GarrisonShipyardMapMissionTooltip.ItemTooltip.IconBorder:SetAlpha(0)
		GarrisonShipyardMapMissionTooltip.ItemTooltip.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

		GarrisonMissionMechanicFollowerCounterTooltip:HookScript("OnShow", function(self)
			self:SetTemplate("Transparent")
		end)
		GarrisonMissionMechanicTooltip:HookScript("OnShow", function(self)
			self:SetTemplate("Transparent")
		end)

		GarrisonLandingPage.FollowerTab.AbilitiesFrame.FlavorText:SetFontObject(SystemFont_Shadow_Med3)
	end
end)

if C.skins.blizzard_frames ~= true then return end

local function LoadSkin()
	-- Garrison Building frame
	GarrisonBuildingFrame:StripTextures()
	GarrisonBuildingFrame:SetTemplate("Transparent")
	T.SkinCloseButton(GarrisonBuildingFrame.CloseButton)
	GarrisonBuildingFrame.GarrCorners:Hide()

	for _, button in pairs({GarrisonBuildingFrame.TownHallBox.UpgradeButton, GarrisonBuildingFrame.InfoBox.UpgradeButton}) do
		button:StripTextures(true)
		button:SkinButton()
	end

	-- Confirmation popup
	local Confirmation = GarrisonBuildingFrame.Confirmation
	Confirmation:StripTextures()
	Confirmation:SetTemplate("Transparent")

	Confirmation.CancelButton:SkinButton()
	Confirmation.BuildButton:SkinButton()
	Confirmation.UpgradeButton:SkinButton()
	Confirmation.UpgradeGarrisonButton:SkinButton()
	Confirmation.ReplaceButton:SkinButton()
	Confirmation.SwitchButton:SkinButton()

	-- Mission UI
	GarrisonMissionFrame:StripTextures()
	GarrisonMissionFrame.GarrCorners:StripTextures()
	GarrisonMissionFrame.TitleText:Show()
	GarrisonMissionFrame:SetTemplate("Transparent")
	T.SkinCloseButton(GarrisonMissionFrame.CloseButton)
	GarrisonMissionFrameTab1:SetPoint("BOTTOMLEFT", GarrisonMissionFrame, "BOTTOMLEFT", 11, -40)
	T.SkinTab(GarrisonMissionFrameTab1)
	T.SkinTab(GarrisonMissionFrameTab2)

	-- Mission list
	local MissionTab = GarrisonMissionFrame.MissionTab
	local MissionList = MissionTab.MissionList
	local MissionPage = GarrisonMissionFrame.MissionTab.MissionPage
	MissionList:DisableDrawLayer("BORDER")
	T.SkinScrollBar(GarrisonMissionFrameMissions.ScrollBar)
	T.SkinCloseButton(MissionPage.CloseButton)
	MissionPage.CloseButton:SetFrameLevel(MissionPage:GetFrameLevel() + 2)
	MissionList.CompleteDialog.BorderFrame.ViewButton:SkinButton()
	GarrisonMissionFrame.MissionComplete.NextMissionButton:SkinButton()

	local function SkinTab(tab)
		tab:StripTextures()
		tab:StyleButton()
		tab:CreateBackdrop("Overlay")
		tab.backdrop:SetAllPoints()
		tab:SetHeight(tab:GetHeight() - 10)
	end

	SkinTab(GarrisonMissionFrameMissionsTab1)
	SkinTab(GarrisonMissionFrameMissionsTab2)
	GarrisonMissionFrameMissionsTab1:SetPoint("BOTTOMLEFT", GarrisonMissionFrameMissions, "TOPLEFT", 18, 0)
	GarrisonMissionFrameMissionsTab1.backdrop:SetBackdropBorderColor(1, 0.82, 0, 1)
	GarrisonMissionFrameMissionsTab1.backdrop.overlay:SetVertexColor(1 * 0.3, 0.82 * 0.3, 0, 1)

	hooksecurefunc("GarrisonMissonListTab_SetSelected", function(tab, isSelected)
		if isSelected then
			tab.backdrop:SetBackdropBorderColor(1, 0.82, 0, 1)
			tab.backdrop.overlay:SetVertexColor(1 * 0.3, 0.82 * 0.3, 0, 1)
		else
			tab.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
			tab.backdrop.overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
		end
	end)

	hooksecurefunc(GarrisonMissionFrame.MissionTab.MissionList.ScrollBox, "Update", function(frame)
		for i = 1, frame.ScrollTarget:GetNumChildren() do
			local button = select(i, frame.ScrollTarget:GetChildren())
			if not button.backdrop then
				button:StripTextures()
				button:CreateBackdrop("Overlay")
				button.backdrop:SetPoint("TOPLEFT", 0, 0)
				button.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)
				button:StyleButton(nil, 2)
			end
		end
	end)

	GarrisonMissionFrameFollowers:StripTextures()
	GarrisonMissionFrameFollowers:SetTemplate("Transparent")
	T.SkinEditBox(GarrisonMissionFrameFollowers.SearchBox)
	GarrisonMissionFrameFollowers.SearchBox:SetPoint("TOPLEFT", 2, 25)
	GarrisonMissionFrameFollowers.SearchBox:SetSize(301, 20)
	T.SkinScrollBar(GarrisonMissionFrameFollowers.ScrollBar)
	GarrisonMissionFrameFollowers.MaterialFrame:GetRegions():Hide()
	GarrisonMissionFrameMissions.MaterialFrame:GetRegions():Hide()

	GarrisonMissionFrameFollowers.ScrollBar:SetPoint("TOPLEFT", GarrisonMissionFrameFollowers.ScrollBox, "TOPRIGHT", -6, 3)
	GarrisonMissionFrameFollowers.ScrollBar:SetPoint("BOTTOMLEFT", GarrisonMissionFrameFollowers.ScrollBox, "BOTTOMRIGHT", -3, -1)

	GarrisonMissionFrame.FollowerTab:StripTextures()
	GarrisonMissionFrame.FollowerTab:SetTemplate("Overlay")

	for _, item in pairs({GarrisonMissionFrame.FollowerTab.ItemWeapon, GarrisonMissionFrame.FollowerTab.ItemArmor}) do
		item.Border:Hide()
		item.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		item:CreateBackdrop("Default")
		item.backdrop:SetPoint("TOPLEFT", item.Icon, "TOPLEFT", -2, 2)
		item.backdrop:SetPoint("BOTTOMRIGHT", item.Icon, "BOTTOMRIGHT", 2, -2)
		item.backdrop:SetFrameLevel(item:GetFrameLevel())
	end

	MissionPage.StartMissionButton:SkinButton()

	local function HandleGarrisonPortrait(portrait)
		if not portrait.Portrait then return end

		local size = portrait.Portrait:GetSize() + 2
		portrait:SetSize(size, size)

		if not portrait.backdrop then
			portrait:CreateBackdrop("Default")
			portrait.backdrop:SetPoint("TOPLEFT", portrait, "TOPLEFT", -1, 1)
			portrait.backdrop:SetPoint("BOTTOMRIGHT", portrait, "BOTTOMRIGHT", 1, -1)
			portrait.backdrop:SetFrameLevel(portrait:GetFrameLevel())
		end

		portrait.Portrait:SetTexCoord(0.2, 0.85, 0.2, 0.85)
		portrait.Portrait:ClearAllPoints()
		portrait.Portrait:SetInside(portrait.backdrop)

		if portrait.PortraitRing then
			portrait.PortraitRing:Hide()
			portrait.PortraitRingQuality:SetTexture("")
			portrait.PortraitRingCover:SetTexture("")
		end

		if portrait.PuckBorder then portrait.PuckBorder:SetAlpha(0) end
		if portrait.TroopStackBorder2 then portrait.TroopStackBorder2:SetAlpha(0) end

		local level = portrait.Level or portrait.LevelText
		if level then
			level:ClearAllPoints()
			level:SetPoint("BOTTOM", 0, 1)
			level:SetFontObject("SystemFont_Outline_Small")
			if portrait.LevelCircle then portrait.LevelCircle:Hide() end
			if portrait.LevelBorder then portrait.LevelBorder:SetScale(0.0001) end
		end

		if portrait.HealthBar then
			portrait.HealthBar.Border:Hide()

			local roleIcon = portrait.HealthBar.RoleIcon
			roleIcon:ClearAllPoints()
			roleIcon:SetPoint("TOPRIGHT", portrait.backdrop, "TOPRIGHT", 4, 4)

			local background = portrait.HealthBar.Background
			background:SetAlpha(0)
			background:ClearAllPoints()
			background:SetPoint("TOPLEFT", portrait.backdrop, "BOTTOMLEFT", 0, -3)
			background:SetPoint("BOTTOMRIGHT", portrait.backdrop, "BOTTOMRIGHT", -0, -6)
			portrait.HealthBar.Health:SetTexture(C.media.texture)

			portrait.CircleMask:Hide()
		end
	end

	HandleGarrisonPortrait(GarrisonMissionFrame.FollowerTab.PortraitFrame)

	hooksecurefunc("GarrisonFollowerList_InitButton", function(frame, elementData)
		local follower = frame.Follower
		if follower and not follower.backdrop then
			follower:CreateBackdrop("Overlay")
			follower.backdrop:SetPoint("TOPLEFT", 0, 0)
			follower.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)
			follower:StyleButton()

			follower.BG:Hide()
			follower.Selection:SetTexture("")
			follower.AbilitiesBG:SetTexture("")
			follower.BusyFrame:SetAllPoints()
			follower.Name:SetWordWrap(false)

			if follower.PortraitFrame then
				HandleGarrisonPortrait(follower.PortraitFrame)
				follower.PortraitFrame:ClearAllPoints()
				follower.PortraitFrame:SetPoint("TOPLEFT", 6, -5)
			end
		end

		local counters = follower.Counters
		if counters then
			for _, counter in next, counters do
				if counter and not counter.styled then
					-- counter:SetTemplate("Default") -- FIXME looks ugly, not pixelperfect

					if counter.Border then
						counter.Border:SetTexture("")
					end

					if counter.Icon then
						counter.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
						counter.Icon:SetInside()
					end
					counter.styled = true
				end
			end
		end

		if follower then
			if follower.Selection and follower.backdrop then
				if follower.Selection:IsShown() then
					follower.backdrop:SetBackdropBorderColor(1, 0.82, 0, 1)
					follower.backdrop.overlay:SetVertexColor(1 * 0.3, 0.82 * 0.3, 0, 1)
					follower.PortraitFrame.backdrop:SetBackdropBorderColor(1, 0.82, 0, 1)
				else
					follower.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
					follower.backdrop.overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
					follower.PortraitFrame.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
				end
			end

			local color = ITEM_QUALITY_COLORS[follower.PortraitFrame.quality]
			if color then
				follower.Name:SetTextColor(color.r, color.g, color.b)
			else
				follower.Name:SetTextColor(1, 1, 1)
			end
		end
	end)

	hooksecurefunc("GarrisonFollowerButton_AddAbility", function(self, index)
		local ability = self.Abilities[index]
		if not ability.skinned then
			ability.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			ability.skinned = true
		end
	end)

	-- Set border color according to rarity of item
	hooksecurefunc("GarrisonMissionButton_SetRewards", function(self)
		local firstRegion, r, g, b
		local index = 0
		for _, reward in pairs(self.Rewards) do
			firstRegion = reward.GetRegions and reward:GetRegions()
			if firstRegion then firstRegion:Hide() end

			reward:ClearAllPoints()
			if C_AddOns.IsAddOnLoaded("GarrisonMissionManager") then
				reward:SetPoint("TOPRIGHT", -T.mult * 65 + (index * -65), -T.mult)
			else
				reward:SetPoint("TOPRIGHT", -T.mult + (index * -65), -T.mult)
			end

			if reward.IconBorder then
				reward.IconBorder:SetTexture(nil)
			end

			if reward.IconBorder and reward.IconBorder:IsShown() then
				r, g, b = reward.IconBorder:GetVertexColor()
			else
				r, g, b = unpack(C.media.border_color)
			end

			if (r > 0.64 and r < 0.67) or (r > 0.99 and g > 0.99 and b > 0.99) then
				r, g, b = unpack(C.media.border_color)
			end

			if not reward.backdrop then
				reward.Icon:SkinIcon()
				reward.backdrop:SetFrameLevel(reward:GetFrameLevel())
			end
			reward.backdrop:SetBackdropBorderColor(r, g, b)
			index = index + 1
		end
	end)

	hooksecurefunc("GarrisonMissionPage_SetReward", function(frame)
		frame.BG:Hide()
		frame.IconBorder:SetTexture("")
		if not frame.backdrop then
			frame.Icon:SkinIcon()
			frame.backdrop:SetFrameLevel(frame:GetFrameLevel())
		end
		frame.Icon:SetDrawLayer("BORDER", 0)

		local r, g, b
		if frame.IconBorder and frame.IconBorder:IsShown() then
			r, g, b = frame.IconBorder:GetVertexColor()
			if (r > 0.64 and r < 0.67) or (r > 0.99 and g > 0.99 and b > 0.99) then
				r, g, b = unpack(C.media.border_color)
			end
		else
			r, g, b = unpack(C.media.border_color)
		end
		frame.backdrop:SetBackdropBorderColor(r, g, b)
	end)

	-- Landing page
	GarrisonLandingPage:StripTextures()
	GarrisonLandingPage:CreateBackdrop("Transparent")
	T.SkinCloseButton(GarrisonLandingPage.CloseButton)
	GarrisonLandingPageTab1:SetPoint("TOPLEFT", GarrisonLandingPage, "BOTTOMLEFT", 70, -2)

	for i = 1, 3 do
		T.SkinTab(_G["GarrisonLandingPageTab"..i])
		_G["GarrisonLandingPageTab"..i]:SetHeight(32)
		_G["GarrisonLandingPageTab"..i].Text:ClearAllPoints()
		_G["GarrisonLandingPageTab"..i].Text:SetPoint("CENTER")
	end

	T.SkinScrollBar(GarrisonLandingPageReportList.ScrollBar)

	GarrisonLandingPage.FollowerList:StripTextures()
	GarrisonLandingPage.FollowerList.SearchBox:SetPoint("TOPLEFT", -1, 33)
	T.SkinEditBox(GarrisonLandingPage.FollowerList.SearchBox)
	T.SkinScrollBar(GarrisonLandingPageFollowerList.ScrollBar)

	GarrisonLandingPage.FollowerTab:CreateBackdrop("Overlay")
	GarrisonLandingPage.FollowerTab.backdrop:SetPoint("TOPLEFT", 13, 0)
	GarrisonLandingPage.FollowerTab.backdrop:SetPoint("BOTTOMRIGHT", 2, 3)

	HandleGarrisonPortrait(GarrisonLandingPage.FollowerTab.PortraitFrame)

	GarrisonLandingPageShipFollowerList:StripTextures()
	GarrisonLandingPageShipFollowerList:SetTemplate("Transparent")

	GarrisonLandingPageShipFollowerList.SearchBox:SetPoint("TOPLEFT", 2, 25)
	T.SkinEditBox(GarrisonLandingPageShipFollowerList.SearchBox)
	T.SkinScrollBar(GarrisonLandingPageShipFollowerList.ScrollBar)

	GarrisonLandingPage.Report.InProgress:ClearAllPoints()
	GarrisonLandingPage.Report.InProgress:SetPoint("BOTTOMLEFT", GarrisonLandingPageReportList, "TOPLEFT", 5, 2)
	GarrisonLandingPage.Report.Available:ClearAllPoints()
	GarrisonLandingPage.Report.Available:SetPoint("LEFT", GarrisonLandingPage.Report.InProgress, "RIGHT", 4, 0)

	for _, tab in pairs({GarrisonLandingPage.Report.InProgress, GarrisonLandingPage.Report.Available}) do
		tab:CreateBackdrop("Overlay")
		tab.backdrop:SetAllPoints()
		tab:StyleButton()

		tab.Text:ClearAllPoints()
		tab.Text:SetPoint("CENTER")
		tab.Text:SetFont(C.media.normal_font, 15, "")
	end

	hooksecurefunc("GarrisonLandingPageReport_SetTab", function(self)
		local unselectedTab = GarrisonLandingPage.Report.unselectedTab
		unselectedTab:SetHeight(36)

		self:SetWidth(198)
		unselectedTab:SetWidth(198)

		unselectedTab:SetNormalTexture(0)
		unselectedTab.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
		unselectedTab.backdrop.overlay:SetVertexColor(0.1, 0.1, 0.1, 1)

		self:SetNormalTexture(0)
		self.backdrop:SetBackdropBorderColor(1, 0.82, 0, 1)
		self.backdrop.overlay:SetVertexColor(1 * 0.3, 0.82 * 0.3, 0, 1)
	end)

	hooksecurefunc(GarrisonLandingPage.Report.List.ScrollBox, "Update", function(frame)
		for i = 1, frame.ScrollTarget:GetNumChildren() do
			local button = select(i, frame.ScrollTarget:GetChildren())
			if not button.styled then
				local i = 1
				for _, reward in pairs(button.Rewards) do
					reward:GetRegions():Hide()
					if i == 1 then
						reward:ClearAllPoints()
						reward:SetPoint("TOPRIGHT", -35, -5)
					end
					reward.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

					reward:CreateBackdrop("Default")
					reward.backdrop:SetPoint("TOPLEFT", reward.Icon, "TOPLEFT", -2, 2)
					reward.backdrop:SetPoint("BOTTOMRIGHT", reward.Icon, "BOTTOMRIGHT", 2, -2)
					reward.backdrop:SetFrameLevel(reward:GetFrameLevel())

					reward.Quantity:SetParent(reward.backdrop)
					reward.IconBorder:SetAlpha(0)
					hooksecurefunc(reward.IconBorder, "SetVertexColor", function(self, r, g, b)
						if r ~= BAG_ITEM_QUALITY_COLORS[1].r ~= r and g ~= BAG_ITEM_QUALITY_COLORS[1].g then
							self:GetParent().backdrop:SetBackdropBorderColor(r, g, b)
						else
							self:GetParent().backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
						end
					end)
					i = i + 1
				end
			end
			button.styled = true
		end
	end)

	local xpBar = {
		GarrisonLandingPage.FollowerTab.XPBar,
		GarrisonLandingPage.ShipFollowerTab.XPBar,
		GarrisonMissionFrame.FollowerTab.XPBar,
		GarrisonShipyardFrame.FollowerTab.XPBar,
		OrderHallMissionFrame.FollowerTab.XPBar,
		BFAMissionFrame.FollowerTab.XPBar
	}

	for i = 1, #xpBar do
		local xpBar = xpBar[i]
		xpBar:StripTextures()
		xpBar:CreateBackdrop("Default")
		xpBar.backdrop:SetFrameLevel(xpBar.backdrop:GetFrameLevel() + 1)
		xpBar:SetStatusBarTexture(C.media.texture)

		if xpBar:GetParent().PortraitFrame then
			xpBar:ClearAllPoints()
			xpBar:SetPoint("BOTTOMLEFT", xpBar:GetParent().PortraitFrame, "BOTTOMRIGHT", 8, -15)
		end

		if xpBar.Label then
			xpBar.Label:SetFontObject(SystemFont_Outline_Small)
		end
	end

	local function onShowFollower(followerList)
		local followerTab = followerList and followerList.followerTab
		local abilityFrame = followerTab.AbilitiesFrame
		if not abilityFrame then return end

		-- Ability buttons
		local abilities = abilityFrame.Abilities
		if abilities then
			for i = 1, #abilities do
				local IconButton = abilities[i].IconButton
				if IconButton and not IconButton.backdrop then
					IconButton.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
					IconButton.Icon:SetDrawLayer("BACKGROUND", 1)
					IconButton:CreateBackdrop("Default")
					IconButton.Border:SetTexture(nil)
				end
			end
		end

		-- CombatAllySpell buttons
		local combatAllySpell = abilityFrame.CombatAllySpell
		if combatAllySpell then
			for i = 1, #combatAllySpell do
				local button = combatAllySpell[i]
				if button and not button.backdrop then
					button.iconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
					button:CreateBackdrop("Default")
				end
			end
		end

		-- Equipment
		local equipment = abilityFrame.Equipment
		if equipment then
			for i = 1, #equipment do
				local button = equipment[i]
				if button then
					button.Border:SetTexture(nil)
					button.BG:SetTexture(nil)
					button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
					button:SetScale(1)
					if not button.backdrop then
						button:CreateBackdrop("Default")
						button.backdrop:SetPoint("TOPLEFT", button.Icon, "TOPLEFT", -2, 2)
						button.backdrop:SetPoint("BOTTOMRIGHT", button.Icon, "BOTTOMRIGHT", 2, -2)
					end
				end
			end
		end

		-- AutoSpell buttons
		for autoSpell in followerTab.autoSpellPool:EnumerateActive() do
			if not autoSpell.backdrop then
				autoSpell.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				autoSpell:CreateBackdrop("Default")
				autoSpell.SpellBorder:SetTexture("")
				autoSpell.IconMask:Hide()
			end
		end
	end

	hooksecurefunc(GarrisonMissionFrame.FollowerList, "ShowFollower", onShowFollower)
	hooksecurefunc(GarrisonLandingPageFollowerList, "ShowFollower", onShowFollower)
	hooksecurefunc(GarrisonShipyardFrameFollowers, "ShowFollower", onShowFollower)

	-- ShipYard
	GarrisonShipyardFrame:StripTextures(true)
	GarrisonShipyardFrame:CreateBackdrop("Transparent")
	GarrisonShipyardFrame.BorderFrame.GarrCorners:StripTextures()
	GarrisonShipyardFrame.BorderFrame:StripTextures(true)
	GarrisonShipyardFrame.BorderFrame.TitleText:SetPoint("TOP", -6, -1)
	T.SkinCloseButton(GarrisonShipyardFrame.BorderFrame.CloseButton2)
	T.SkinTab(GarrisonShipyardFrameTab1)
	T.SkinTab(GarrisonShipyardFrameTab2)

	-- ShipYard: Naval Map
	local MissionTab = GarrisonShipyardFrame.MissionTab
	local MissionList = MissionTab.MissionList

	-- ShipYard: Mission
	local MissionPage = MissionTab.MissionPage
	T.SkinCloseButton(MissionPage.CloseButton)
	MissionPage.CloseButton:SetFrameLevel(MissionPage.CloseButton:GetFrameLevel() + 2)
	MissionList.CompleteDialog.BorderFrame:StripTextures()
	MissionList.CompleteDialog.BorderFrame:SetTemplate("Transparent")
	MissionList.CompleteDialog.BorderFrame.ViewButton:SkinButton()
	MissionList.CompleteDialog:SetAllPoints(MissionList.MapTexture)
	GarrisonShipyardFrame.MissionComplete.NextMissionButton:SkinButton()
	GarrisonShipyardFrame.MissionCompleteBackground:SetAllPoints(MissionList.MapTexture)
	MissionPage.StartMissionButton:SkinButton()
	MissionList.MapTexture:ClearAllPoints()
	MissionList.MapTexture:SetPoint("TOPLEFT")
	MissionList.MapTexture:SetPoint("BOTTOMRIGHT")

	T.SkinEditBox(GarrisonShipyardFrameFollowers.SearchBox)
	GarrisonShipyardFrameFollowers.SearchBox:SetPoint("TOPLEFT", 2, 25)
	GarrisonShipyardFrameFollowers.SearchBox:SetSize(301, 20)
	GarrisonShipyardFrameFollowers:StripTextures()
	GarrisonShipyardFrameFollowers:SetTemplate("Transparent")
	GarrisonShipyardFrameFollowers.MaterialFrame:GetRegions():Hide()
	GarrisonShipyardFrame.FollowerTab:StripTextures()
	GarrisonShipyardFrame.FollowerTab:SetTemplate("Overlay")
	T.SkinScrollBar(GarrisonShipyardFrameFollowers.ScrollBar)

	hooksecurefunc("GarrisonShipyardFollowerList_InitButton", function(button, elementData)
		if button and not button.backdrop then
			button:CreateBackdrop("Overlay")
			button.backdrop:SetPoint("TOPLEFT", -1, 1)
			button.backdrop:SetPoint("BOTTOMRIGHT", 0, -1)
			button:StyleButton(nil, 1)
			button.BG:Hide()
			button.Selection:SetTexture("")
			button.Portrait:SetPoint("TOPLEFT", 2, 0)
			button.AbilitiesBG:SetTexture(C.media.blank)
			button.AbilitiesBG:SetColorTexture(0.1, 0.1, 0.1, 1)
		end

		if button.Selection and button.backdrop then
			if button.Selection:IsShown() then
				button.backdrop:SetBackdropBorderColor(1, 0.82, 0, 1)
				button.backdrop.overlay:SetVertexColor(1 * 0.3, 0.82 * 0.3, 0, 1)
			else
				button.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
				button.backdrop.overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
			end
		end
	end)

	local function skinFollowerTraitsAndEquipment(obj)
		local btn
		for i = 1, #obj.Traits do
			btn = obj.Traits[i]
			if not btn.backdrop then
				btn.Border:SetTexture(nil)
				btn.Portrait:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				btn:CreateBackdrop("Default")
				btn.backdrop:SetPoint("TOPLEFT", btn.Portrait, "TOPLEFT", -2, 2)
				btn.backdrop:SetPoint("BOTTOMRIGHT", btn.Portrait, "BOTTOMRIGHT", 2, -2)
				btn.backdrop:SetFrameLevel(2)
			end
		end
		for i = 1, #obj.EquipmentFrame.Equipment do
			btn = obj.EquipmentFrame.Equipment[i]
			if not btn.backdrop then
				btn:DisableDrawLayer("BACKGROUND")
				btn.Border:SetTexture(nil)
				btn.Counter.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				btn.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				btn:CreateBackdrop("Default")
				btn.backdrop:SetPoint("TOPLEFT", btn.Icon, "TOPLEFT", -2, 2)
				btn.backdrop:SetPoint("BOTTOMRIGHT", btn.Icon, "BOTTOMRIGHT", 2, -2)

				btn.Counter.Border:SetAlpha(0)
				btn.Counter.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				btn.Counter:CreateBackdrop("Default")
				btn.Counter.backdrop:SetPoint("TOPLEFT", btn.Counter.Icon, "TOPLEFT", -2, 2)
				btn.Counter.backdrop:SetPoint("BOTTOMRIGHT", btn.Counter.Icon, "BOTTOMRIGHT", 2, -2)
			end
		end
		btn = nil
	end
	skinFollowerTraitsAndEquipment(GarrisonLandingPage.ShipFollowerTab)
	skinFollowerTraitsAndEquipment(GarrisonShipyardFrame.FollowerTab)

	-- Recruiter frame
	GarrisonRecruiterFrame:StripTextures(true)
	GarrisonRecruiterFrame:SetTemplate("Transparent")
	T.SkinCloseButton(GarrisonRecruiterFrame.CloseButton)
	GarrisonRecruiterFrame.UnavailableFrame:GetChildren():SkinButton()
	GarrisonRecruiterFrame.Pick.ChooseRecruits:SkinButton()
	T.SkinDropDownBox(GarrisonRecruiterFrame.Pick.ThreatDropDown)
	T.SkinCheckBox(GarrisonRecruiterFrame.Pick.Radio1)
	T.SkinCheckBox(GarrisonRecruiterFrame.Pick.Radio2)

	-- Recruiter select frame
	GarrisonRecruitSelectFrame:StripTextures()
	GarrisonRecruitSelectFrame:SetTemplate("Transparent")
	GarrisonRecruitSelectFrame.GarrCorners:StripTextures()
	T.SkinCloseButton(GarrisonRecruitSelectFrame.CloseButton)

	GarrisonRecruitSelectFrame.FollowerList:StripTextures()
	GarrisonRecruitSelectFrame.FollowerList:SetTemplate("Transparent")
	T.SkinScrollBar(GarrisonRecruitSelectFrame.FollowerList.ScrollBar)
	T.SkinEditBox(GarrisonRecruitSelectFrame.FollowerList.SearchBox)
	GarrisonRecruitSelectFrame.FollowerList.SearchBox:SetPoint("TOPLEFT", 2, 25)
	GarrisonRecruitSelectFrame.FollowerList.SearchBox:SetSize(301, 20)
	GarrisonRecruitSelectFrame.FollowerSelection:StripTextures()
	GarrisonRecruitSelectFrame.FollowerSelection:SetTemplate("Overlay")

	GarrisonRecruitSelectFrame.FollowerList.ScrollBar:SetPoint("TOPLEFT", GarrisonRecruitSelectFrame.FollowerList.ScrollBox, "TOPRIGHT", -6, 3)
	GarrisonRecruitSelectFrame.FollowerList.ScrollBar:SetPoint("BOTTOMLEFT", GarrisonRecruitSelectFrame.FollowerList.ScrollBox, "BOTTOMRIGHT", -3, -1)

	for i = 1, 3 do
		local recruit = GarrisonRecruitSelectFrame.FollowerSelection["Recruit"..i]
		recruit.HireRecruits:SkinButton()
		HandleGarrisonPortrait(recruit.PortraitFrame)
	end

	hooksecurefunc(GarrisonRecruitSelectFrame.FollowerList.ScrollBox, "Update", function(frame)
		for i = 1, frame.ScrollTarget:GetNumChildren() do
			local button = select(i, frame.ScrollTarget:GetChildren())
			local follower = button.Follower
			if follower and not follower.backdrop then
				follower:CreateBackdrop("Overlay")
				follower.backdrop:SetPoint("TOPLEFT", 0, 0)
				follower.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)
				follower:StyleButton()

				follower.BG:Hide()
				follower.Selection:SetTexture("")
				follower.AbilitiesBG:SetTexture("")
				follower.BusyFrame:SetAllPoints()
				follower.Name:SetWordWrap(false)

				if follower.PortraitFrame then
					HandleGarrisonPortrait(follower.PortraitFrame)
					follower.PortraitFrame:ClearAllPoints()
					follower.PortraitFrame:SetPoint("TOPLEFT", 6, -5)
				end
			end

			if follower then
				if follower.Selection and follower.backdrop then
					if follower.Selection:IsShown() then
						follower.backdrop:SetBackdropBorderColor(1, 0.82, 0, 1)
						follower.backdrop.overlay:SetVertexColor(1 * 0.3, 0.82 * 0.3, 0, 1)
						follower.PortraitFrame.backdrop:SetBackdropBorderColor(1, 0.82, 0, 1)
					else
						follower.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
						follower.backdrop.overlay:SetVertexColor(0.1, 0.1, 0.1, 1)
						follower.PortraitFrame.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
					end
				end

				local color = ITEM_QUALITY_COLORS[follower.PortraitFrame.quality]
				if color then
					follower.Name:SetTextColor(color.r, color.g, color.b)
				else
					follower.Name:SetTextColor(1, 1, 1)
				end
			end
		end
	end)

	hooksecurefunc(GarrisonRecruitSelectFrame, "Show", function(self)
		C_Timer.After(0.01, function() -- fixed color name after open
			GarrisonRecruitSelectFrame.FollowerList.ScrollBox:Update()
		end)
	end)

	hooksecurefunc("GarrisonRecruitSelectFrame_UpdateRecruits", function(waiting)
		if waiting then return end

		for i = 1, 3 do
			local frame = GarrisonRecruitSelectFrame.FollowerSelection["Recruit"..i]
			if frame:IsShown() then
				local traits = frame.Traits.Entries
				if traits then
					for index = 1, #traits do
						local trait = traits[index]
						if not trait.bg then
							trait.Icon:SkinIcon()
						end
					end
				end
				local abilities = frame.Abilities.Entries
				if abilities then
					for index = 1, #abilities do
						local ability = abilities[index]
						if not ability.bg then
							ability.Icon:SkinIcon()
						end
					end
				end
			end
		end
	end)

	-- Capacitive display frame
	GarrisonCapacitiveDisplayFrame:StripTextures(true)
	GarrisonCapacitiveDisplayFrame:SetTemplate("Transparent")
	GarrisonCapacitiveDisplayFrame:SetFrameLevel(5)
	GarrisonCapacitiveDisplayFramePortrait:SetAlpha(0)

	T.SkinNextPrevButton(GarrisonCapacitiveDisplayFrame.DecrementButton, true)
	GarrisonCapacitiveDisplayFrame.DecrementButton:SetSize(22, 22)
	T.SkinNextPrevButton(GarrisonCapacitiveDisplayFrame.IncrementButton)
	GarrisonCapacitiveDisplayFrame.IncrementButton:SetSize(22, 22)
	GarrisonCapacitiveDisplayFrame.Count:StripTextures()
	T.SkinEditBox(GarrisonCapacitiveDisplayFrame.Count)
	GarrisonCapacitiveDisplayFrame.Count:SetHeight(18)
	T.SkinCloseButton(GarrisonCapacitiveDisplayFrameCloseButton)
	GarrisonCapacitiveDisplayFrame.StartWorkOrderButton:SkinButton()
	GarrisonCapacitiveDisplayFrame.CreateAllWorkOrdersButton:SkinButton()
	local CapacitiveDisplay = GarrisonCapacitiveDisplayFrame.CapacitiveDisplay
	CapacitiveDisplay.IconBG:SetTexture()
	CapacitiveDisplay.ShipmentIconFrame.Icon:SkinIcon()

	local CapacitiveFollower = CapacitiveDisplay.ShipmentIconFrame.Follower
	CapacitiveFollower.Portrait:SetAllPoints()
	CapacitiveFollower.Portrait:SetTexCoord(0.2, 0.85, 0.2, 0.85)
	CapacitiveFollower.PortraitRing:Kill()
	CapacitiveFollower.PortraitRingQuality:Kill()
	CapacitiveFollower:SetPoint("TOPLEFT", -2, 2)
	CapacitiveFollower:SetPoint("BOTTOMRIGHT", 2, -2)
	CapacitiveFollower.Portrait.IconBackdrop = CreateFrame("Frame", nil, CapacitiveFollower)
	CapacitiveFollower.Portrait.IconBackdrop:SetFrameLevel(CapacitiveFollower:GetFrameLevel() - 1)
	CapacitiveFollower.Portrait.IconBackdrop:SetPoint("TOPLEFT", CapacitiveFollower.Portrait, -2, 2)
	CapacitiveFollower.Portrait.IconBackdrop:SetPoint("BOTTOMRIGHT", CapacitiveFollower.Portrait, 2, -2)
	CapacitiveFollower.Portrait.IconBackdrop:SetTemplate("Default")

	hooksecurefunc(CapacitiveFollower.PortraitRingQuality, "SetVertexColor", function(self, r, g, b)
		if r ~= 1 and g ~= 1 and b ~= 1 then
			CapacitiveFollower.Portrait.IconBackdrop:SetBackdropBorderColor(r, g, b)
		end
		self:SetTexture("")
	end)

	hooksecurefunc("GarrisonCapacitiveDisplayFrame_Update", function(self)
		for _, reagent in ipairs(self.CapacitiveDisplay.Reagents) do
			reagent.NameFrame:SetAlpha(0)
			if not reagent.backdrop then
				reagent.Icon:SkinIcon()
			end
		end
	end)

	----------------------------------------------------------------------------------------
	--	MasterPlan AddOn skin
	----------------------------------------------------------------------------------------
	do
		local function skinMasterPlan()
			T.SkinTab(GarrisonLandingPageTab4)
			T.SkinTab(GarrisonMissionFrameTab3)
			T.SkinTab(GarrisonMissionFrameTab4)
			T.SkinTab(GarrisonShipyardFrameTab3)
			local MissionPage = GarrisonMissionFrame.MissionTab.MissionPage
			T.SkinCloseButton(MissionPage.MinimizeButton, nil, "-")
			MissionPage.MinimizeButton:SetPoint("TOPRIGHT", GarrisonMissionFrame.MissionTab.MissionPage.CloseButton, "TOPLEFT", -3, 0)
			MissionPage.MinimizeButton:SetFrameLevel(MissionPage:GetFrameLevel() + 2)
			GarrisonMissionFrame.MissionTab.MissionPage.CloseButton:SetSize(18, 18)
			GarrisonMissionFrame.MissionTab.MissionPage.CloseButton:SetPoint("TOPRIGHT", -4, -4)

			local MissionPage = GarrisonShipyardFrame.MissionTab.MissionPage
			T.SkinCloseButton(MissionPage.MinimizeButton, nil, "-")
			MissionPage.MinimizeButton:SetPoint("TOPRIGHT", GarrisonShipyardFrame.MissionTab.MissionPage.CloseButton, "TOPLEFT", -3, 0)
			MissionPage.MinimizeButton:SetFrameLevel(MissionPage:GetFrameLevel() + 2)
			GarrisonShipyardFrame.MissionTab.MissionPage.CloseButton:SetSize(18, 18)
			GarrisonShipyardFrame.MissionTab.MissionPage.CloseButton:SetPoint("TOPRIGHT", -4, -4)

			MPCompleteAll:SkinButton()
			MPPokeTentativeParties:SkinButton()
			GarrisonMissionFrameFollowers.SearchBox:SetSize(270, 20)
		end

		if C_AddOns.IsAddOnLoaded("MasterPlan") then
			skinMasterPlan()
		else
			local f = CreateFrame("Frame")
			f:RegisterEvent("ADDON_LOADED")
			f:SetScript("OnEvent", function(self, _, addon)
				if addon == "MasterPlan" then
					skinMasterPlan()
					self:UnregisterEvent("ADDON_LOADED")
				end
			end)
		end
	end

	----------------------------------------------------------------------------------------
	--	Order Hall skin
	----------------------------------------------------------------------------------------
	OrderHallMissionFrame:StripTextures()
	OrderHallMissionFrame:CreateBackdrop("Transparent")
	OrderHallMissionFrame.backdrop:SetPoint("TOPLEFT", 0, 0)
	OrderHallMissionFrame.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)
	OrderHallMissionFrame.GarrCorners:StripTextures()
	OrderHallMissionFrame.ClassHallIcon:Kill()
	T.SkinCloseButton(OrderHallMissionFrame.CloseButton)

	for i = 1, 3 do
		T.SkinTab(_G["OrderHallMissionFrameTab"..i])
	end

	OrderHallMissionFrameMissions.CompleteDialog.BorderFrame:StripTextures()
	OrderHallMissionFrameMissions.CompleteDialog.BorderFrame:SetTemplate("Overlay")
	OrderHallMissionFrameMissions.CompleteDialog.BorderFrame.Stage:StripTextures()

	OrderHallMissionFrame.MissionComplete:StripTextures()
	OrderHallMissionFrame.MissionComplete:CreateBackdrop("Overlay")
	OrderHallMissionFrame.MissionComplete.backdrop:SetPoint("TOPLEFT", 3, 2)
	OrderHallMissionFrame.MissionComplete.backdrop:SetPoint("BOTTOMRIGHT", -3, -12)

	OrderHallMissionFrame.MissionComplete.Stage.MissionInfo:StripTextures()
	OrderHallMissionFrame.MissionComplete.Stage.MissionInfo:CreateOverlay()
	OrderHallMissionFrame.MissionComplete.Stage.MissionInfo.overlay:SetPoint("TOPLEFT", 5, 0)
	OrderHallMissionFrame.MissionComplete.Stage.MissionInfo.overlay:SetPoint("BOTTOMRIGHT", -5, 210)
	OrderHallMissionFrame.MissionComplete.Stage.MissionInfo.overlay:SetVertexColor(0, 0, 0, 0.7)

	OrderHallMissionFrameMissions:StripTextures()
	T.SkinScrollBar(OrderHallMissionFrameMissions.ScrollBar)

	OrderHallMissionFrameMissions.CombatAllyUI:StripTextures()
	OrderHallMissionFrameMissions.CombatAllyUI:CreateBackdrop("Overlay")
	OrderHallMissionFrameMissions.CombatAllyUI.backdrop:SetPoint("TOPLEFT", 18, -2)
	OrderHallMissionFrameMissions.CombatAllyUI.backdrop:SetPoint("BOTTOMRIGHT", -4, 2)
	OrderHallMissionFrameMissions.CombatAllyUI.InProgress.Unassign:SkinButton()
	OrderHallMissionFrameMissions.CombatAllyUI.InProgress.CombatAllySpell.iconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	OrderHallMissionFrameMissions.CombatAllyUI.InProgress.CombatAllySpell:CreateBackdrop("Default")
	HandleGarrisonPortrait(OrderHallMissionFrameMissions.CombatAllyUI.InProgress.PortraitFrame)
	OrderHallMissionFrameMissions.CombatAllyUI.InProgress.CombatAllySpell:SetPoint("BOTTOMLEFT", OrderHallMissionFrameMissions.CombatAllyUI.InProgress.PortraitFrame.backdrop, "BOTTOMRIGHT", 12, -20)
	hooksecurefunc(OrderHallMissionFrameMissions.CombatAllyUI.InProgress.PortraitFrame.PortraitRingQuality, "SetVertexColor", function(self, r, g, b)
		if r ~= 1 and g ~= 1 and b ~= 1 then
			OrderHallMissionFrameMissions.CombatAllyUI.InProgress.PortraitFrame.backdrop:SetBackdropBorderColor(r, g, b)
		end
		self:SetTexture("")
	end)

	OrderHallMissionFrameMissions.MaterialFrame:StripTextures()
	OrderHallMissionFrame.MissionTab:StripTextures()
	OrderHallMissionFrame.MissionTab.ZoneSupportMissionPage:StripTextures()
	OrderHallMissionFrame.MissionTab.ZoneSupportMissionPage:SetTemplate("Overlay")
	OrderHallMissionFrame.MissionTab.ZoneSupportMissionPage.CombatAllySpell:SetPoint("TOP", OrderHallMissionFrame.MissionTab.ZoneSupportMissionPage.CombatAllyDescriptionLabel, "BOTTOM", 0, -5)
	OrderHallMissionFrame.MissionTab.ZoneSupportMissionPage.CombatAllySpell.iconTexture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	OrderHallMissionFrame.MissionTab.ZoneSupportMissionPage.CombatAllySpell:CreateBackdrop("Default")
	T.SkinCloseButton(OrderHallMissionFrame.MissionTab.ZoneSupportMissionPage.CloseButton)
	OrderHallMissionFrame.MissionTab.ZoneSupportMissionPage.StartMissionButton:SkinButton()

	SkinTab(OrderHallMissionFrameMissionsTab1)
	SkinTab(OrderHallMissionFrameMissionsTab2)
	OrderHallMissionFrameMissionsTab1:SetPoint("BOTTOMLEFT", OrderHallMissionFrameMissions, "TOPLEFT", 18, 0)
	OrderHallMissionFrameMissionsTab1.backdrop:SetBackdropBorderColor(1, 0.82, 0, 1)
	OrderHallMissionFrameMissionsTab1.backdrop.overlay:SetVertexColor(1 * 0.3, 0.82 * 0.3, 0, 1)


	hooksecurefunc(OrderHallMissionFrame.MissionTab.MissionList.ScrollBox, "Update", function(frame)
		for i = 1, frame.ScrollTarget:GetNumChildren() do
			local button = select(i, frame.ScrollTarget:GetChildren())
			if not button.backdrop then
				button:StripTextures()
				button:CreateBackdrop("Overlay")
				button.backdrop:SetPoint("TOPLEFT", 0, 0)
				button.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)
				button:StyleButton(nil, 2)
			end
		end
	end)

	-- Followers
	local Follower = OrderHallMissionFrameFollowers
	Follower:StripTextures()
	T.SkinEditBox(Follower.SearchBox)
	Follower.SearchBox:SetPoint("TOPLEFT", 2, 25)
	Follower.SearchBox:SetSize(301, 20)
	T.SkinScrollBar(OrderHallMissionFrameFollowers.ScrollBar)
	Follower.MaterialFrame:StripTextures()
	T.SkinCloseButton(OrderHallMissionFrame.MissionTab.MissionPage.CloseButton)
	OrderHallMissionFrame.MissionTab.MissionPage.StartMissionButton:SkinButton()

	local FollowerTab = OrderHallMissionFrame.FollowerTab
	FollowerTab:StripTextures()
	FollowerTab:CreateBackdrop("Overlay")
	FollowerTab.backdrop:SetPoint("TOPLEFT", -2, 0)
	FollowerTab.backdrop:SetPoint("BOTTOMRIGHT", 2, -2)
	FollowerTab.ModelCluster:StripTextures()
	FollowerTab.Class:SetSize(50, 43)

	HandleGarrisonPortrait(FollowerTab.PortraitFrame)

	hooksecurefunc(OrderHallMissionFrame.FollowerList, "ShowFollower", onShowFollower)

	-- Missions
	OrderHallMissionFrameMissions.CompleteDialog.BorderFrame.ViewButton:SkinButton()
	OrderHallMissionFrame.MissionComplete.NextMissionButton:SkinButton()

	----------------------------------------------------------------------------------------
	--	BFA Mission skin
	----------------------------------------------------------------------------------------
	BFAMissionFrame:StripTextures()
	BFAMissionFrame:CreateBackdrop("Transparent")
	BFAMissionFrame.backdrop:SetPoint("TOPLEFT", 0, 0)
	BFAMissionFrame.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)
	BFAMissionFrame.OverlayElements:Hide()
	BFAMissionFrame.TitleScroll:Hide()

	BFAMissionFrameMissions.CompleteDialog.BorderFrame:StripTextures()
	BFAMissionFrameMissions.CompleteDialog.BorderFrame:SetTemplate("Transparent")
	BFAMissionFrameMissions.CompleteDialog.BorderFrame.ViewButton:SkinButton()

	BFAMissionFrameMissions.CompleteDialog.BorderFrame.Stage:StripTextures()

	BFAMissionFrame.MissionComplete.NextMissionButton:SkinButton()

	for i = 1, 3 do
		T.SkinTab(_G["BFAMissionFrameTab"..i])
	end

	T.SkinCloseButton(BFAMissionFrame.CloseButton)

	SkinTab(BFAMissionFrameMissionsTab1)
	SkinTab(BFAMissionFrameMissionsTab2)
	BFAMissionFrameMissionsTab1.backdrop:SetBackdropBorderColor(1, 0.82, 0, 1)
	BFAMissionFrameMissionsTab1.backdrop.overlay:SetVertexColor(1 * 0.3, 0.82 * 0.3, 0, 1)
	BFAMissionFrameMissionsTab1:SetPoint("BOTTOMLEFT", BFAMissionFrameMissions, "TOPLEFT", 18, 0)

	BFAMissionFrameMissions:StripTextures()
	T.SkinScrollBar(BFAMissionFrameMissions.ScrollBar)

	BFAMissionFrameMissions.MaterialFrame:GetRegions():Hide()
	BFAMissionFrameMissions.MaterialFrame.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	hooksecurefunc(BFAMissionFrame.MissionTab.MissionList.ScrollBox, "Update", function(frame)
		for i = 1, frame.ScrollTarget:GetNumChildren() do
			local button = select(i, frame.ScrollTarget:GetChildren())
			if not button.backdrop then
				button:StripTextures()
				button:CreateBackdrop("Overlay")
				button.backdrop:SetPoint("TOPLEFT", 0, 0)
				button.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)
				button:StyleButton(nil, 2)
				button.LocBG:SetHeight(75)
				button.LocBG:SetPoint("RIGHT", 0, -1)
			end
		end
	end)

	-- Followers
	local Follower = BFAMissionFrameFollowers
	Follower:StripTextures()
	T.SkinEditBox(Follower.SearchBox)
	Follower.SearchBox:SetPoint("TOPLEFT", 2, 25)
	Follower.SearchBox:SetSize(301, 20)
	T.SkinScrollBar(BFAMissionFrameFollowers.ScrollBar)
	Follower.MaterialFrame:StripTextures()
	T.SkinCloseButton(BFAMissionFrame.MissionTab.MissionPage.CloseButton)
	BFAMissionFrame.MissionTab.MissionPage.StartMissionButton:SkinButton()

	local FollowerTab = BFAMissionFrame.FollowerTab
	FollowerTab:StripTextures()
	FollowerTab.ModelCluster:StripTextures()
	FollowerTab:CreateBackdrop("Overlay")
	FollowerTab.backdrop:SetPoint("TOPLEFT", -2, 0)
	FollowerTab.backdrop:SetPoint("BOTTOMRIGHT", 2, -2)
	FollowerTab.Class:SetSize(50, 43)

	HandleGarrisonPortrait(FollowerTab.PortraitFrame)

	hooksecurefunc(BFAMissionFrame.FollowerList, "ShowFollower", onShowFollower)

	-- Map
	BFAMissionFrame.MapTab.ScrollContainer:ClearAllPoints()
	BFAMissionFrame.MapTab.ScrollContainer:SetPoint("TOPLEFT")
	BFAMissionFrame.MapTab.ScrollContainer:SetPoint("BOTTOMRIGHT")

	----------------------------------------------------------------------------------------
	--	Shadowlands Mission skin
	----------------------------------------------------------------------------------------
	CovenantMissionFrame:CreateBackdrop("Transparent")
	CovenantMissionFrame.backdrop:SetPoint("TOPLEFT", 0, 0)
	CovenantMissionFrame.backdrop:SetPoint("BOTTOMRIGHT", 0, 0)
	CovenantMissionFrame.BackgroundTile:SetAlpha(0)

	CovenantMissionFrame.TopRightCorner:SetAlpha(0)
	CovenantMissionFrame.TopBorder:SetAlpha(0)
	CovenantMissionFrame.TopLeftCorner:SetAlpha(0)

	CovenantMissionFrame.MissionTab:StripTextures()
	CovenantMissionFrame:DisableDrawLayer("BORDER")
	CovenantMissionFrame:DisableDrawLayer("BACKGROUND")

	CovenantMissionFrame:HookScript("OnShow", function(self)
		T.SkinCloseButton(CovenantMissionFrame.CloseButton)
		CovenantMissionFrame.FollowerTab:StripTextures()
	end)

	hooksecurefunc(CovenantMissionFrame, "SetupTabs", function(self)
		self.MapTab:SetShown(not self.Tab2:IsShown())
	end)

	local material = CovenantMissionFrameMissions.MaterialFrame
	material.BG:SetAlpha(0)
	material.LeftFiligree:Hide()
	material.RightFiligree:Hide()
	material.Icon:SkinIcon()
	CovenantMissionFrameMissions.RaisedFrameEdges:StripTextures()
	CovenantMissionFrameMissions:DisableDrawLayer("BORDER")
	T.SkinScrollBar(CovenantMissionFrameMissions.ScrollBar)

	CovenantMissionFrameMissions.ScrollBar.Back:SetSize(17, 15)
	CovenantMissionFrameMissions.ScrollBar.Track.Thumb:SetWidth(17)
	CovenantMissionFrameMissions.ScrollBar.Forward:SetSize(17, 15)
	CovenantMissionFrameMissions.ScrollBar:SetPoint("TOPLEFT", CovenantMissionFrameMissions.ScrollBox, "TOPRIGHT", 7, -11)
	CovenantMissionFrameMissions.ScrollBar:SetPoint("BOTTOMLEFT", CovenantMissionFrameMissions.ScrollBox, "BOTTOMRIGHT", 7, 2)

	hooksecurefunc(CovenantMissionFrame.MissionTab.MissionList.ScrollBox, "Update", function(frame)
		for i = 1, frame.ScrollTarget:GetNumChildren() do
			local button = select(i, frame.ScrollTarget:GetChildren())
			if not button.backdrop then
				button.ButtonBG:Hide()
				button.Highlight:Hide()
				button:CreateBackdrop("Overlay")
				button.backdrop:SetPoint("TOPLEFT", 0, -3)
				button.backdrop:SetPoint("BOTTOMRIGHT", 0, 3)
				button:StyleButton(nil, 0)
				button.Overlay.Overlay:SetAllPoints(button.backdrop)
			end
		end
	end)

	for i = 1, 2 do
		T.SkinTab(_G["CovenantMissionFrameTab"..i])
	end

	-- Followers
	local Follower = CovenantMissionFrameFollowers
	Follower:StripTextures()
	Follower.MaterialFrame:StripTextures()
	Follower.HealAllButton:SkinButton()
	Follower.ElevatedFrame:Hide()

	hooksecurefunc(Follower, "ShowFollower", onShowFollower)

	T.SkinScrollBar(CovenantMissionFrameFollowers.ScrollBar)
	CovenantMissionFrameFollowers.ScrollBar.Back:SetSize(17, 15)
	CovenantMissionFrameFollowers.ScrollBar.Track.Thumb:SetWidth(17)
	CovenantMissionFrameFollowers.ScrollBar.Forward:SetSize(17, 15)
	CovenantMissionFrameFollowers.ScrollBar:SetPoint("TOPLEFT", CovenantMissionFrameFollowers.ScrollBox, "TOPRIGHT", 7, -11)
	CovenantMissionFrameFollowers.ScrollBar:SetPoint("BOTTOMLEFT", CovenantMissionFrameFollowers.ScrollBox, "BOTTOMRIGHT", 7, 0)

	local FollowerTab = CovenantMissionFrame.FollowerTab
	FollowerTab:CreateBackdrop("Overlay")
	FollowerTab.backdrop:SetPoint("TOPLEFT", -2, 0)
	FollowerTab.backdrop:SetPoint("BOTTOMRIGHT", 2, 20)
	FollowerTab.RaisedFrameEdges:Hide()

	FollowerTab.HealFollowerFrame.ButtonFrame:Hide()
	HealFollowerButtonTemplate:SkinButton()

	FollowerTab.HealFollowerFrame.CostFrame.CostLabel:SetFont(C.media.normal_font, 14, "")
	FollowerTab.HealFollowerFrame.CostFrame.CostIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	-- Mission
	T.SkinCloseButton(CovenantMissionFrame.MissionTab.MissionPage.CloseButton)
	CovenantMissionFrame.MissionTab.MissionPage.StartMissionButton:SkinButton()

	CovenantMissionFrame.MissionComplete.CompleteFrame.ContinueButton:SkinButton()
	CovenantMissionFrame.MissionComplete.CompleteFrame.SpeedButton:SkinButton()
	CovenantMissionFrame.MissionComplete.RewardsScreen.FinalRewardsPanel.ContinueButton:SkinButton()

	HandleGarrisonPortrait(GarrisonLandingPage.FollowerTab.CovenantFollowerPortraitFrame)

	CovenantMissionFrame.MissionTab.MissionPage.CostFrame.CostLabel:SetFont(C.media.normal_font, 14, "")
	CovenantMissionFrame.MissionTab.MissionPage.CostFrame.CostIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	----------------------------------------------------------------------------------------
	--	KayrCovenantMissions AddOn skin
	----------------------------------------------------------------------------------------
	if C_AddOns.IsAddOnLoaded("KayrCovenantMissions") then
		hooksecurefunc(CovenantMissionFrame, "SetupTabs", function()
			if KayrCovenantMissionsAdvice then
				KayrCovenantMissionsAdvice:StripTextures()
				KayrCovenantMissionsAdvice:CreateBackdrop("Transparent")
				KayrCovenantMissionsAdvice.backdrop:SetPoint("TOPLEFT", 2, -4)
				KayrCovenantMissionsAdvice.backdrop:SetPoint("BOTTOMRIGHT", 0, 4)
			end
		end)
	end
end

T.SkinFuncs["Blizzard_GarrisonUI"] = LoadSkin