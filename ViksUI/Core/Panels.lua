local T, C, L = unpack(ViksUI)

----------------------------------------------------------------------------------------
-- Default Size Values
----------------------------------------------------------------------------------------
--//Using uiscale and Tw to calculate width on some panels
local uiscale = T.mult
local Tw = 1920
local classcolor = RAID_CLASS_COLORS[select(2, UnitClass("player"))]

CPwidth = C.panels.CPwidth 					-- Width for Left and RIght side panels that holds text. 
CPLwidth = C.panels.CPLwidth 					-- Width for Left and RIght side panels that holds text. 
CPTextheight = C.panels.CPTextheight 			-- Hight for panel where chat window is inside
CPbarsheight = C.panels.CPbarsheight 			-- Hight for Panels under/above Chat window
CPABarSide = C.panels.CPABarSide 				-- Width for Action Bars next to chat windows
CPXPBa_r = C.panels.CPXPBa_r 					-- Hight for the XP bar above Left Chat
xoffset = C.panels.xoffset 					-- Horisontal spacing between panels
yoffset = C.panels.yoffset 					-- Vertical spacing between panels
CPSidesWidth = C.panels.CPSidesWidth 			-- Width of panels that is used to hold dmg meter and threathbar (Recount & Omen) 
CPMABwidth = C.panels.CPMABwidth				-- Width for Main Actionbar
CPMABheight = C.panels.CPMABheight 			-- Hight for Main Actionbar
CPMAByoffset = C.panels.CPMAByoffset 			-- Hight for Main Actionbar
CPCooldheight = C.panels.CPCooldheight 		-- Hight for Cooldown Bar
CPTop = C.panels.CPTop 						-- Width for Top Panels
CPMinimap = C.minimap.size 					-- Width/Hight for Minimap Panel
Pscale = C.misc.Pscale						-- Can be used to resize all panels. It does not change X Y Values
thickness = 1

if C.panels.NoPanels == true then
C.media.pxfontHFlag = "OUTLINE"
C.media.pixel_font_style = "OUTLINEMONOCHROME"
end


if C.panels.NoPanels == true then
pAlpha = 0
else
pAlpha = 1
end

local DeBuffsAnchor = CreateFrame("Frame", "DeBuffsAnchor", UIParent)
DeBuffsAnchor:SetPoint(unpack(C.position.player_debuffs))
DeBuffsAnchor:SetSize((C.aura.player_debuff_size + 8) * 6, C.aura.player_debuff_size + 4)

----------------------------------------------------------------------------------------
--	Bottom bars anchor
----------------------------------------------------------------------------------------
local BottomBarAnchor = CreateFrame("Frame", "ActionBarAnchor", T_PetBattleFrameHider or UIParent)
BottomBarAnchor:CreatePanel("Invisible", 1, 1, unpack(C.position.bottom_bars))
BottomBarAnchor:SetWidth((C.actionbar.button_size * 12) + (C.actionbar.button_space * 11))
if C.actionbar.bottombars == 2 then
	BottomBarAnchor:SetHeight((C.actionbar.button_size * 2) + C.actionbar.button_space)
elseif C.actionbar.bottombars == 3 then
	if C.actionbar.split_bars == true then
		BottomBarAnchor:SetHeight((C.actionbar.button_size * 2) + C.actionbar.button_space)
	else
		BottomBarAnchor:SetHeight((C.actionbar.button_size * 3) + (C.actionbar.button_space * 2))
	end
else
	BottomBarAnchor:SetHeight(C.actionbar.button_size)
end
BottomBarAnchor:SetFrameStrata("LOW")

----------------------------------------------------------------------------------------
--	Right bars anchor
----------------------------------------------------------------------------------------
local RightBarAnchor = CreateFrame("Frame", "RightActionBarAnchor", T_PetBattleFrameHider or UIParent)
RightBarAnchor:CreatePanel("Invisible", 1, 1, unpack(C.position.right_bars))
RightBarAnchor:SetHeight((C.actionbar.button_size * 12) + (C.actionbar.button_space * 11))
if C.actionbar.rightbars == 1 then
	RightBarAnchor:SetWidth(C.actionbar.button_size)
elseif C.actionbar.rightbars == 2 then
	RightBarAnchor:SetWidth((C.actionbar.button_size * 2) + C.actionbar.button_space)
elseif C.actionbar.rightbars == 3 then
	RightBarAnchor:SetWidth((C.actionbar.button_size * 3) + (C.actionbar.button_space * 2))
else
	RightBarAnchor:Hide()
end
RightBarAnchor:SetFrameStrata("LOW")

----------------------------------------------------------------------------------------
--	Split bar anchor
----------------------------------------------------------------------------------------
if C.actionbar.split_bars == true then
	local SplitBarLeft = CreateFrame("Frame", "SplitBarLeft", T_PetBattleFrameHider or UIParent)
	SplitBarLeft:CreatePanel("Invisible", (C.actionbar.button_size * 3) + (C.actionbar.button_space * 3), (C.actionbar.button_size * 2) + C.actionbar.button_space, "BOTTOMRIGHT", ActionBarAnchor, "BOTTOMLEFT", 0, 0)
	SplitBarLeft:SetFrameStrata("LOW")

	local SplitBarRight = CreateFrame("Frame", "SplitBarRight", T_PetBattleFrameHider or UIParent)
	SplitBarRight:CreatePanel("Invisible", (C.actionbar.button_size * 3) + (C.actionbar.button_space * 3), (C.actionbar.button_size * 2) + C.actionbar.button_space, "BOTTOMLEFT", ActionBarAnchor, "BOTTOMRIGHT", 0, 0)
	SplitBarRight:SetFrameStrata("LOW")
