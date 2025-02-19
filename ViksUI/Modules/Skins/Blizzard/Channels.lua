local T, C, L = unpack(ViksUI)
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	Channels skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	ChannelFrame:StripTextures()
	ChannelFrame:CreateBackdrop("Transparent")

	ChannelFrame.NewButton:SkinButton()
	ChannelFrame.SettingsButton:SkinButton()

	if T.Classic then
		T.SkinScrollBar(ChannelFrame.ChannelRoster.ScrollFrame.scrollBar)
	else
		T.SkinScrollBar(ChannelFrame.ChannelRoster.ScrollBar)
	end
	T.SkinScrollBar(ChannelFrame.ChannelList.ScrollBar)

	T.SkinCloseButton(ChannelFrameCloseButton)

	CreateChannelPopup:StripTextures()
	CreateChannelPopup:CreateBackdrop("Transparent")

	if T.Mainline then
		CreateChannelPopup.Header:StripTextures()
	end

	CreateChannelPopup.OKButton:SkinButton()
	CreateChannelPopup.CancelButton:SkinButton()

	CreateChannelPopup.OKButton:SetPoint("BOTTOMLEFT", 5, 5)
	CreateChannelPopup.CancelButton:ClearAllPoints()
	CreateChannelPopup.CancelButton:SetPoint("BOTTOMRIGHT", -5, 5)

	CreateChannelPopup.Name.Label:SetDrawLayer("OVERLAY")
	CreateChannelPopup.Password.Label:SetDrawLayer("OVERLAY")
	T.SkinEditBox(CreateChannelPopup.Name)
	T.SkinEditBox(CreateChannelPopup.Password)

	T.SkinCloseButton(CreateChannelPopup.CloseButton)

	VoiceChatPromptActivateChannel:StripTextures()
	VoiceChatPromptActivateChannel:CreateBackdrop("Transparent")
	VoiceChatPromptActivateChannel.AcceptButton:SkinButton()
	T.SkinCloseButton(VoiceChatPromptActivateChannel.CloseButton)

	hooksecurefunc(ChannelButtonHeaderMixin, "Update", function(self)
		if not self.skin then
			self:SkinButton()
			self.skin = true
		end
	end)
end

tinsert(T.SkinFuncs["ViksUI"], LoadSkin)
