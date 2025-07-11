local T, C, L = unpack(ViksUI)
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	AchievementUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local frames = {
		"AchievementFrame",
		"AchievementFrameCategories",
		"AchievementFrameSummary",
		"AchievementFrameHeader",
		"AchievementFrameSummaryCategoriesHeader",
		"AchievementFrameSummaryAchievementsHeader",
		"AchievementFrameStatsBG",
		"AchievementFrameAchievements",
		"AchievementFrameComparison",
		"AchievementFrameComparisonHeader",
		"AchievementFrameComparisonSummaryPlayer",
		"AchievementFrameComparisonSummaryFriend"
	}

	for _, frame in pairs(frames) do
		_G[frame]:StripTextures(true)
	end

	local noname_frames = {
		"AchievementFrameStats",
		"AchievementFrameSummary",
		"AchievementFrameAchievements",
		"AchievementFrameComparison"
	}

	for _, frame in pairs(noname_frames) do
		local f = _G[frame]
		if f then
			for i = 1, _G[frame]:GetNumChildren() do
				local child = select(i, _G[frame]:GetChildren())
				if child and not child:GetName() and child.NineSlice then
					child.NineSlice:SetAlpha(0)
				end
			end
		end
	end

	AchievementFrame:CreateBackdrop("Transparent")
	AchievementFrame.backdrop:SetPoint("TOPLEFT", 0, 7)
	AchievementFrame.backdrop:SetPoint("BOTTOMRIGHT")
	AchievementFrameHeaderTitle:ClearAllPoints()
	AchievementFrameHeaderTitle:SetPoint("TOPLEFT", AchievementFrame.backdrop, "TOPLEFT", -22, -8)
	AchievementFrameHeaderPoints:ClearAllPoints()
	AchievementFrameHeaderPoints:SetPoint("LEFT", AchievementFrameHeaderTitle, "RIGHT", -2, 0)

	-- Backdrops
	AchievementFrameCategoriesContainer:CreateBackdrop("Overlay")
	AchievementFrameCategoriesContainer.backdrop:SetPoint("TOPLEFT", 0, 4)
	AchievementFrameCategoriesContainer.backdrop:SetPoint("BOTTOMRIGHT", -2, -3)
	AchievementFrameAchievementsContainer:CreateBackdrop("Overlay")
	AchievementFrameAchievementsContainer.backdrop:SetPoint("TOPLEFT", -3, 2)
	AchievementFrameAchievementsContainer.backdrop:SetPoint("BOTTOMRIGHT", -3, -3)
	AchievementFrameStatsContainer:CreateBackdrop("Overlay")
	AchievementFrameStatsContainer.backdrop:SetPoint("TOPLEFT", -2, 2)
	AchievementFrameStatsContainer.backdrop:SetPoint("BOTTOMRIGHT", -2, -3)
	AchievementFrameComparisonStatsContainer:CreateBackdrop("Overlay")
	AchievementFrameComparisonStatsContainer.backdrop:SetPoint("TOPLEFT", -3, 2)
	AchievementFrameComparisonStatsContainer.backdrop:SetPoint("BOTTOMRIGHT", -2, -3)

	T.SkinCloseButton(AchievementFrameCloseButton, AchievementFrame.backdrop)
	T.SkinFilter(AchievementFrameFilterDropdown, true)
	AchievementFrameFilterDropdown:ClearAllPoints()
	AchievementFrameFilterDropdown:SetPoint("TOPLEFT", AchievementFrameAchievements, "TOPLEFT", -19, 24)

	local frame = CreateFrame("Frame")
	frame:RegisterEvent("ADDON_LOADED")
	frame:SetScript("OnEvent", function()
		if not C_AddOns.IsAddOnLoaded("Overachiever") then return end
		AchievementFrameFilterDropdown:ClearAllPoints()
		AchievementFrameFilterDropdown:SetPoint("TOPLEFT", AchievementFrameAchievements, "TOPLEFT", -19, 24)
	end)

	if T.Mainline then
		T.SkinEditBox(AchievementFrame.SearchBox)
		AchievementFrame.SearchBox:SetHeight(15)
		AchievementFrame.SearchBox:ClearAllPoints()
		AchievementFrame.SearchBox:SetPoint("TOPRIGHT", AchievementFrame, "TOPRIGHT", -51, 0)

		AchievementFrame.SearchPreviewContainer:StripTextures()
		AchievementFrame.SearchPreviewContainer:CreateBackdrop("Transparent")
		AchievementFrame.SearchPreviewContainer.backdrop:SetPoint("TOPLEFT", -2, 2)
		AchievementFrame.SearchPreviewContainer.backdrop:SetPoint("BOTTOMRIGHT", AchievementFrame.SearchPreviewContainer.ShowAllSearchResults, 2, -2)

		AchievementFrame.SearchResults:StripTextures()
		AchievementFrame.SearchResults:SetTemplate("Transparent")
		T.SkinCloseButton(AchievementFrame.SearchResults.CloseButton)
	end

	-- ScrollBars
	T.SkinScrollBar(AchievementFrameCategoriesContainerScrollBar)
	T.SkinScrollBar(AchievementFrameAchievementsContainerScrollBar)
	T.SkinScrollBar(AchievementFrameStatsContainerScrollBar)
	T.SkinScrollBar(AchievementFrameComparisonContainerScrollBar)
	T.SkinScrollBar(AchievementFrameComparisonStatsContainerScrollBar)

	-- Tabs
	for i = 1, T.Wrath and 2 or 3 do
		T.SkinTab(_G["AchievementFrameTab"..i])
		_G["AchievementFrameTab"..i]:SetFrameLevel(_G["AchievementFrameTab"..i]:GetFrameLevel() + 2)
	end

	local function SkinStatusBar(bar, comparison)
		bar:StripTextures()
		bar:SetStatusBarTexture(C.media.texture)
		bar:SetStatusBarColor(0, 0.7, 0.1)
		bar:CreateBackdrop("Overlay")

		if comparison then
			local title = bar.Title
			local text = bar.Text

			if title then
				title:SetPoint("LEFT", 4, 0)
			end

			if text then
				text:SetPoint("CENTER")
			end
		else
			local title = _G[bar:GetName().."Title"]
			local label = _G[bar:GetName().."Label"]
			local text = _G[bar:GetName().."Text"]

			if title then
				title:SetPoint("LEFT", 4, 0)
			end

			if label then
				label:SetPoint("LEFT", 4, 0)
			end

			if text then
				text:SetPoint("RIGHT", -4, 0)
			end
		end
	end

	SkinStatusBar(AchievementFrameSummaryCategoriesStatusBar)

	SkinStatusBar(AchievementFrameComparisonSummaryPlayerStatusBar)
	SkinStatusBar(AchievementFrameComparisonSummaryFriendStatusBar)
	AchievementFrameComparisonSummaryFriendStatusBar.text:ClearAllPoints()
	AchievementFrameComparisonSummaryFriendStatusBar.text:SetPoint("CENTER")
	AchievementFrameComparisonHeader:SetPoint("BOTTOMRIGHT", AchievementFrameComparison, "TOPRIGHT", 45, -20)

	for i = 1, 8 do
		local frame = _G["AchievementFrameSummaryCategoriesCategory"..i]
		local button = _G["AchievementFrameSummaryCategoriesCategory"..i.."Button"]
		local highlight = _G["AchievementFrameSummaryCategoriesCategory"..i.."ButtonHighlight"]

		SkinStatusBar(frame)
		button:StripTextures()
		highlight:StripTextures()

		if frame.Label then
			frame.Label:SetPoint("LEFT", frame, "LEFT", 4, 0)
		end

		_G[highlight:GetName().."Middle"]:SetColorTexture(1, 1, 1, 0.3)
		_G[highlight:GetName().."Middle"]:SetAllPoints(frame)
	end

	local numTab = 0
	AchievementFrame:HookScript("OnShow", function()
		for i = 1, 20 do
			local frame = _G["AchievementFrameCategoriesContainerButton"..i]

			if frame and not frame.isSkinned then
				frame:StripTextures()
				frame:StyleButton()
				frame.isSkinned = true
			end
		end
		if C_AddOns.IsAddOnLoaded("Krowi_AchievementFilter") then
			local tab = _G["AchievementFrameTab4"]
			if tab and not tab.isSkinned then
				T.SkinTab(tab)
				tab.isSkinned = true
				numTab = 1
			end
		end
		if C_AddOns.IsAddOnLoaded("Overachiever_Tabs") then
			for i = 4 + numTab, 6 + numTab do
				local tab = _G["AchievementFrameTab"..i]
				if tab and not tab.isSkinned then
					T.SkinTab(tab)
					tab.isSkinned = true
				end
			end
		end
		AchievementFrameTab1:SetPoint("TOPLEFT", AchievementFrame, "BOTTOMLEFT", 17, 2)
	end)

	hooksecurefunc("AchievementButton_DisplayAchievement", function(frame, category, achievement)
		local _, _, _, completed = GetAchievementInfo(category, achievement)
		if completed then
			if frame.accountWide and frame.bg3 then
				frame.bg3:SetColorTexture(0.1, 0.6, 0.8)
				frame.label:SetTextColor(0.1, 0.6, 0.8)
			elseif frame.bg3 then
				frame.bg3:SetColorTexture(unpack(C.media.border_color))
				frame.label:SetTextColor(1, 0.82, 0)
			end
		else
			if frame.accountWide and frame.bg3 then
				frame.bg3:SetColorTexture(0.1, 0.6, 0.8)
				frame.label:SetTextColor(0.6, 0.6, 0.6)
			elseif frame.bg3 then
				frame.bg3:SetColorTexture(unpack(C.media.border_color))
				frame.label:SetTextColor(0.6, 0.6, 0.6)
			end
		end
	end)

	hooksecurefunc("AchievementFrameSummary_UpdateAchievements", function()
		for i = 1, ACHIEVEMENTUI_MAX_SUMMARY_ACHIEVEMENTS do
			local frame = _G["AchievementFrameSummaryAchievement"..i]
			_G["AchievementFrameSummaryAchievement"..i.."Highlight"]:Kill()
			frame:StripTextures()

			_G["AchievementFrameSummaryAchievement"..i.."Description"]:SetTextColor(0.6, 0.6, 0.6)
			_G["AchievementFrameSummaryAchievement"..i.."Description"]:SetShadowOffset(1, -1)

			if not frame.backdrop then
				frame:CreateBackdrop("Overlay")
				frame.backdrop:SetPoint("TOPLEFT", 2, -2)
				frame.backdrop:SetPoint("BOTTOMRIGHT", -2, 2)

				_G["AchievementFrameSummaryAchievement"..i.."IconBling"]:Kill()
				_G["AchievementFrameSummaryAchievement"..i.."IconOverlay"]:Kill()
				_G["AchievementFrameSummaryAchievement"..i.."Icon"]:SetTemplate("Default")
				_G["AchievementFrameSummaryAchievement"..i.."Icon"]:SetHeight(_G["AchievementFrameSummaryAchievement"..i.."Icon"]:GetHeight() - 14)
				_G["AchievementFrameSummaryAchievement"..i.."Icon"]:SetWidth(_G["AchievementFrameSummaryAchievement"..i.."Icon"]:GetWidth() - 14)
				_G["AchievementFrameSummaryAchievement"..i.."Icon"]:ClearAllPoints()
				_G["AchievementFrameSummaryAchievement"..i.."Icon"]:SetPoint("LEFT", 6, 0)
				_G["AchievementFrameSummaryAchievement"..i.."IconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				_G["AchievementFrameSummaryAchievement"..i.."IconTexture"]:ClearAllPoints()
				_G["AchievementFrameSummaryAchievement"..i.."IconTexture"]:SetPoint("TOPLEFT", 2, -2)
				_G["AchievementFrameSummaryAchievement"..i.."IconTexture"]:SetPoint("BOTTOMRIGHT", -2, 2)
			end

			if frame.accountWide and AchievementFrameHeaderTitle:GetText() == _G.ACHIEVEMENT_TITLE then
				frame.backdrop:SetBackdropBorderColor(ACHIEVEMENT_BLUE_BORDER_COLOR:GetRGB())
			else
				frame.backdrop:SetBackdropBorderColor(unpack(C.media.border_color))
			end
		end
	end)

	for i = 1, 7 do
		local frame = _G["AchievementFrameAchievementsContainerButton"..i]
		_G["AchievementFrameAchievementsContainerButton"..i.."Highlight"]:Kill()
		frame:StripTextures(true)

		-- Initiate method of creating a backdrop
		frame.bg1 = frame:CreateTexture(nil, "BACKGROUND")
		frame.bg1:SetDrawLayer("BACKGROUND", 4)
		frame.bg1:SetTexture(C.media.blank)
		frame.bg1:SetVertexColor(0.1, 0.1, 0.1)
		frame.bg1:SetPoint("TOPLEFT", T.mult * 4, -T.mult * 4)
		frame.bg1:SetPoint("BOTTOMRIGHT", -T.mult * 4, T.mult * 4)

		frame.bg2 = frame:CreateTexture(nil, "BACKGROUND")
		frame.bg2:SetDrawLayer("BACKGROUND", 3)
		frame.bg2:SetColorTexture(0, 0, 0)
		frame.bg2:SetPoint("TOPLEFT", T.mult * 3, -T.mult * 3)
		frame.bg2:SetPoint("BOTTOMRIGHT", -T.mult * 3, T.mult * 3)

		frame.bg3 = frame:CreateTexture(nil, "BACKGROUND")
		frame.bg3:SetDrawLayer("BACKGROUND", 2)
		frame.bg3:SetColorTexture(unpack(C.media.border_color))
		frame.bg3:SetPoint("TOPLEFT", T.mult * 2, -T.mult * 2)
		frame.bg3:SetPoint("BOTTOMRIGHT", -T.mult * 2, T.mult * 2)

		frame.bg4 = frame:CreateTexture(nil, "BACKGROUND")
		frame.bg4:SetDrawLayer("BACKGROUND", 1)
		frame.bg4:SetColorTexture(0, 0, 0)
		frame.bg4:SetPoint("TOPLEFT", T.mult, -T.mult)
		frame.bg4:SetPoint("BOTTOMRIGHT", -T.mult, T.mult)

		_G["AchievementFrameAchievementsContainerButton"..i.."Description"]:SetTextColor(0.6, 0.6, 0.6)
		_G["AchievementFrameAchievementsContainerButton"..i.."Description"].SetTextColor = T.dummy
		_G["AchievementFrameAchievementsContainerButton"..i.."Description"]:SetShadowOffset(1, -1)
		_G["AchievementFrameAchievementsContainerButton"..i.."Description"].SetShadowOffset = T.dummy
		_G["AchievementFrameAchievementsContainerButton"..i.."HiddenDescription"]:SetTextColor(1, 1, 1)
		_G["AchievementFrameAchievementsContainerButton"..i.."HiddenDescription"].SetTextColor = T.dummy

		_G["AchievementFrameAchievementsContainerButton"..i.."IconBling"]:Kill()
		_G["AchievementFrameAchievementsContainerButton"..i.."IconOverlay"]:Kill()
		_G["AchievementFrameAchievementsContainerButton"..i.."Icon"]:SetTemplate("Default")
		_G["AchievementFrameAchievementsContainerButton"..i.."Icon"]:SetHeight(_G["AchievementFrameAchievementsContainerButton"..i.."Icon"]:GetHeight() - 14)
		_G["AchievementFrameAchievementsContainerButton"..i.."Icon"]:SetWidth(_G["AchievementFrameAchievementsContainerButton"..i.."Icon"]:GetWidth() - 14)
		_G["AchievementFrameAchievementsContainerButton"..i.."Icon"]:ClearAllPoints()
		_G["AchievementFrameAchievementsContainerButton"..i.."Icon"]:SetPoint("LEFT", 6, 0)
		_G["AchievementFrameAchievementsContainerButton"..i.."IconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		_G["AchievementFrameAchievementsContainerButton"..i.."IconTexture"]:ClearAllPoints()
		_G["AchievementFrameAchievementsContainerButton"..i.."IconTexture"]:SetPoint("TOPLEFT", 2, -2)
		_G["AchievementFrameAchievementsContainerButton"..i.."IconTexture"]:SetPoint("BOTTOMRIGHT", -2, 2)

		_G["AchievementFrameAchievementsContainerButton"..i.."Tracked"]:StripTextures()
		_G["AchievementFrameAchievementsContainerButton"..i.."Tracked"]:SetTemplate("Default")
		_G["AchievementFrameAchievementsContainerButton"..i.."Tracked"]:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
		_G["AchievementFrameAchievementsContainerButton"..i.."Tracked"]:SetSize(12, 12)
		_G["AchievementFrameAchievementsContainerButton"..i.."Tracked"]:GetCheckedTexture():SetPoint("TOPLEFT", -4, 4)
		_G["AchievementFrameAchievementsContainerButton"..i.."Tracked"]:GetCheckedTexture():SetPoint("BOTTOMRIGHT", 4, -4)

		_G["AchievementFrameAchievementsContainerButton"..i.."Tracked"]:ClearAllPoints()
		_G["AchievementFrameAchievementsContainerButton"..i.."Tracked"]:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 5, 5)

		_G["AchievementFrameAchievementsContainerButton"..i.."Tracked"].ClearAllPoints = T.dummy
		_G["AchievementFrameAchievementsContainerButton"..i.."Tracked"].SetPoint = T.dummy
	end

	local compares = {
		"Player",
		"Friend"
	}

	for _, compare in pairs(compares) do
		for i = 1, 9 do
			local frame = "AchievementFrameComparisonContainerButton"..i..compare

			_G[frame]:StripTextures()
			_G[frame.."Background"]:Kill()

			if _G[frame.."Description"] then
				_G[frame.."Description"]:SetTextColor(0.6, 0.6, 0.6)
				_G[frame.."Description"].SetTextColor = T.dummy
			end

			-- Initiate method of creating a backdrop
			_G[frame].bg1 = _G[frame]:CreateTexture(nil, "BACKGROUND")
			_G[frame].bg1:SetDrawLayer("BACKGROUND", 4)
			_G[frame].bg1:SetTexture(C.media.blank)
			_G[frame].bg1:SetVertexColor(0.1, 0.1, 0.1)
			_G[frame].bg1:SetPoint("TOPLEFT", T.mult * 4, -T.mult * 4)
			_G[frame].bg1:SetPoint("BOTTOMRIGHT", -T.mult * 4, T.mult * 4)

			_G[frame].bg2 = _G[frame]:CreateTexture(nil, "BACKGROUND")
			_G[frame].bg2:SetDrawLayer("BACKGROUND", 3)
			_G[frame].bg2:SetColorTexture(0, 0, 0)
			_G[frame].bg2:SetPoint("TOPLEFT", T.mult * 3, -T.mult * 3)
			_G[frame].bg2:SetPoint("BOTTOMRIGHT", -T.mult * 3, T.mult * 3)

			_G[frame].bg3 = _G[frame]:CreateTexture(nil, "BACKGROUND")
			_G[frame].bg3:SetDrawLayer("BACKGROUND", 2)
			_G[frame].bg3:SetColorTexture(unpack(C.media.border_color))
			_G[frame].bg3:SetPoint("TOPLEFT", T.mult * 2, -T.mult * 2)
			_G[frame].bg3:SetPoint("BOTTOMRIGHT", -T.mult * 2, T.mult * 2)

			_G[frame].bg4 = _G[frame]:CreateTexture(nil, "BACKGROUND")
			_G[frame].bg4:SetDrawLayer("BACKGROUND", 1)
			_G[frame].bg4:SetColorTexture(0, 0, 0)
			_G[frame].bg4:SetPoint("TOPLEFT", T.mult, -T.mult)
			_G[frame].bg4:SetPoint("BOTTOMRIGHT", -T.mult, T.mult)

			if compare == "Friend" then
				_G[frame.."Shield"]:SetPoint("TOPRIGHT", _G["AchievementFrameComparisonContainerButton"..i.."Friend"], "TOPRIGHT", -20, -2)
			end

			_G[frame.."IconBling"]:Kill()
			_G[frame.."IconOverlay"]:Kill()
			_G[frame.."Icon"]:SetTemplate("Default")
			_G[frame.."Icon"]:SetHeight(_G[frame.."Icon"]:GetHeight() - 14)
			_G[frame.."Icon"]:SetWidth(_G[frame.."Icon"]:GetWidth() - 14)
			_G[frame.."Icon"]:ClearAllPoints()
			_G[frame.."Icon"]:SetPoint("LEFT", 6, 0)
			_G[frame.."IconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			_G[frame.."IconTexture"]:ClearAllPoints()
			_G[frame.."IconTexture"]:SetPoint("TOPLEFT", 2, -2)
			_G[frame.."IconTexture"]:SetPoint("BOTTOMRIGHT", -2, 2)
		end
	end

	hooksecurefunc("AchievementFrameComparison_DisplayAchievement", function(button)
		local player = button.player
		local friend = button.friend
		player.titleBar:Kill()
		if friend.titleBar then
			friend.titleBar:Kill()
		end

		if not player.bg3 or not friend.bg3 then return end

		if player.accountWide then
			player.bg3:SetColorTexture(ACHIEVEMENT_BLUE_BORDER_COLOR:GetRGB())
		else
			player.bg3:SetColorTexture(unpack(C.media.border_color))
		end

		if friend.accountWide then
			friend.bg3:SetColorTexture(ACHIEVEMENT_BLUE_BORDER_COLOR:GetRGB())
		else
			friend.bg3:SetColorTexture(unpack(C.media.border_color))
		end
	end)

	for i = 1, 20 do
		local frame = _G["AchievementFrameStatsContainerButton"..i]
		frame:StyleButton()

		_G["AchievementFrameStatsContainerButton"..i.."BG"]:SetColorTexture(1, 1, 1, 0.2)
		_G["AchievementFrameStatsContainerButton"..i.."HeaderLeft"]:Kill()
		_G["AchievementFrameStatsContainerButton"..i.."HeaderRight"]:Kill()
		_G["AchievementFrameStatsContainerButton"..i.."HeaderMiddle"]:Kill()

		local frame = "AchievementFrameComparisonStatsContainerButton"..i
		_G[frame]:StripTextures()
		_G[frame]:StyleButton()

		_G[frame.."BG"]:SetColorTexture(1, 1, 1, 0.2)
		_G[frame.."HeaderLeft"]:Kill()
		_G[frame.."HeaderRight"]:Kill()
		_G[frame.."HeaderMiddle"]:Kill()
	end

	hooksecurefunc("AchievementButton_GetProgressBar", function(index)
		local frame = _G["AchievementFrameProgressBar"..index]
		if frame then
			if not frame.skinned then
				frame:StripTextures()
				frame:SetStatusBarTexture(C.media.texture)
				frame:SetStatusBarColor(0, 0.7, 0.1)
				frame:SetFrameLevel(frame:GetFrameLevel() + 3)
				frame:SetHeight(frame:GetHeight() - 2)

				frame.bg1 = frame:CreateTexture(nil, "BACKGROUND")
				frame.bg1:SetDrawLayer("BACKGROUND", -7)
				frame.bg1:SetColorTexture(unpack(C.media.backdrop_color))
				frame.bg1:SetPoint("TOPLEFT", -T.mult * 3, T.mult * 3)
				frame.bg1:SetPoint("BOTTOMRIGHT", T.mult * 3, -T.mult * 3)

				frame.bg2 = frame:CreateTexture(nil, "BACKGROUND")
				frame.bg2:SetDrawLayer("BACKGROUND", -6)
				frame.bg2:SetColorTexture(unpack(C.media.border_color))
				frame.bg2:SetPoint("TOPLEFT", -T.mult * 2, T.mult * 2)
				frame.bg2:SetPoint("BOTTOMRIGHT", T.mult * 2, -T.mult * 2)

				frame.bg3 = frame:CreateTexture(nil, "BACKGROUND")
				frame.bg3:SetDrawLayer("BACKGROUND", -5)
				frame.bg3:SetColorTexture(unpack(C.media.backdrop_color))
				frame.bg3:SetPoint("TOPLEFT", -T.mult, T.mult)
				frame.bg3:SetPoint("BOTTOMRIGHT", T.mult, -T.mult)

				frame.bg4 = frame:CreateTexture(nil, "BACKGROUND")
				frame.bg4:SetDrawLayer("BACKGROUND", -4)
				frame.bg4:SetColorTexture(0.1, 0.1, 0.1)
				frame.bg4:SetPoint("TOPLEFT", 0, 0)
				frame.bg4:SetPoint("BOTTOMRIGHT", 0, 0)

				frame.text:ClearAllPoints()
				frame.text:SetPoint("CENTER", frame, "CENTER", 0, -1)
				frame.text:SetJustifyH("CENTER")

				if index > 1 then
					frame:ClearAllPoints()
					frame:SetPoint("TOP", _G["AchievementFrameProgressBar"..index-1], "BOTTOM", 0, -5)
					frame.SetPoint = T.dummy
					frame.ClearAllPoints = T.dummy
				end

				frame.skinned = true
			end
		end
	end)

	hooksecurefunc("AchievementObjectives_DisplayCriteria", function(objectivesFrame, id)
		local numCriteria = GetAchievementNumCriteria(id)
		local textStrings, metas = 0, 0
		for i = 1, numCriteria do
			local _, criteriaType, completed, _, _, _, _, assetID = GetAchievementCriteriaInfo(id, i)

			if criteriaType == CRITERIA_TYPE_ACHIEVEMENT and assetID then
				metas = metas + 1
				local metaCriteria = AchievementButton_GetMeta(metas)
				if objectivesFrame.completed and completed then
					metaCriteria.label:SetTextColor(1, 1, 1, 1)
					metaCriteria.label:SetShadowOffset(1, -1)
				elseif completed then
					metaCriteria.label:SetTextColor(0, 1, 0, 1)
					metaCriteria.label:SetShadowOffset(1, -1)
				else
					metaCriteria.label:SetTextColor(0.6, 0.6, 0.6, 1)
					metaCriteria.label:SetShadowOffset(1, -1)
				end
			elseif criteriaType ~= 1 then
				textStrings = textStrings + 1
				local criteria = AchievementButton_GetCriteria(textStrings)
				if objectivesFrame.completed and completed then
					criteria.name:SetTextColor(1, 1, 1, 1)
					criteria.name:SetShadowOffset(1, -1)
				elseif completed then
					criteria.name:SetTextColor(0, 1, 0, 1)
					criteria.name:SetShadowOffset(1, -1)
				else
					criteria.name:SetTextColor(0.6, 0.6, 0.6, 1)
					criteria.name:SetShadowOffset(1, -1)
				end
			end
		end
	end)
end

T.SkinFuncs["Blizzard_AchievementUI"] = LoadSkin
