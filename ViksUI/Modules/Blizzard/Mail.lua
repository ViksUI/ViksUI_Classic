local T, C, L = unpack(ViksUI)
if C_AddOns.IsAddOnLoaded("OpenAll") or C_AddOns.IsAddOnLoaded("Postal") or C_AddOns.IsAddOnLoaded("TradeSkillMaster_Mailing") then return end

----------------------------------------------------------------------------------------
--	Grab mail in 1 button(OpenAll by Kemayo)
----------------------------------------------------------------------------------------
local deletedelay, t = 0.5, 0
local takingOnlyCash = false
local button, button2, waitForMail, openAll, openAllCash, openMail, lastopened, stopOpening, onEvent, needsToWait, copper_to_pretty_money, total_cash
local baseInboxFrame_OnClick
-- local profit = 0

function openAll()
	if GetInboxNumItems() == 0 then return end
	button:SetScript("OnClick", nil)
	button2:SetScript("OnClick", nil)
	baseInboxFrame_OnClick = InboxFrame_OnClick
	InboxFrame_OnClick = function() end
	button:RegisterEvent("UI_ERROR_MESSAGE")
	openMail(GetInboxNumItems())
end

function openAllCash()
	takingOnlyCash = true
	openAll()
end

function openMail(index)
	if not InboxFrame:IsVisible() then return stopOpening(L_MAIL_NEED) end
	if index == 0 then
		if T.Classic then
			MiniMapMailFrame:Hide()
		else
			MinimapCluster.IndicatorFrame.MailFrame:Hide()
		end
		return stopOpening(L_MAIL_COMPLETE)
	end

	local _, _, _, _, money, COD, _, numItems = GetInboxHeaderInfo(index)
	if money > 0 then
		TakeInboxMoney(index)
		needsToWait = true
		if total_cash then total_cash = total_cash - money end
		-- profit = profit + money
	elseif (not takingOnlyCash) and (numItems and numItems > 0) and COD <= 0 then
		TakeInboxItem(index)
		needsToWait = true
	end
	local items = GetInboxNumItems()
	if (numItems and numItems > 0) or (items > 1 and index <= items) then
		lastopened = index
		t = 0
		button:SetScript("OnUpdate", waitForMail)
	else
		stopOpening(L_MAIL_COMPLETE)
		if T.Classic then
			MiniMapMailFrame:Hide()
		else
			MinimapCluster.IndicatorFrame.MailFrame:Hide()
		end
	end
end

function waitForMail(_, elapsed)
	t = t + elapsed
	if (not needsToWait) or (t > deletedelay) then
		needsToWait = false
		button:SetScript("OnUpdate", nil)
		local _, _, _, _, money, COD, _, numItems = GetInboxHeaderInfo(lastopened)
		if money > 0 or ((not takingOnlyCash) and COD <= 0 and numItems and (numItems > 0)) then
			openMail(lastopened)
		else
			openMail(lastopened - 1)
		end
	end
end

function copper_to_pretty_money(c)
	if c > 10000 then
		return ("%d|cffffd700"..GOLD_AMOUNT_SYMBOL.."|r %d|cffc7c7cf"..SILVER_AMOUNT_SYMBOL.."|r %d|cffeda55f"..COPPER_AMOUNT_SYMBOL.."|r"):format(c / 10000, (c / 100) % 100, c % 100)
	elseif c > 100 then
		return ("%d|cffc7c7cf"..SILVER_AMOUNT_SYMBOL.."|r %d|cffeda55f"..COPPER_AMOUNT_SYMBOL.."|r"):format((c / 100) % 100, c % 100)
	else
		return ("%d|cffeda55f"..COPPER_AMOUNT_SYMBOL.."|r"):format(c % 100)
	end
end

function stopOpening(msg)
	button:SetScript("OnUpdate", nil)
	button:SetScript("OnClick", openAll)
	button2:SetScript("OnClick", openAllCash)
	if baseInboxFrame_OnClick then
		InboxFrame_OnClick = baseInboxFrame_OnClick
	end
	button:UnregisterEvent("UI_ERROR_MESSAGE")
	takingOnlyCash = false
	total_cash = nil
	if msg then print("|cffffff00"..msg.."|r") end
	-- if profit > 0 then print(format("|cff66C6FF%s |cffFFFFFF%s", AMOUNT_RECEIVED_COLON, copper_to_pretty_money(profit))) profit = 0 end
end

function onEvent(_, event, _, text)
	if event == "UI_ERROR_MESSAGE" then
		if text == ERR_INV_FULL then
			stopOpening(L_MAIL_STOPPED)
		elseif text == ERR_ITEM_MAX_COUNT then
			stopOpening(L_MAIL_UNIQUE)
		end
	end
end

local function makeButton(id, text, w, h, x, y)
	local button = CreateFrame("Button", id, InboxFrame, "UIPanelButtonTemplate")
	button:SetWidth(w)
	button:SetHeight(h)
	button:SetPoint("CENTER", InboxFrame, "TOP", x, y)
	button:SetText(text)
	return button
end

button = makeButton("OpenAllButton", ALL, 70, 25, -65, -398)
button:SetScript("OnClick", openAll)
button:SetScript("OnEvent", onEvent)
button:SetScript("OnEnter", function()
	GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
	GameTooltip:AddLine(string.format("%d "..L_MAIL_MESSAGES, GetInboxNumItems()), 1, 1, 1)
	GameTooltip:Show()
end)
button:SetScript("OnLeave", function() GameTooltip:Hide() end)

button2 = makeButton("OpenAllButton2", MONEY, 70, 25, 18, -398)
button2:SetScript("OnClick", openAllCash)
button2:SetScript("OnEnter", function()
	if not total_cash then
		total_cash = 0
		for index = 0, GetInboxNumItems() do
			local _, _, _, _, money = GetInboxHeaderInfo(index)
			total_cash = total_cash + money
		end
	end
	GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
	GameTooltip:AddLine(copper_to_pretty_money(total_cash), 1, 1, 1)
	GameTooltip:Show()
end)
button2:SetScript("OnLeave", function() GameTooltip:Hide() end)

if C.skins.blizzard_frames == true then
	OpenAllButton:SkinButton()
	OpenAllButton2:SkinButton()
end

OpenAllMail:Hide() -- 7.2 new button