end

----------------------------------------------------------------------------------------
--	Pet bar anchor
----------------------------------------------------------------------------------------
local PetBarAnchor = CreateFrame("Frame", "PetActionBarAnchor", T_PetBattleFrameHider or UIParent)
if C.actionbar.petbar_horizontal == true then
	PetBarAnchor:CreatePanel("Invisible", (C.actionbar.button_size * 10) + (C.actionbar.button_space * 9), C.actionbar.button_size, unpack(C.position.pet_horizontal))
elseif C.actionbar.rightbars > 0 then
	PetBarAnchor:CreatePanel("Invisible", C.actionbar.button_size + C.actionbar.button_space, (C.actionbar.button_size * 10) + (C.actionbar.button_space * 9), "RIGHT", RightBarAnchor, "LEFT", 0, 0)
else
	PetBarAnchor:CreatePanel("Invisible", (C.actionbar.button_size + C.actionbar.button_space), (C.actionbar.button_size * 10) + (C.actionbar.button_space * 9), unpack(C.position.right_bars))
end
PetBarAnchor:SetFrameStrata("LOW")
if T.Classic then
	RegisterStateDriver(PetBarAnchor, "visibility", "[pet,nooverridebar,novehicleui,nopossessbar] show; hide")
else
	RegisterStateDriver(PetBarAnchor, "visibility", "[pet,novehicleui,nopossessbar,nopetbattle] show; hide")
end

----------------------------------------------------------------------------------------
--	Stance bar anchor
----------------------------------------------------------------------------------------
local StanceAnchor = CreateFrame("Frame", "StanceBarAnchor", T_PetBattleFrameHider or UIParent)
StanceAnchor:SetFrameStrata("LOW")
if C.actionbar.stancebar_horizontal == true then
	if C.actionbar.petbar_horizontal == true then
		StanceAnchor:SetPoint(C.position.stance_bar[1], C.position.stance_bar[2], C.position.stance_bar[3], C.position.stance_bar[4], C.position.stance_bar[5] - (C.actionbar.button_size + C.actionbar.button_space))
	else
		StanceAnchor:SetPoint(unpack(C.position.stance_bar))
	end
	StanceAnchor:SetWidth((C.actionbar.button_size * 7) + (C.actionbar.button_space * 6))
	StanceAnchor:SetHeight(C.actionbar.button_size)
else
	if C.actionbar.petbar_horizontal == true then
		StanceAnchor:SetPoint("RIGHT", "RightActionBarAnchor", "LEFT", 0, (C.actionbar.button_size / 2) + 2)
	else
		StanceAnchor:SetPoint("RIGHT", PetActionBarAnchor:IsShown() and "PetActionBarAnchor" or "RightActionBarAnchor", "LEFT", 0, (C.actionbar.button_size / 2) + 2)
		PetBarAnchor:HookScript("OnShow", function() if InCombatLockdown() then return end StanceAnchor:SetPoint("RIGHT", "PetActionBarAnchor", "LEFT", 0, (C.actionbar.button_size / 2) + 2) end)
		PetBarAnchor:HookScript("OnHide", function() if InCombatLockdown() then return end StanceAnchor:SetPoint("RIGHT", "RightActionBarAnchor", "LEFT", 0, (C.actionbar.button_size / 2) + 2) end)
	end
	StanceAnchor:SetWidth(C.actionbar.button_size + C.actionbar.button_space)
	StanceAnchor:SetHeight((C.actionbar.button_size * 7) + (C.actionbar.button_space * 6))
end

StanceAnchor:RegisterEvent("PLAYER_LOGIN")
StanceAnchor:RegisterEvent("PLAYER_ENTERING_WORLD")
StanceAnchor:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
StanceAnchor:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
if T.Wrath or T.Cata or T.Mists or T.Mainline then
	StanceAnchor:RegisterUnitEvent("PLAYER_SPECIALIZATION_CHANGED", "player", "")
end
StanceAnchor:SetScript("OnEvent", function()
	local forms = GetNumShapeshiftForms()
	if forms > 0 and not InCombatLockdown() then
		if C.actionbar.stancebar_horizontal == true then
			StanceAnchor:SetWidth((C.actionbar.button_size * forms) + (C.actionbar.button_space * (forms - 1)))
		else
			StanceAnchor:SetHeight((C.actionbar.button_size * forms) + (C.actionbar.button_space * (forms - 1)))
		end
	end
	if T.Mainline then
		if not StanceAnchor.hook then
			RegisterStateDriver(StanceAnchor, "visibility", GetNumShapeshiftForms() == 0 and "hide" or "show")
			StanceAnchor.hook = true
		end
	end
end)

----------------------------------------------------------------------------------------
-- LEFT Panels
----------------------------------------------------------------------------------------

