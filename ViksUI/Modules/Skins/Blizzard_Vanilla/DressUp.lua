local T, C, L = unpack(ViksUI)
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	DressUp skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	DressUpFrame:StripTextures()
	DressUpFrame:CreateBackdrop("Transparent")
	DressUpFrame.backdrop:SetPoint("TOPLEFT", 10, -12)
	DressUpFrame.backdrop:SetPoint("BOTTOMRIGHT", -34, 76)

	DressUpFramePortrait:Hide()

	T.SkinCloseButton(DressUpFrameCloseButton, DressUpFrame.backdrop)

	DressUpFrameTitleText:ClearAllPoints()
	DressUpFrameTitleText:SetPoint("TOP", DressUpFrame.backdrop, "TOP", 0, -5)

	DressUpFrameDescriptionText:ClearAllPoints()
	DressUpFrameDescriptionText:SetPoint("TOP", DressUpFrame.backdrop, "TOP", 0, -25)


	T.SkinRotateButton(DressUpModelFrameRotateLeftButton)
	DressUpModelFrameRotateLeftButton:SetPoint("TOPLEFT", 3, -3)

	T.SkinRotateButton(DressUpModelFrameRotateRightButton)
	DressUpModelFrameRotateRightButton:SetPoint("TOPLEFT", DressUpModelFrameRotateLeftButton, "TOPRIGHT", 3, 0)

	DressUpFrameCancelButton:SkinButton()
	DressUpFrameResetButton:SkinButton()
	DressUpFrameResetButton:SetPoint("RIGHT", DressUpFrameCancelButton, "LEFT", -2, 0)
	if DressUpFrameUndressButton then
		DressUpFrameUndressButton:SkinButton()
	end
end

table.insert(T.SkinFuncs["ViksUI"], LoadSkin)
