local T, C, L = unpack(ViksUI)
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	AddonList skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local buttons = {
		"AddonListEnableAllButton",
		"AddonListDisableAllButton",
		"AddonListCancelButton",
		"AddonListOkayButton"
	}

	for _, button in pairs(buttons) do
		_G[button]:SkinButton()
	end

	AddonList:StripTextures()
	AddonList:SetTemplate("Transparent")
	AddonList:SetHeight(AddonList:GetHeight() + 3)

	AddonListInset:StripTextures()
	AddonListInset:SetTemplate("Overlay")
	AddonListInset:SetPoint("BOTTOMRIGHT", -6, 29)

	if T.Classic then
		for i = 1, MAX_ADDONS_DISPLAYED do
			T.SkinCheckBox(_G["AddonListEntry"..i.."Enabled"], nil, true)
			_G["AddonListEntry"..i.."Load"]:SkinButton()
		end
	else
		local function forceSaturation(self, _, force)
			if force then return end
			self:SetVertexColor(0.6, 0.6, 0.6)
			self:SetDesaturated(true, true)
		end

		hooksecurefunc("AddonList_InitButton", function(child)
			if not child.styled then
				T.SkinCheckBox(child.Enabled)
				child.LoadAddonButton:SkinButton()
				hooksecurefunc(child.Enabled:GetCheckedTexture(), "SetDesaturated", forceSaturation)

				T.ReplaceIconString(child.Title)
				hooksecurefunc(child.Title, "SetText", T.ReplaceIconString)

				child.styled = true
			end
		end)
	end

	if T.Classic then
		AddonListScrollFrame:StripTextures()
		T.SkinScrollBar(AddonListScrollFrameScrollBar)
	else
		T.SkinScrollBar(AddonList.ScrollBar)
	end
	T.SkinCloseButton(AddonListCloseButton)
	T.SkinDropDownBox(AddonList.Dropdown)
	T.SkinCheckBox(AddonListForceLoad)
	AddonListForceLoad:SetSize(25, 25)
end

tinsert(T.SkinFuncs["ViksUI"], LoadSkin)