--Left Bottom Panel
local LBottom = CreateFrame("Frame", "LBottom", UIParent, "BackdropTemplate")
LBottom:CreatePanel("Transparent", CPwidth*Pscale, CPbarsheight*Pscale, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", xoffset, yoffset)
LBottom:SetFrameLevel(2)
LBottom:SetAlpha(pAlpha)

--Left Chat Panel
local LChat = CreateFrame("Frame", "LChat", UIParent, "BackdropTemplate")
if C.panels.NoPanels == true then
LChat:CreatePanel("Invisible", (CPLwidth*Pscale)-2, (CPTextheight+16)*Pscale, "BOTTOMLEFT", LBottom, "TOPLEFT", 10, yoffset)
LChat:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b,0)
LChat:SetBackdropColor(0, 0, 0, C.chat.background_alpha)
CreateShadow(LChat)
else
LChat:CreatePanel("Transparent", CPwidth*Pscale, CPTextheight*Pscale, "BOTTOMLEFT", LBottom, "TOPLEFT", 0, yoffset)
LChat:SetFrameLevel(2)
--LChat:SetAlpha(pAlpha)
end

--Left Chat Tab Panel
local LChatTab = CreateFrame("Frame", "LChatTab", UIParent, "BackdropTemplate")		
LChatTab:CreatePanel("Transparent", CPwidth*Pscale, CPbarsheight*Pscale, "BOTTOMLEFT", LChat, "TOPLEFT", 0, yoffset+1)
LChatTab:SetFrameLevel(2)
LChatTab:SetAlpha(pAlpha)

-- Left Action Bar Next to chat
local LABar = CreateFrame("Frame", "LABar", UIParent, "BackdropTemplate")
LABar:CreatePanel("Transparent", CPABarSide*Pscale, Pscale*(CPbarsheight+yoffset+CPTextheight+CPbarsheight+yoffset+1), "BOTTOMLEFT", LBottom, "BOTTOMRIGHT", xoffset, 0)
LABar:SetFrameLevel(2)
LABar:SetAlpha(pAlpha)

----------------------------------------------------------------------------------------
-- RIGHT SIDE PANELS
----------------------------------------------------------------------------------------

--Right Bottom Panel
local RBottom = CreateFrame("Frame", "RBottom", UIParent)
RBottom:CreatePanel("Transparent", Pscale*CPwidth, Pscale*CPbarsheight, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -xoffset, yoffset)
RBottom:SetFrameLevel(2)
RBottom:SetAlpha(pAlpha)

--Right Chat Panel
local RChat = CreateFrame("Frame", "RChat", UIParent)
if C.panels.NoPanels == true then
RChat:CreatePanel("Invisible", (CPLwidth*Pscale)-2, (CPTextheight+16)*Pscale, "BOTTOMLEFT", RBottom, "TOPLEFT", -100, yoffset)
RChat:SetBackdropBorderColor(T.color.r, T.color.g, T.color.b,0)
RChat:SetBackdropColor(0, 0, 0, C.chat.background_alpha)
CreateShadow(RChat)
--chatbd:SetTemplate("Transparent", "Shadow")
else
RChat:CreatePanel("Transparent", Pscale*CPwidth, Pscale*CPTextheight, "BOTTOMLEFT", RBottom, "TOPLEFT", 0, yoffset)
RChat:SetFrameLevel(2)
RChat:SetAlpha(pAlpha)
end

--Right Chat Tab Panel
local RChatTab = CreateFrame("Frame", "RChatTab", UIParent)
RChatTab:CreatePanel("Transparent", Pscale*CPwidth, Pscale*CPbarsheight, "BOTTOMLEFT", RChat, "TOPLEFT", 0, yoffset+1)
RChatTab:SetFrameLevel(2)
RChatTab:SetAlpha(pAlpha)

-- Right Action Bar Next to chat
local RABar = CreateFrame("Frame", "RABar", UIParent)
RABar:CreatePanel("Transparent", Pscale*CPABarSide, Pscale*(CPbarsheight+yoffset+CPTextheight+CPbarsheight+yoffset+1), "BOTTOMRIGHT", RBottom, "BOTTOMLEFT", -xoffset, 0)
RABar:SetFrameLevel(2)
RABar:SetAlpha(pAlpha)


--Background Panel For Omen if used
if C_AddOns.IsAddOnLoaded("Omen") then
local R_Omen = CreateFrame("Frame", "R_Omen",OmenBarList)
R_Omen:CreatePanel("Transparent", Pscale*CPSidesWidth, Pscale*(CPbarsheight+yoffset+CPTextheight+CPbarsheight+yoffset), "BOTTOMRIGHT", RABar, "BOTTOMLEFT", -xoffset, 0)
R_Omen:SetFrameLevel(2)
R_Omen:SetAlpha(pAlpha)
 else

end

--Background Panel For Details if used

if C_AddOns.IsAddOnLoaded("Details") then
local L_Details = CreateFrame("Frame", "L_Details", Details_WindowFrame3)
L_Details:CreatePanel("Transparent", (Pscale*CPSidesWidth)-10, LABar:GetHeight(), "BOTTOMLEFT", LABar, "BOTTOMRIGHT", xoffset, 0)
L_Details:SetFrameLevel(2)
L_Details:SetAlpha(pAlpha)

local R1_Details = CreateFrame("Frame", "R1_Details", Details_WindowFrame1)
R1_Details:CreatePanel("Transparent", (Pscale*CPSidesWidth)-8, (Pscale*(CPbarsheight+yoffset+CPTextheight+CPbarsheight+yoffset))*0.5, "BOTTOMRIGHT", RABar, "BOTTOMLEFT", -xoffset, 0)
R1_Details:SetFrameLevel(2)
R1_Details:SetAlpha(pAlpha)

