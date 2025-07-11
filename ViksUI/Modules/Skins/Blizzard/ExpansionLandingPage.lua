local T, C, L = unpack(ViksUI)
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Expansion Landing Page skin
----------------------------------------------------------------------------------------
local function LoadSkin(self)
	local frame = _G.ExpansionLandingPage

	local panel
	if frame.Overlay then
		for i = 1, frame.Overlay:GetNumChildren() do
			local child = select(i, frame.Overlay:GetChildren())
			if child.DragonridingPanel then
				panel = child
				break
			end
		end
	end

	if not panel then return end

	panel.NineSlice:SetAlpha(0)
	panel.Background:SetAlpha(0)
	panel:SetTemplate("Transparent")

	if panel.ScrollFadeOverlay then
		panel.ScrollFadeOverlay:Hide()
	end

	if panel.DragonridingPanel then
		panel.DragonridingPanel.SkillsButton:SkinButton()
	end

	if panel.CloseButton then
		T.SkinCloseButton(panel.CloseButton)
	end

	self:UnregisterEvent("ADDON_LOADED")
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, _, addon)
	if C_AddOns.IsAddOnLoaded("Skinner") or C_AddOns.IsAddOnLoaded("Aurora") then
		self:UnregisterEvent("ADDON_LOADED")
		return
	end
	if ExpansionLandingPage then
		LoadSkin(self)
	end
end)