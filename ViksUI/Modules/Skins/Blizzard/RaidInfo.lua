local T, C, L = unpack(ViksUI)
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	RaidInfo skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local StripAllTextures = {
		RaidInfoScrollFrame,
		RaidInfoFrame,
		RaidInfoInstanceLabel,
		RaidInfoIDLabel,
		RaidInfoFrame.Header
	}

	local KillTextures = {
		RaidInfoScrollFrameScrollBarBG,
		RaidInfoScrollFrameScrollBarTop,
		RaidInfoScrollFrameScrollBarBottom,
		RaidInfoScrollFrameScrollBarMiddle
	}

	local buttons = {
		RaidFrameConvertToRaidButton,
		RaidFrameRaidInfoButton,
		RaidInfoExtendButton,
		RaidInfoCancelButton
	}

	for _, object in pairs(StripAllTextures) do
		object:StripTextures()
	end

	if T.Mainline then
		for _, texture in pairs(KillTextures) do
			texture:Kill()
		end
	end

	for i = 1, #buttons do
		local button = buttons[i]
		if button then
			button:SkinButton()
		end
	end

	RaidInfoFrame:CreateBackdrop("Transparent")
	RaidInfoFrame.backdrop:SetPoint("TOPLEFT", RaidInfoFrame, "TOPLEFT")
	RaidInfoFrame.backdrop:SetPoint("BOTTOMRIGHT", RaidInfoFrame, "BOTTOMRIGHT")
	RaidInfoFrame:SetPoint("TOPLEFT", FriendsFrame, "TOPRIGHT", 3, 0)
	T.SkinCloseButton(RaidInfoCloseButton, RaidInfoFrame)
	T.SkinCheckBox(RaidFrameAllAssistCheckButton)
	if RaidInfoScrollFrameScrollBar then
		T.SkinScrollBar(RaidInfoScrollFrameScrollBar)
	else
		T.SkinScrollBar(RaidInfoFrame.ScrollBar)
	end
end

tinsert(T.SkinFuncs["ViksUI"], LoadSkin)