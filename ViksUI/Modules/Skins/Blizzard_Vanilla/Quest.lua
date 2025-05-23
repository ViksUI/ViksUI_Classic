local T, C, L = unpack(ViksUI)
if C.skins.blizzard_frames ~= true then return else return end -- incomplete

----------------------------------------------------------------------------------------
--	Quest skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	QuestFrame:CreateBackdrop("Transparent")
	QuestFrame.backdrop:SetPoint("TOPLEFT", 10, -12)
	QuestFrame.backdrop:SetPoint("BOTTOMRIGHT", -32, 76)

	QuestFrameNpcNameText:ClearAllPoints()
	QuestFrameNpcNameText:SetPoint("TOP", QuestFrame.backdrop, "TOP", 0, -6)

	T.SkinCloseButton(QuestFrameCloseButton, QuestFrame.backdrop)

	local ScrollFrames = {
		"QuestDetailScrollFrame",
		"QuestRewardScrollFrame",
		"QuestProgressScrollFrame",
		"QuestGreetingScrollFrame",
	}

	for _, object in pairs(ScrollFrames) do
		_G[object]:ClearAllPoints()
		_G[object]:SetPoint("TOP", QuestFrame.backdrop, -6, -30)
		_G[object]:SetHeight(362)
	end

	local QuestStrip = {
		"QuestFrame",
		"QuestFrameDetailPanel",
		"QuestDetailScrollFrame",
		"QuestDetailScrollChildFrame",
		"QuestRewardScrollFrame",
		"QuestRewardScrollChildFrame",
		"QuestProgressScrollFrame",
		"QuestGreetingScrollFrame",
		"QuestFrameProgressPanel",
		"QuestFrameRewardPanel",
	}

	for _, object in pairs(QuestStrip) do
		_G[object]:StripTextures(true)
	end

	QuestFrameDetailPanel:SetPoint("TOPLEFT", -5, -12)
	QuestFrameDetailPanel:SetPoint("BOTTOMRIGHT", 0, 76)
	QuestFrameProgressPanel:SetPoint("TOPLEFT", -5, -12)
	QuestFrameProgressPanel:SetPoint("BOTTOMRIGHT", 0, 76)

	local LeftQuestButtons = {
		"QuestFrameAcceptButton",
		"QuestFrameCompleteButton",
		"QuestFrameCompleteQuestButton",
	}

	local RightQuestButtons = {
		"QuestFrameDeclineButton",
		"QuestFrameGoodbyeButton",
		"QuestFrameCancelButton",
	}

	for _, button in pairs(LeftQuestButtons) do
		_G[button]:SkinButton()
		_G[button]:SetPoint("BOTTOMLEFT", QuestFrame.backdrop, "BOTTOMLEFT", 4, 4)
	end

	for _, button in pairs(RightQuestButtons) do
		_G[button]:SkinButton()
		_G[button]:SetPoint("BOTTOMRIGHT", QuestFrame.backdrop, "BOTTOMRIGHT", -4, 4)
	end

	local ScrollBars = {
		"QuestDetailScrollFrameScrollBar",
		"QuestProgressScrollFrameScrollBar",
		"QuestRewardScrollFrameScrollBar",
		"QuestGreetingScrollFrameScrollBar",
		"QuestNPCModelTextScrollFrameScrollBar",
	}

	for _, scrollbar in pairs(ScrollBars) do
		T.SkinScrollBar(_G[scrollbar])
	end

	local textR, textG, textB = 1, 1, 1
	local titleR, titleG, titleB = 1, 0.80, 0
	hooksecurefunc('QuestInfo_Display', function()
		-- Headers
		_G.QuestInfoTitleHeader:SetTextColor(titleR, titleG, titleB)
		_G.QuestInfoDescriptionHeader:SetTextColor(titleR, titleG, titleB)
		_G.QuestInfoObjectivesHeader:SetTextColor(titleR, titleG, titleB)
		_G.QuestInfoRewardsFrame.Header:SetTextColor(titleR, titleG, titleB)

		-- Other text
		_G.QuestInfoDescriptionText:SetTextColor(textR, textG, textB)
		_G.QuestInfoObjectivesText:SetTextColor(textR, textG, textB)
		_G.QuestInfoGroupSize:SetTextColor(textR, textG, textB)
		_G.QuestInfoRewardText:SetTextColor(textR, textG, textB)
		_G.QuestInfoQuestType:SetTextColor(textR, textG, textB)

		local numObjectives = GetNumQuestLeaderBoards()
		for i = 1, numObjectives do
			local text = _G['QuestInfoObjective'..i]
			if not text then break end

			text:SetTextColor(textR, textG, textB)
		end

		-- Reward frame text
		_G.QuestInfoRewardsFrame.ItemChooseText:SetTextColor(textR, textG, textB)
		_G.QuestInfoRewardsFrame.ItemReceiveText:SetTextColor(textR, textG, textB)
		_G.QuestInfoRewardsFrame.XPFrame.ReceiveText:SetTextColor(textR, textG, textB)
		--_G.QuestInfoTalentFrame.ReceiveText:SetTextColor(textR, textG, textB)
		--_G.QuestInfoRewardsFrameHonorReceiveText:SetTextColor(textR, textG, textB)
		--_G.QuestInfoRewardsFrameReceiveText:SetTextColor(textR, textG, textB)

		_G.QuestInfoRewardsFrame.spellHeaderPool.textR, _G.QuestInfoRewardsFrame.spellHeaderPool.textG, _G.QuestInfoRewardsFrame.spellHeaderPool.textB = textR, textG, textB

		for spellHeader, _ in _G.QuestInfoFrame.rewardsFrame.spellHeaderPool:EnumerateActive() do
			spellHeader:SetVertexColor(1, 1, 1)
		end
		for spellIcon, _ in _G.QuestInfoFrame.rewardsFrame.spellRewardPool:EnumerateActive() do
			if not spellIcon.template then
				handleItemButton(spellIcon)
			end
		end

		local requiredMoney = GetQuestLogRequiredMoney()
		if requiredMoney > 0 then
			if requiredMoney > GetMoney() then
				_G.QuestInfoRequiredMoneyText:SetTextColor(0.6, 0.6, 0.6)
			else
				_G.QuestInfoRequiredMoneyText:SetTextColor(1, 0.80, 0.10)
			end
		end
	end)

	local function SkinReward(button, mapReward)
		if button.NameFrame then button.NameFrame:Hide() end
		if button.CircleBackground then button.CircleBackground:Hide() end
		if button.CircleBackgroundGlow then button.CircleBackgroundGlow:Hide() end
		if button.ValueText then button.ValueText:SetPoint("BOTTOMRIGHT", button.Icon, 0, 0) end
		if button.IconBorder then button.IconBorder:SetAlpha(0) end
		button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		button:CreateBackdrop("Default")
		button.backdrop:ClearAllPoints()
		button.backdrop:SetPoint("TOPLEFT", button.Icon, -2, 2)
		button.backdrop:SetPoint("BOTTOMRIGHT", button.Icon, 2, -2)
		if mapReward then
			button.Icon:SetSize(26, 26)
		end
	end

	hooksecurefunc("QuestInfo_GetRewardButton", function(rewardsFrame, index)
		local button = rewardsFrame.RewardButtons[index]
		if not button.backdrop then
			SkinReward(button, rewardsFrame == MapQuestInfoRewardsFrame)

			hooksecurefunc(button.IconBorder, "SetVertexColor", function(self, r, g, b)
				if r ~= BAG_ITEM_QUALITY_COLORS[1].r ~= r and g ~= BAG_ITEM_QUALITY_COLORS[1].g then
					self:GetParent().backdrop:SetBackdropBorderColor(r, g, b)
				else
					self:GetParent().backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
				end
				self:SetTexture(0)
			end)

			hooksecurefunc(button.IconBorder, "Hide", function(self)
				self:GetParent().backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
			end)
		end
	end)

	QuestInfoItemHighlight:StripTextures()
	QuestInfoItemHighlight:SetTemplate("Default")
	QuestInfoItemHighlight:SetBackdropBorderColor(1, 1, 0)
	QuestInfoItemHighlight:SetBackdropColor(0, 0, 0, 0)

	hooksecurefunc("QuestInfoItem_OnClick", function(self)
		QuestInfoItemHighlight:ClearAllPoints()
		QuestInfoItemHighlight:SetPoint("TOPLEFT", self.Icon, "TOPLEFT", -2, 2)
		QuestInfoItemHighlight:SetPoint("BOTTOMRIGHT", self.Icon, "BOTTOMRIGHT", 2, -2)

		local parent = self:GetParent()
		for i = 1, #parent.RewardButtons do
			local questItem = QuestInfoRewardsFrame.RewardButtons[i]
			if questItem ~= self then
				questItem.Name:SetTextColor(1, 1, 1)
			else
				self.Name:SetTextColor(1, 1, 0)
			end
		end
	end)

	for i = 1, 6 do
		local button = _G["QuestProgressItem"..i]
		local texture = _G["QuestProgressItem"..i.."IconTexture"]

		if button.NameFrame then button.NameFrame:Hide() end
		button.Name:SetFont(C.media.normal_font, 12)

		button:CreateBackdrop("Default")
		button.backdrop:ClearAllPoints()
		button.backdrop:SetPoint("TOPLEFT", texture, -2, 2)
		button.backdrop:SetPoint("BOTTOMRIGHT", texture, 2, -2)

		texture:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	end

	hooksecurefunc("QuestFrameProgressItems_Update", function()
		QuestProgressTitleText:SetTextColor(1, 0.8, 0)
		QuestProgressTitleText:SetShadowColor(0, 0, 0)
		QuestProgressText:SetTextColor(1, 1, 1)
		QuestProgressRequiredItemsText:SetTextColor(1, 0.8, 0)
		QuestProgressRequiredItemsText:SetShadowColor(0, 0, 0)
		QuestProgressRequiredMoneyText:SetTextColor(1, 0.8, 0)
	end)

	-- QuestGreeting
	local function UpdateGreetingPanel()
		QuestFrameGreetingPanel:StripTextures()
		QuestFrameGreetingGoodbyeButton:SkinButton()
		QuestFrameGreetingGoodbyeButton:SetPoint("BOTTOMRIGHT", QuestFrame.backdrop, "BOTTOMRIGHT", -4, 4)
		GreetingText:SetTextColor(1, 1, 1)
		CurrentQuestsText:SetTextColor(1, 0.8, 0)
		AvailableQuestsText:SetTextColor(1, 0.8, 0)
		QuestGreetingFrameHorizontalBreak:Kill()

		for i = 1, MAX_NUM_QUESTS do
			local button = _G["QuestTitleButton"..i]

			if button:GetFontString() then
				if button:GetFontString():GetText() and button:GetFontString():GetText():find("|cff000000") then
					button:GetFontString():SetText(string.gsub(button:GetFontString():GetText(), "|cff000000", "|cffFFFF00"))
				end
			end
		end
	end

	QuestFrameGreetingPanel:HookScript("OnShow", UpdateGreetingPanel)
	hooksecurefunc("QuestFrameGreetingPanel_OnShow", UpdateGreetingPanel)
end

tinsert(T.SkinFuncs["ViksUI"], LoadSkin)