local R2_Details = CreateFrame("Frame", "R2_Details", Details_WindowFrame2)
R2_Details:CreatePanel("Transparent", (Pscale*CPSidesWidth)-8, (Pscale*(CPbarsheight+yoffset+CPTextheight+CPbarsheight+yoffset))*0.49, "TOPRIGHT", RABar, "TOPLEFT", -xoffset, 0)
R2_Details:SetFrameLevel(2)
R2_Details:SetAlpha(pAlpha)

RegisterStateDriver(L_Details, "visibility", "[petbattle] hide; show")
RegisterStateDriver(R1_Details, "visibility", "[petbattle] hide; show")
RegisterStateDriver(R2_Details, "visibility", "[petbattle] hide; show")
end

----------------------------------------------------------------------------------------
-- OTHER PANELS
----------------------------------------------------------------------------------------
if C.media.pxfontHsize > 13 then
CPToppHight = C.media.pxfontHsize
else
CPToppHight = CPbarsheight
end

--Top of Screen Panel
local CPTopp = CreateFrame("Frame", "CPTopp",UIParent)
CPTopp:CreatePanel("Transparent", 1, CPToppHight, "TOP", UIParent, "TOP", 0, -1)
CPTopp:SetPoint("LEFT", UIParent, "LEFT", 3, 0)
CPTopp:SetPoint("RIGHT", UIParent, "RIGHT", -3, 0)
CPTopp:SetFrameLevel(2)
CPTopp:SetAlpha(pAlpha)

if C.panels.NoPanels ~= true then


	--Background for Minimap Button 1, Right
	local CPMinimb1 = CreateFrame("Frame", "CPMinimb1",UIParent)
	CPMinimb1:CreatePanel("Transparent", (.5*(Pscale*CPMinimap))-(xoffset/2), Pscale*CPbarsheight, "TOPRIGHT", Minimap, "BOTTOMRIGHT", 2, -6)
	CPMinimb1:SetFrameLevel(2)
	if C.minimap.minimb1 == true then
	CPMinimb1:SetAlpha(pAlpha)
	else
	CPMinimb1:SetAlpha(0)
	end

	--Background for Minimap Button 1, LEFT
	local CPMinimb2 = CreateFrame("Frame", "CPMinimb2",UIParent)
	CPMinimb2:CreatePanel("Transparent", (.5*(Pscale*CPMinimap))-(xoffset/2), Pscale*CPbarsheight, "TOPLEFT", Minimap, "BOTTOMLEFT", -2, -6)
	CPMinimb2:SetFrameLevel(2)
	if C.minimap.minimb2 == true then
	CPMinimb2:SetAlpha(pAlpha)
	else
	CPMinimb2:SetAlpha(0)
	end
end

----------------------------------------------------------------------------------------
--	Lines when panels are hidden
----------------------------------------------------------------------------------------

if C.panels.NoPanels == true then

	local Topline = CreateFrame("StatusBar", "Topline", UIParent)
	local TopVerticalRightline = CreateFrame("StatusBar", "TopVerticalRightline", Topline)
	local TopHorizontalRightline = CreateFrame("StatusBar", "TopHorizontalRightline", Topline)
	
	Topline:SetTemplate()
	Topline:SetSize(200, thickness)
	Topline:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 6, -10)
	Topline:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -6, -10)
	Topline:SetFrameLevel(2)
	Topline:SetFrameStrata("BACKGROUND")
	Topline:SetAlpha(1)
	Topline:SetStatusBarTexture(C.media.blank)
	
	TopVerticalRightline:SetTemplate()
	TopVerticalRightline:SetPoint("TOPLEFT", Topline, "TOPRIGHT", 0, 0)
	TopVerticalRightline:SetFrameLevel(2)
	TopVerticalRightline:SetFrameStrata("BACKGROUND")
	TopVerticalRightline:SetAlpha(1)
	TopVerticalRightline:SetParent(Topline)
	TopVerticalRightline:SetSize(thickness, C["minimap"]["size"]+34)
	TopVerticalRightline:SetStatusBarTexture(C.media.blank)

	TopHorizontalRightline:SetTemplate()
	TopHorizontalRightline:SetPoint("TOPRIGHT", TopVerticalRightline, "BOTTOMRIGHT", 0, 0)
	TopHorizontalRightline:SetFrameLevel(2)
	TopHorizontalRightline:SetFrameStrata("BACKGROUND")
	TopHorizontalRightline:SetAlpha(1)
	TopHorizontalRightline:SetParent(Topline)
	TopHorizontalRightline:SetSize(C["minimap"]["size"]+10, thickness)
	TopHorizontalRightline:SetStatusBarTexture(C.media.blank)
	Topline:SetStatusBarColor(unpack(C["media"]["border_color"]))
	TopVerticalRightline:SetStatusBarColor(unpack(C["media"]["border_color"]))
	TopHorizontalRightline:SetStatusBarColor(unpack(C["media"]["border_color"]))
