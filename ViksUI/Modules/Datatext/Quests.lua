local T, C, L = unpack(ViksUI)
--------------------------------------------------------------------
 -- QUEST DATATEXT
--------------------------------------------------------------------

if C.datatext.Quests and C.datatext.Quests > 0 then
	local Stat = CreateFrame("Frame", "DataTextQuests", UIParent)

	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)

	local Text  = Stat:CreateFontString(nil, "OVERLAY")
	
	if C.datatext.location >= 9 then
		Text:SetTextColor(unpack(C.media.pxcolor1))
		if C.datatext.location ~= 14 or C.datatext.location ~= 15 then
			Text:SetFont(C.media.pxfontHeader, C.media.pxfontHsize-2, C.media.pxfontHFlag)
		else
			Text:SetFont(C.media.pxfontHeader, C.media.pxfontHsize, C.media.pxfontHFlag)
		end
	else	
		Text:SetTextColor(unpack(C.media.pxcolor1))
		Text:SetFont(C.media.pixel_font, C.media.pixel_font_size, C.media.pixel_font_style)
	end
	
	PP(C.datatext.Quests, Text)

	local function OnEvent(self, event, ...)
		local numEntries, numQuests = GetNumQuestLogEntries()
		Text:SetText("Q |r: "..qColor.. numQuests.. "/25")
		self:SetAllPoints(Text)
		self:SetScript("OnEnter", function()
			if not InCombatLockdown() then
				GameTooltip:SetOwner(self, "ANCHOR_TOP", -20, 6);
				GameTooltip:ClearAllPoints()
				GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, 1)
				GameTooltip:ClearLines()
				GameTooltip:AddDoubleLine("Click to toggle ObjectiveTrackerFrame")
				GameTooltip:AddDoubleLine("")
				GameTooltip:Show()
			end
		end)
		self:SetScript("OnLeave", function() GameTooltip:Hide() end)
	end
	
	local expanded = true

	local function QuestWatchCollapse()
		local f = Stat
		--f.plus:Show()
		if C.misc.minimize_mouseover then
			f:SetAlpha(0)
			f:HookScript("OnEnter", function() f:SetAlpha(1) end)
			f:HookScript("OnLeave", function() f:SetAlpha(0) end)
		end
		if T.Vanilla then
		QuestWatchFrame:Hide()
		QuestWatchFrameHeader:Hide()
		end
		if T.Cata then
		_G.WatchFrame:Hide()
		_G.WatchFrame:Hide()
		end
	end

	local function QuestWatchExpand()
		local f = Stat
		--f.plus:Hide()
		if C.misc.minimize_mouseover then
			f:SetAlpha(1)
			f:HookScript("OnEnter", function() f:SetAlpha(1) end)
			f:HookScript("OnLeave", function() f:SetAlpha(1) end)
		end
		if T.Vanilla then
		QuestWatchFrame:Show()
		QuestWatchFrameHeader:Show()
		end
		if T.Cata then
		_G.WatchFrame:Show()
		_G.WatchFrame:Show()
		end
	end

	Stat:SetScript("OnMouseUp", function(self)
		expanded = not expanded
		if expanded then
			QuestWatchExpand()
		else
			QuestWatchCollapse()
		end
	end)
	
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:RegisterEvent("UNIT_QUEST_LOG_CHANGED")
	Stat:RegisterEvent("QUEST_LOG_UPDATE")
	Stat:SetScript("OnEvent", OnEvent)
	Stat:SetScript("OnMouseDown", OnMouseDown)
	
	if T.Mainline then	
		local collapse = CreateFrame("Frame")
		collapse:RegisterEvent("PLAYER_ENTERING_WORLD")
		collapse:SetScript("OnEvent", function(self, event)
			if C.automation.auto_collapse_login == true then
				ObjectiveTracker_Collapse()
			end
		end)
	end
end