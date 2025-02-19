local T, C, L = unpack(ViksUI)
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	GuildRegistrar skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	GuildRegistrarFrame:StripTextures(true)
	GuildRegistrarFrame:CreateBackdrop("Transparent")
	if T.Classic then
		GuildRegistrarFrame.backdrop:SetPoint("TOPLEFT", 10, -12)
		GuildRegistrarFrame.backdrop:SetPoint("BOTTOMRIGHT", -32, 76)
	else
		GuildRegistrarFrameInset:StripTextures()
		GuildRegistrarFrame.backdrop:SetAllPoints()
	end

	GuildRegistrarGreetingFrame:StripTextures()
	GuildRegistrarFramePortrait:SetAlpha(0)

	GuildRegistrarFramePurchaseButton:SkinButton()
	GuildRegistrarFrameCancelButton:SkinButton()
	GuildRegistrarFrameGoodbyeButton:SkinButton()
	GuildRegistrarFramePurchaseButton:ClearAllPoints()
	GuildRegistrarFramePurchaseButton:SetPoint("BOTTOMLEFT", GuildRegistrarFrame.backdrop, "BOTTOMLEFT", 4, 4)
	GuildRegistrarFrameCancelButton:ClearAllPoints()
	GuildRegistrarFrameCancelButton:SetPoint("BOTTOMRIGHT", GuildRegistrarFrame.backdrop, "BOTTOMRIGHT", -4, 4)
	GuildRegistrarFrameGoodbyeButton:ClearAllPoints()
	GuildRegistrarFrameGoodbyeButton:SetPoint("BOTTOMRIGHT", GuildRegistrarFrame.backdrop, "BOTTOMRIGHT", -4, 4)

	T.SkinCloseButton(GuildRegistrarFrameCloseButton, GuildRegistrarFrame.backdrop)

	PetitionFrameNpcNameText:ClearAllPoints()
	PetitionFrameNpcNameText:SetPoint("TOP", GuildRegistrarFrame.backdrop, "TOP", 0, -6)

	GuildRegistrarFrameEditBox:StripTextures(true)
	T.SkinEditBox(GuildRegistrarFrameEditBox, nil, GuildRegistrarFrameEditBox:GetHeight() - 15)

	for i = 1, 2 do
		_G["GuildRegistrarButton"..i]:GetFontString():SetTextColor(1, 1, 1)
	end

	GuildRegistrarPurchaseText:SetTextColor(1, 1, 1)
	if T.Classic then
		GuildAvailableServicesText:SetTextColor(1, 0.8, 0)
		GuildAvailableServicesText:SetShadowColor(0, 0, 0)
	else
		AvailableServicesText:SetTextColor(1, 0.8, 0)
		AvailableServicesText:SetShadowColor(0, 0, 0)
	end
end

tinsert(T.SkinFuncs["ViksUI"], LoadSkin)