end	
------------------------------------------------------------------------------------------	
-- BOTTOM PANELS/FRAMES LINES
------------------------------------------------------------------------------------------	

	local BottomLine = CreateFrame("StatusBar", "BottomLine", UIParent)
	-- BOTTOMLINE ADJUSTMENTS
	BottomLine:ClearAllPoints()
	BottomLine:SetTemplate()
	BottomLine:SetHeight(thickness)
	BottomLine:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 6, 10)
	BottomLine:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -6, 10)
	BottomLine:SetFrameLevel(2)
	BottomLine:SetFrameStrata("BACKGROUND")
	if C.panels.NoPanels == true then
	BottomLine:SetAlpha(1)
	else
	BottomLine:SetAlpha(0)
	end
	BottomLine:Hide()
	
	local BottomLineStatusBar = CreateFrame("StatusBar", "BottomLineStatusBar", BottomLine)
	BottomLineStatusBar:SetTemplate()
	BottomLineStatusBar:SetHeight(thickness)
	BottomLineStatusBar:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 6, 10)
	BottomLineStatusBar:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -6, 10)
	BottomLineStatusBar:SetFrameLevel(2)
	BottomLineStatusBar:SetFrameStrata("BACKGROUND")
	BottomLineStatusBar:SetAlpha(1)
	BottomLineStatusBar:SetStatusBarTexture(C.media.blank)
	BottomLineStatusBar:SetStatusBarColor(unpack(C["media"]["border_color"]))

	BottomLine:Show()

------------------------------------------------------------------------------------------	
-- LEFT CHAT LINES
------------------------------------------------------------------------------------------
if C.panels.NoPanels == true then	
	local LEFTChatline = CreateFrame("StatusBar", "LEFTChatline", UIParent)
	local LEFTVerticalline = CreateFrame("StatusBar", "LEFTVerticalline", UIParent)
	local RIGHTChatline = CreateFrame("StatusBar", "RIGHTChatline", UIParent)
	local RIGHTVerticalline = CreateFrame("StatusBar", "RIGHTVerticalline", UIParent)
else
	local LEFTChatline = CreateFrame("StatusBar", "LEFTChatline", UIParent)
	local RIGHTChatline = CreateFrame("StatusBar", "RIGHTChatline", UIParent)
end


--if C["Tools"]["chattools"] == true and C["DataTexts"]["Bottomline"] == true then
	-- Left Chat Toolline
	LEFTChatline:SetTemplate()
	LEFTChatline:SetParent(BottomLine)
	LEFTChatline:SetSize(CPLwidth+10, thickness)
	LEFTChatline:SetPoint("BOTTOMLEFT", BottomLine, "TOPLEFT", 0, C["chat"]["height"]+40)
	LEFTChatline:SetFrameLevel(2)
	LEFTChatline:SetFrameStrata("BACKGROUND")
	if C.panels.NoPanels == true then
		LEFTChatline:SetAlpha(1)
	else
		LEFTChatline:SetAlpha(0)
	end
	--LEFTChatline:CreateLineShadow()
	LEFTChatline:SetStatusBarTexture(C.media.blank)
if C.panels.NoPanels == true then	
	-- LEFT VERTICAL Line
	LEFTVerticalline:SetTemplate()
	LEFTVerticalline:SetParent(BottomLine)
	LEFTVerticalline:SetSize(thickness, thickness)
	LEFTVerticalline:SetPoint("BOTTOMLEFT", BottomLine, "BOTTOMLEFT", 0, 0)
	LEFTVerticalline:SetPoint("TOPLEFT", LEFTChatline, "TOPLEFT", 0, 0)
	LEFTVerticalline:SetFrameLevel(2)
	LEFTVerticalline:SetFrameStrata("BACKGROUND")
	LEFTVerticalline:SetAlpha(1)
	--LEFTVerticalline:CreateLineShadow()
	LEFTVerticalline:SetStatusBarTexture(C.media.blank)

	-- show hide button CHAT
	local ChatOptions = CreateFrame("Frame", "ChatOptions", LEFTChatline)
	ChatOptions:SetTemplate()
	ChatOptions:SetSize(((CPLwidth)/3), 30)
	ChatOptions:SetPoint("RIGHT", LEFTChatline, "RIGHT", 0, -20)
	ChatOptions:SetFrameLevel(2)
	ChatOptions:SetFrameStrata("HIGH")
	ChatOptions:SetAlpha(0.0)

	LEFTChatline.icon = LEFTChatline:CreateTexture(nil, "OVERLAY")
	LEFTChatline.icon:SetSize(14, 14)
	LEFTChatline.icon:SetPoint("RIGHT", LEFTChatline, "RIGHT", -60, -20)
	LEFTChatline.icon:SetTexture([[Interface\AddOns\ViksUI\Media\Menuicons\chat.tga]])

	local LEFTChatlinetext = LEFTChatline:CreateFontString(nil, "OVERLAY")
	LEFTChatlinetext:SetFont(C["media"].pixel_font, C["media"].pixel_font_size-2, C["media"].pixel_font_style)
	LEFTChatlinetext:SetPoint("RIGHT", LEFTChatline, "RIGHT", -20, -20)
	LEFTChatlinetext:SetTextColor(unpack(C.media.pxcolor1))
	LEFTChatlinetext:SetText("Chat")		
	
	ChatOptions:SetScript("OnMouseDown", function(self, Button)
		if (Button == "LeftButton") then
			ToggleFrame(ChatMenu)
		end
	end)
	
	ChatOptions:SetScript("OnEnter", function(self)
		LEFTChatlinetext:SetTextColor(classcolor.r, classcolor.g, classcolor.b)
		LEFTChatline.icon:SetVertexColor(classcolor.r, classcolor.g, classcolor.b)
	end)
	
	ChatOptions:SetScript("OnLeave", function(self)
		LEFTChatlinetext:SetTextColor(unpack(C.media.pxcolor1))
		LEFTChatline.icon:SetVertexColor(1, 1, 1)
	end)
