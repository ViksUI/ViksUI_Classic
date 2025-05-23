local T, C, L = unpack(ViksUI)
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	RaidUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	local StripAllTextures = {
		"RaidGroup1",
		"RaidGroup2",
		"RaidGroup3",
		"RaidGroup4",
		"RaidGroup5",
		"RaidGroup6",
		"RaidGroup7",
		"RaidGroup8"
	}

	for _, object in pairs(StripAllTextures) do
		_G[object]:StripTextures()
	end

	for i = 1, MAX_RAID_GROUPS * 5 do
		_G["RaidGroupButton"..i]:SkinButton(true)
	end

	if T.Classic then
		_G["RaidFrameReadyCheckButton"]:SkinButton()
	end

	for i = 1, 8 do
		for j = 1, 5 do
			_G["RaidGroup"..i.."Slot"..j]:StripTextures()
			_G["RaidGroup"..i.."Slot"..j]:SetTemplate("Transparent")
		end
	end
end

T.SkinFuncs["Blizzard_RaidUI"] = LoadSkin
