local T, C, L = unpack(ViksUI)
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Taxi skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	TaxiFrame:StripTextures()
	TaxiFrame:CreateBackdrop("Transparent")
	TaxiFrame.backdrop:SetPoint("TOPLEFT", 10, -12)
	TaxiFrame.backdrop:SetPoint("BOTTOMRIGHT", -32, 76)

	TaxiRouteMap:CreateBackdrop("Default")

	TaxiPortrait:Kill()

	T.SkinCloseButton(TaxiCloseButton, TaxiFrame.backdrop)

	TaxiMerchant:ClearAllPoints()
	TaxiMerchant:SetPoint("TOP", TaxiFrame.backdrop, "TOP", 0, -6)
end

tinsert(T.SkinFuncs["ViksUI"], LoadSkin)