end		
------------------------------------------------------------------------------------------	
-- RIGHT CHAT LINES
------------------------------------------------------------------------------------------	
-- RIGHT Chat Toolline		
RIGHTChatline:SetTemplate()
RIGHTChatline:SetSize(CPLwidth+10, thickness)
RIGHTChatline:SetPoint("BOTTOMRIGHT", BottomLine, "TOPRIGHT", 0, C["chat"]["height"]+40)
RIGHTChatline:SetFrameLevel(2)
RIGHTChatline:SetFrameStrata("BACKGROUND")
if C.panels.NoPanels == true then
	RIGHTChatline:SetAlpha(1)
else
	RIGHTChatline:SetAlpha(0)
end

RIGHTChatline:SetStatusBarTexture(C.media.blank)

if C.panels.NoPanels == true then	
	-- RIGHT VERTICAL Line
	RIGHTVerticalline:SetTemplate()
	RIGHTVerticalline:SetParent(BottomLine)
	RIGHTVerticalline:SetSize(thickness, thickness)
	RIGHTVerticalline:SetPoint("BOTTOMRIGHT", BottomLine, "BOTTOMRIGHT", 0, 0)
	RIGHTVerticalline:SetPoint("TOPRIGHT", RIGHTChatline, "TOPRIGHT", 0, 0)
	RIGHTVerticalline:SetFrameLevel(2)
	RIGHTVerticalline:SetFrameStrata("BACKGROUND")
	RIGHTVerticalline:SetAlpha(1)
	RIGHTVerticalline:SetStatusBarTexture(C.media.blank)
	LEFTChatline:SetStatusBarColor(unpack(C["media"]["border_color"]))
	LEFTVerticalline:SetStatusBarColor(unpack(C["media"]["border_color"]))
	RIGHTChatline:SetStatusBarColor(unpack(C["media"]["border_color"]))
	RIGHTVerticalline:SetStatusBarColor(unpack(C["media"]["border_color"]))
end	

local CPMAB = CreateFrame("Frame", "CPMAB",UIParent)
CPMAB:CreatePanel("Transparent", Pscale*CPMABwidth, Pscale*CPMABheight, "BOTTOM", UIParent, "BOTTOM", 0, CPMAByoffset)
CPMAB:SetFrameLevel(2)
if C.panels.NoPanels == true then
CPMAB:SetBackdropColor(0,0,0,0)
end

--RegisterStateDriver(CPCool, "visibility", "[petbattle] hide; show")
RegisterStateDriver(CPMAB, "visibility", "[petbattle] hide; show")

--Backgrounds for Extra Actionbar Buttons
if C.misc.BT4Bars == true then
 -- Right side Actionbar (Close to right edge)
local SideBar = CreateFrame("Frame", "SideBar", UIParent)
SideBar:CreatePanel("Transparent", 1+(CPABarSide*Pscale), Pscale*(400), "RIGHT", UIParent, "RIGHT", -xoffset, 1)
SideBar:SetFrameLevel(2)
SideBar:SetAlpha(pAlpha)
if T.class == "DRUID" then SideBar:SetAlpha(0) end

 -- Left Side Action Bar Next to chat
local EBarL = CreateFrame("Frame", "EBarL", UIParent)
EBarL:CreatePanel("Transparent", ((Pscale*((CPMABwidth/13)*3))*0.75), 0.75*(Pscale*CPMABheight), "RIGHT", CPMAB, "LEFT", -10, 0)
EBarL:SetFrameLevel(2)
EBarL:SetAlpha(pAlpha)

 -- Left Side Action Bar Next to chat
local EBarR = CreateFrame("Frame", "EBarR", UIParent) -- Left Side Action Bar Next to chat
EBarR:CreatePanel("Transparent", ((Pscale*((CPMABwidth/13)*3))*0.75), 0.75*(Pscale*CPMABheight), "LEFT", CPMAB, "RIGHT", 10, 0)
EBarR:SetFrameLevel(2)
EBarR:SetAlpha(pAlpha)

RegisterStateDriver(SideBar, "visibility", "[petbattle] hide; show")
RegisterStateDriver(EBarL, "visibility", "[petbattle] hide; show")
RegisterStateDriver(EBarR, "visibility", "[petbattle] hide; show")

if C.panels.HideABPanels == true then
	EBarL:SetAlpha(0)
	EBarR:SetAlpha(0)
	SideBar:SetAlpha(0)
end
end

----------------------------------------------------
-- DATA TEXT Panels
----------------------------------------------------

