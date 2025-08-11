local T, C, L = unpack(ViksUI)
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	ItemText skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	ItemTextFrame:StripTextures(true)
	ItemTextScrollFrame:StripTextures()
	ItemTextFrame:CreateBackdrop("Transparent")
	ItemTextFrame.backdrop:SetPoint("TOPLEFT", 10, -12)
	ItemTextFrame.backdrop:SetPoint("BOTTOMRIGHT", -32, 76)

	ItemTextTitleText:ClearAllPoints()
	ItemTextTitleText:SetPoint("TOP", ItemTextFrame.backdrop, "TOP", 0, -6)

	ItemTextCurrentPage:ClearAllPoints()
	ItemTextCurrentPage:SetPoint("TOP", ItemTextFrame.backdrop, "TOP", 0, -44)

	T.SkinCloseButton(ItemTextCloseButton, ItemTextFrame.backdrop)

	T.SkinNextPrevButton(ItemTextPrevPageButton)
	ItemTextPrevPageButton:ClearAllPoints()
	ItemTextPrevPageButton:SetPoint("TOPLEFT", ItemTextFrame, "TOPLEFT", 48, -50)
	T.SkinNextPrevButton(ItemTextNextPageButton)
	ItemTextNextPageButton:ClearAllPoints()
	ItemTextNextPageButton:SetPoint("TOPRIGHT", ItemTextFrame, "TOPRIGHT", -70, -50)

	T.SkinScrollBar(ItemTextScrollFrameScrollBar)

	ItemTextPageText:SetTextColor("P", 1, 1, 1)
	ItemTextPageText.SetTextColor = T.dummy
end

tinsert(T.SkinFuncs["ViksUI"], LoadSkin)
