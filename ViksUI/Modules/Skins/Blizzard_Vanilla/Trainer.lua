local T, C, L = unpack(ViksUI)
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	TrainerUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	ClassTrainerFrame:StripTextures(true)
	ClassTrainerFrame:CreateBackdrop("Transparent")
	ClassTrainerFrame.backdrop:SetPoint("TOPLEFT", 10, -12)
	ClassTrainerFrame.backdrop:SetPoint("BOTTOMRIGHT", -32, 76)

	T.SkinCloseButton(ClassTrainerFrameCloseButton, ClassTrainerFrame.backdrop)

	ClassTrainerNameText:ClearAllPoints()
	ClassTrainerNameText:SetPoint("TOP", ClassTrainerFrame.backdrop, "TOP", 0, -6)
	ClassTrainerGreetingText:ClearAllPoints()
	ClassTrainerGreetingText:SetPoint("TOP", ClassTrainerNameText, "BOTTOM", 0, -4)

	ClassTrainerCancelButton:SkinButton()
	ClassTrainerTrainButton:SkinButton()
	ClassTrainerTrainButton:ClearAllPoints()
	ClassTrainerTrainButton:SetPoint("RIGHT", ClassTrainerCancelButton, "LEFT", -2, 0)

	T.SkinFilter(ClassTrainerFrame.FilterDropdown)
	-- ClassTrainerFrameFilterDropdown:ClearAllPoints()
	-- ClassTrainerFrameFilterDropdown:SetPoint("TOPLEFT", ClassTrainerFrame.backdrop, "TOPRIGHT", -182, -56)

	ClassTrainerListScrollFrame:StripTextures()
	T.SkinScrollBar(ClassTrainerListScrollFrameScrollBar)

	ClassTrainerDetailScrollFrame:StripTextures()
	T.SkinScrollBar(ClassTrainerDetailScrollFrameScrollBar)

	if ClassTrainerSkillIcon then
		ClassTrainerSkillIcon:StripTextures()
		ClassTrainerSkillIcon:SkinButton()
	end

	hooksecurefunc("ClassTrainer_SetSelection", function()
		if ClassTrainerSkillIcon:GetNormalTexture() then
			ClassTrainerSkillIcon:GetNormalTexture():ClearAllPoints()
			ClassTrainerSkillIcon:GetNormalTexture():SetPoint("TOPLEFT", 2, -2)
			ClassTrainerSkillIcon:GetNormalTexture():SetPoint("BOTTOMRIGHT", -2, 2)
			ClassTrainerSkillIcon:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
		end
	end)

	ClassTrainerExpandButtonFrame:StripTextures()
	ClassTrainerCollapseAllButton:StripTextures()
	T.SkinExpandOrCollapse(ClassTrainerCollapseAllButton)

	for i = 1, CLASS_TRAINER_SKILLS_DISPLAYED do
		T.SkinExpandOrCollapse(_G["ClassTrainerSkill"..i])
	end
end

T.SkinFuncs["Blizzard_TrainerUI"] = LoadSkin