-- Panel 1
local DataTextP1 = CreateFrame("Frame", "DataTextP1", UIParent) 			
DataTextP1:CreatePanel("Transparent", (CPwidth*Pscale/3), CPbarsheight*Pscale, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", xoffset, yoffset)
DataTextP1:SetFrameLevel(2)
DataTextP1:SetAlpha(0)

-- Panel 2
local DataTextP2 = CreateFrame("Frame", "DataTextP2", UIParent) 			
DataTextP2:CreatePanel("Transparent", (CPwidth*Pscale/3), CPbarsheight*Pscale, "CENTER", DataTextP1, "CENTER", ((CPwidth*Pscale/3)), 0)
DataTextP2:SetFrameLevel(2)
DataTextP2:SetAlpha(0)

-- Panel 3
local DataTextP3 = CreateFrame("Frame", "DataTextP3", UIParent) 			
DataTextP3:CreatePanel("Transparent", (CPwidth*Pscale/3), CPbarsheight*Pscale, "CENTER", DataTextP2, "CENTER", ((CPwidth*Pscale/3)), 0)
DataTextP3:SetFrameLevel(2)
DataTextP3:SetAlpha(0)

-- Panel 6
local DataTextP6 = CreateFrame("Frame", "DataTextP6", UIParent) 			
DataTextP6:CreatePanel("Transparent", (CPwidth*Pscale/3), CPbarsheight*Pscale, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -xoffset, yoffset)
DataTextP6:SetFrameLevel(2)
DataTextP6:SetAlpha(0)

-- Panel 5
local DataTextP5 = CreateFrame("Frame", "DataTextP5", UIParent) 			
DataTextP5:CreatePanel("Transparent", (CPwidth*Pscale/3), CPbarsheight*Pscale, "CENTER", DataTextP6, "CENTER", -((CPwidth*Pscale/3)), 0)
DataTextP5:SetFrameLevel(2)
DataTextP5:SetAlpha(0)

-- Panel 4
local DataTextP4 = CreateFrame("Frame", "DataTextP4", UIParent) 			
DataTextP4:CreatePanel("Transparent", (CPwidth*Pscale/3), CPbarsheight*Pscale, "CENTER", DataTextP5, "CENTER", -((CPwidth*Pscale/3)), 0)
DataTextP4:SetFrameLevel(2)
DataTextP4:SetAlpha(0)

-- Panel 7
local DataTextP7 = CreateFrame("Frame", "DataTextP7", UIParent) 			
DataTextP7:CreatePanel("Transparent", ((Tw/uiscale)/5), CPbarsheight*Pscale, "TOP", UIParent, "TOP", 0, 0)
DataTextP7:SetFrameLevel(2)
DataTextP7:SetAlpha(0)

-- Panel 8
local DataTextP8 = CreateFrame("Frame", "DataTextP8", UIParent) 			
DataTextP8:CreatePanel("Transparent", ((Tw/uiscale)/5)*2, CPbarsheight*Pscale, "TOPLEFT", UIParent, "TOPLEFT", 0, 0)
DataTextP8:SetFrameLevel(2)
DataTextP8:SetAlpha(0)

-- Panel 9
local DataTextP9 = CreateFrame("Frame", "DataTextP9", UIParent) 			
DataTextP9:CreatePanel("Transparent", ((Tw/uiscale)/5)*2, CPbarsheight*Pscale, "TOPRIGHT", UIParent, "TOPRIGHT", 0, 0)
DataTextP9:SetFrameLevel(2)
DataTextP9:SetAlpha(0)

-- Panel 10
local DataTextP10 = CreateFrame("Frame", "DataTextP10", UIParent)
if C.panels.NoPanels == true then 			
DataTextP10:CreatePanel("Transparent", (Pscale*CPMinimap)/2, CPbarsheight*Pscale, "RIGHT", TopHorizontalRightline, "RIGHT", -3, -2)
else
DataTextP10:CreatePanel("Transparent", (Pscale*CPMinimap)/2, CPbarsheight*Pscale, "RIGHT", CPMinimb1, "RIGHT", 0, -2)
end
DataTextP10:SetFrameLevel(2)
DataTextP10:SetAlpha(0)

-- Panel 11
local DataTextP11 = CreateFrame("Frame", "DataTextP11", UIParent) 			
DataTextP11:CreatePanel("Transparent", (Pscale*CPMinimap)/2, CPbarsheight*Pscale, "TOPRIGHT", DataTextP10, "TOPLEFT",  0, 0)
DataTextP11:SetFrameLevel(2)
DataTextP11:SetAlpha(0)

-- Panel 12
local DataTextP12 = CreateFrame("Frame", "DataTextP12", UIParent) 			
DataTextP12:CreatePanel("Transparent", ((Tw/uiscale)/5), CPbarsheight*Pscale, "BOTTOM", UIParent, "BOTTOM", 0, 0)
DataTextP12:SetFrameLevel(2)
DataTextP12:SetAlpha(0)

----------------------------------------------------------------------------------------
--	Hide Panels behind actionbars
----------------------------------------------------------------------------------------
if C.panels.HideABPanels == true or C.actionbar.enable == true then
CPMAB:SetAlpha(0)
RABar:SetAlpha(0)
LABar:SetAlpha(0)
EBarL:SetAlpha(0)
EBarR:SetAlpha(0)
SideBar:SetAlpha(0)
end

----------------------------------------------------------------------------------------
--	Top panel
----------------------------------------------------------------------------------------
if C.toppanel.enable ~= true then return end

C.toppanel.height = C.toppanel.height + ((C.font.stats_font_size - 8) * 7)
C.toppanel.width = C.toppanel.width + ((C.font.stats_font_size - 8) * 3)

local toppanelanchor = CreateFrame("Frame", "TopPanelAnchor", T_PetBattleFrameHider)
toppanelanchor:SetPoint(unpack(C.position.top_panel))
toppanelanchor:SetSize(C.toppanel.width, C.toppanel.height / 2)

local toppanel = CreateFrame("Frame", "TopPanel", T_PetBattleFrameHider)
toppanel:SetPoint("CENTER", toppanelanchor, "CENTER", 0, 0)
toppanel:SetSize(C.toppanel.width, C.toppanel.height / 2)
if C.toppanel.mouseover == true then
	toppanel:SetAlpha(0)
	toppanel:SetScript("OnEnter", function()
		if InCombatLockdown() then return end
		toppanel:SetAlpha(1)
	end)
	toppanel:SetScript("OnLeave", function()
		toppanel:SetAlpha(0)
	end)
end

local r, g, b = unpack(C.media.classborder_color)
toppanel.bgl = toppanel:CreateTexture(nil, "BORDER")
toppanel.bgl:SetPoint("RIGHT", toppanel, "CENTER", 0, 0)
toppanel.bgl:SetSize(C.toppanel.width / 2, C.toppanel.height / 2)
toppanel.bgl:SetTexture(C.media.blank)
toppanel.bgl:SetGradient("HORIZONTAL", CreateColor(r, g, b, 0), CreateColor(r, g, b, 0.1))

toppanel.bgr = toppanel:CreateTexture(nil, "BORDER")
toppanel.bgr:SetPoint("LEFT", toppanel, "CENTER", 0, 0)
toppanel.bgr:SetSize(C.toppanel.width / 2, C.toppanel.height / 2)
toppanel.bgr:SetTexture(C.media.blank)
toppanel.bgr:SetGradient("HORIZONTAL", CreateColor(r, g, b, 0.1), CreateColor(r, g, b, 0))

toppanel.tbl = toppanel:CreateTexture(nil, "ARTWORK")
toppanel.tbl:SetPoint("RIGHT", toppanel, "TOP", 0, 0)
toppanel.tbl:SetSize(C.toppanel.width / 2, 3)
toppanel.tbl:SetTexture(C.media.blank)
toppanel.tbl:SetGradient("HORIZONTAL", CreateColor(0, 0, 0, 0), CreateColor(0, 0, 0, 1))

toppanel.tcl = toppanel:CreateTexture(nil, "OVERLAY")
toppanel.tcl:SetPoint("RIGHT", toppanel, "TOP", 0, 0)
toppanel.tcl:SetSize(C.toppanel.width / 2, 1)
toppanel.tcl:SetTexture(C.media.blank)
toppanel.tcl:SetGradient("HORIZONTAL", CreateColor(r, g, b, 0), CreateColor(r, g, b, 1))

toppanel.tbr = toppanel:CreateTexture(nil, "ARTWORK")
toppanel.tbr:SetPoint("LEFT", toppanel, "TOP", 0, 0)
toppanel.tbr:SetSize(C.toppanel.width / 2, 3)
toppanel.tbr:SetTexture(C.media.blank)
toppanel.tbr:SetGradient("HORIZONTAL", CreateColor(0, 0, 0, 1), CreateColor(0, 0, 0, 0))

toppanel.tcr = toppanel:CreateTexture(nil, "OVERLAY")
toppanel.tcr:SetPoint("LEFT", toppanel, "TOP", 0, 0)
toppanel.tcr:SetSize(C.toppanel.width / 2, 1)
toppanel.tcr:SetTexture(C.media.blank)
toppanel.tcr:SetGradient("HORIZONTAL", CreateColor(r, g, b, 1), CreateColor(r, g, b, 0))

toppanel.bbl = toppanel:CreateTexture(nil, "ARTWORK")
toppanel.bbl:SetPoint("RIGHT", toppanel, "BOTTOM", 0, 0)
toppanel.bbl:SetSize(C.toppanel.width / 2, 3)
toppanel.bbl:SetTexture(C.media.blank)
toppanel.bbl:SetGradient("HORIZONTAL", CreateColor(0, 0, 0, 0), CreateColor(0, 0, 0, 1))

toppanel.bcl = toppanel:CreateTexture(nil, "OVERLAY")
toppanel.bcl:SetPoint("RIGHT", toppanel, "BOTTOM", 0, 0)
toppanel.bcl:SetSize(C.toppanel.width / 2, 1)
toppanel.bcl:SetTexture(C.media.blank)
toppanel.bcl:SetGradient("HORIZONTAL", CreateColor(r, g, b, 0), CreateColor(r, g, b, 1))

toppanel.bbr = toppanel:CreateTexture(nil, "ARTWORK")
toppanel.bbr:SetPoint("LEFT", toppanel, "BOTTOM", 0, 0)
toppanel.bbr:SetSize(C.toppanel.width / 2, 3)
toppanel.bbr:SetTexture(C.media.blank)
toppanel.bbr:SetGradient("HORIZONTAL", CreateColor(0, 0, 0, 1), CreateColor(0, 0, 0, 0))

toppanel.bcr = toppanel:CreateTexture(nil, "OVERLAY")
toppanel.bcr:SetPoint("LEFT", toppanel, "BOTTOM", 0, 0)
toppanel.bcr:SetSize(C.toppanel.width / 2, 1)
toppanel.bcr:SetTexture(C.media.blank)
toppanel.bcr:SetGradient("HORIZONTAL", CreateColor(r, g, b, 1), CreateColor(r, g, b, 0))