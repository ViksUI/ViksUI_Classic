local T, C, L = unpack(ViksUI)
if C.bag.enable ~= true then return end

----------------------------------------------------------------------------------------
--	Based on Stuffing(by Hungtar, editor Tukz)
----------------------------------------------------------------------------------------
local BAGS_BACKPACK = T.Classic and {0, 1, 2, 3, 4} or {0, 1, 2, 3, 4, 5}
local BAGS_BANK = T.Vanilla and {-1, 5, 6, 7, 8, 9, 10} or T.Classic and {-1, 5, 6, 7, 8, 9, 10, 11} or {-1, 6, 7, 8, 9, 10, 11, 12}
local ST_NORMAL = 1
local ST_FISHBAG = 2
local ST_SPECIAL = 3
local ST_QUIVER = 4
local ST_SOULBAG = 5
local bag_bars = 0
local unusable

if T.class == "DEATHKNIGHT" then
	unusable = { -- weapon, armor, dual-wield
		{Enum.ItemWeaponSubclass.Bows, Enum.ItemWeaponSubclass.Guns, Enum.ItemWeaponSubclass.Warglaive, Enum.ItemWeaponSubclass.Staff, Enum.ItemWeaponSubclass.Unarmed, Enum.ItemWeaponSubclass.Dagger, Enum.ItemWeaponSubclass.Thrown, Enum.ItemWeaponSubclass.Crossbow, Enum.ItemWeaponSubclass.Wand},
		{Enum.ItemArmorSubclass.Shield}
	}
elseif T.class == "DEMONHUNTER" then
	unusable = {
		{Enum.ItemWeaponSubclass.Axe2H, Enum.ItemWeaponSubclass.Bows, Enum.ItemWeaponSubclass.Guns, Enum.ItemWeaponSubclass.Mace1H, Enum.ItemWeaponSubclass.Mace2H, Enum.ItemWeaponSubclass.Polearm, Enum.ItemWeaponSubclass.Sword2H, Enum.ItemWeaponSubclass.Staff, Enum.ItemWeaponSubclass.Thrown, Enum.ItemWeaponSubclass.Crossbow, Enum.ItemWeaponSubclass.Wand},
		{Enum.ItemArmorSubclass.Mail, Enum.ItemArmorSubclass.Plate, Enum.ItemArmorSubclass.Shield}
	}
elseif T.class == "DRUID" then
	unusable = {
		{Enum.ItemWeaponSubclass.Axe1H, Enum.ItemWeaponSubclass.Axe2H, Enum.ItemWeaponSubclass.Bows, Enum.ItemWeaponSubclass.Guns, Enum.ItemWeaponSubclass.Sword1H, Enum.ItemWeaponSubclass.Sword2H, Enum.ItemWeaponSubclass.Warglaive, Enum.ItemWeaponSubclass.Thrown, Enum.ItemWeaponSubclass.Crossbow, Enum.ItemWeaponSubclass.Wand},
		{Enum.ItemArmorSubclass.Mail, Enum.ItemArmorSubclass.Plate, Enum.ItemArmorSubclass.Shield},
		true
	}
elseif T.class == "EVOKER" then
	unusable = {
		{Enum.ItemWeaponSubclass.Bows, Enum.ItemWeaponSubclass.Guns, Enum.ItemWeaponSubclass.Polearm, Enum.ItemWeaponSubclass.Warglaive, Enum.ItemWeaponSubclass.Thrown, Enum.ItemWeaponSubclass.Crossbow, Enum.ItemWeaponSubclass.Wand},
		{Enum.ItemArmorSubclass.Plate, Enum.ItemArmorSubclass.Shield},
		true
	}
elseif T.class == "HUNTER" then
	unusable = {
		{Enum.ItemWeaponSubclass.Mace1H, Enum.ItemWeaponSubclass.Mace2H, Enum.ItemWeaponSubclass.Warglaive, Enum.ItemWeaponSubclass.Thrown, Enum.ItemWeaponSubclass.Wand},
		{Enum.ItemArmorSubclass.Plate, Enum.ItemArmorSubclass.Shield}
	}
elseif T.class == "MAGE" then
	unusable = {
		{Enum.ItemWeaponSubclass.Axe1H, Enum.ItemWeaponSubclass.Axe2H, Enum.ItemWeaponSubclass.Bows, Enum.ItemWeaponSubclass.Guns, Enum.ItemWeaponSubclass.Mace1H, Enum.ItemWeaponSubclass.Mace2H, Enum.ItemWeaponSubclass.Polearm, Enum.ItemWeaponSubclass.Sword2H, Enum.ItemWeaponSubclass.Warglaive, Enum.ItemWeaponSubclass.Unarmed, Enum.ItemWeaponSubclass.Thrown, Enum.ItemWeaponSubclass.Crossbow},
		{Enum.ItemArmorSubclass.Leather, Enum.ItemArmorSubclass.Mail, Enum.ItemArmorSubclass.Plate, Enum.ItemArmorSubclass.Shield},
		true
	}
elseif T.class == "MONK" then
	unusable = {
		{Enum.ItemWeaponSubclass.Axe2H, Enum.ItemWeaponSubclass.Bows, Enum.ItemWeaponSubclass.Guns, Enum.ItemWeaponSubclass.Mace2H, Enum.ItemWeaponSubclass.Sword2H, Enum.ItemWeaponSubclass.Warglaive, Enum.ItemWeaponSubclass.Dagger, Enum.ItemWeaponSubclass.Thrown, Enum.ItemWeaponSubclass.Crossbow, Enum.ItemWeaponSubclass.Wand},
		{Enum.ItemArmorSubclass.Mail, Enum.ItemArmorSubclass.Plate, Enum.ItemArmorSubclass.Shield}
	}
elseif T.class == "PALADIN" then
	unusable = {
		{Enum.ItemWeaponSubclass.Bows, Enum.ItemWeaponSubclass.Guns, Enum.ItemWeaponSubclass.Warglaive, Enum.ItemWeaponSubclass.Staff, Enum.ItemWeaponSubclass.Unarmed, Enum.ItemWeaponSubclass.Dagger, Enum.ItemWeaponSubclass.Thrown, Enum.ItemWeaponSubclass.Crossbow, Enum.ItemWeaponSubclass.Wand},
		{},
		true
	}
elseif T.class == "PRIEST" then
	unusable = {
		{Enum.ItemWeaponSubclass.Axe1H, Enum.ItemWeaponSubclass.Axe2H, Enum.ItemWeaponSubclass.Bows, Enum.ItemWeaponSubclass.Guns, Enum.ItemWeaponSubclass.Mace2H, Enum.ItemWeaponSubclass.Polearm, Enum.ItemWeaponSubclass.Sword1H, Enum.ItemWeaponSubclass.Sword2H, Enum.ItemWeaponSubclass.Warglaive, Enum.ItemWeaponSubclass.Unarmed, Enum.ItemWeaponSubclass.Thrown, Enum.ItemWeaponSubclass.Crossbow},
		{Enum.ItemArmorSubclass.Leather, Enum.ItemArmorSubclass.Mail, Enum.ItemArmorSubclass.Plate, Enum.ItemArmorSubclass.Shield},
		true
	}
elseif T.class == "ROGUE" then
	unusable = {
		{Enum.ItemWeaponSubclass.Axe2H, Enum.ItemWeaponSubclass.Mace2H, Enum.ItemWeaponSubclass.Polearm, Enum.ItemWeaponSubclass.Sword2H, Enum.ItemWeaponSubclass.Warglaive, Enum.ItemWeaponSubclass.Staff, Enum.ItemWeaponSubclass.Wand},
		{Enum.ItemArmorSubclass.Mail, Enum.ItemArmorSubclass.Plate, Enum.ItemArmorSubclass.Shield}
	}
elseif T.class == "SHAMAN" then
	unusable = {
		{Enum.ItemWeaponSubclass.Bows, Enum.ItemWeaponSubclass.Guns, Enum.ItemWeaponSubclass.Polearm, Enum.ItemWeaponSubclass.Sword1H, Enum.ItemWeaponSubclass.Sword2H, Enum.ItemWeaponSubclass.Warglaive, Enum.ItemWeaponSubclass.Thrown, Enum.ItemWeaponSubclass.Crossbow, Enum.ItemWeaponSubclass.Wand},
		{Enum.ItemArmorSubclass.Plate}
	}
elseif T.class == "WARLOCK" then
	unusable = {
		{Enum.ItemWeaponSubclass.Axe1H, Enum.ItemWeaponSubclass.Axe2H, Enum.ItemWeaponSubclass.Bows, Enum.ItemWeaponSubclass.Guns, Enum.ItemWeaponSubclass.Mace1H, Enum.ItemWeaponSubclass.Mace2H, Enum.ItemWeaponSubclass.Polearm, Enum.ItemWeaponSubclass.Sword2H, Enum.ItemWeaponSubclass.Warglaive, Enum.ItemWeaponSubclass.Unarmed, Enum.ItemWeaponSubclass.Thrown, Enum.ItemWeaponSubclass.Crossbow},
		{Enum.ItemArmorSubclass.Leather, Enum.ItemArmorSubclass.Mail, Enum.ItemArmorSubclass.Plate, Enum.ItemArmorSubclass.Shield},
		true
	}
elseif T.class == "WARRIOR" then
	unusable = {{Enum.ItemWeaponSubclass.Warglaive, Enum.ItemWeaponSubclass.Wand}, {}}
else
	unusable = {{}, {}}
end

local _unusable = {}

for i, class in ipairs({Enum.ItemClass.Weapon, Enum.ItemClass.Armor}) do
	local list = {}
	for _, subclass in ipairs(unusable[i]) do
		list[subclass] = true
	end

	_unusable[class] = list
end

local function IsClassUnusable(class, subclass, slot)
	if class and subclass and _unusable[class] then
		return slot ~= "" and _unusable[class][subclass] or slot == "INVTYPE_WEAPONOFFHAND" and unusable[3]
	end
end

local function IsItemUnusable(...)
	if ... then
		local slot, _,_, class, subclass = select(9, GetItemInfo(...))
		return IsClassUnusable(class, subclass, slot)
	end
end

Stuffing = CreateFrame("Frame", nil, UIParent)
Stuffing:RegisterEvent("ADDON_LOADED")
Stuffing:RegisterEvent("PLAYER_ENTERING_WORLD")
Stuffing:SetScript("OnEvent", function(this, event, ...)
	if C_AddOns.IsAddOnLoaded("AdiBags") or C_AddOns.IsAddOnLoaded("ArkInventory") or C_AddOns.IsAddOnLoaded("cargBags_Nivaya") or C_AddOns.IsAddOnLoaded("cargBags") or C_AddOns.IsAddOnLoaded("Bagnon") or C_AddOns.IsAddOnLoaded("Combuctor") or C_AddOns.IsAddOnLoaded("TBag") or C_AddOns.IsAddOnLoaded("BaudBag") or C_AddOns.IsAddOnLoaded("Baganator") then return end
	Stuffing[event](this, ...)
end)

-- Drop down menu stuff from Postal
local Stuffing_DDMenu = CreateFrame("Frame", "StuffingDropDownMenu")
Stuffing_DDMenu.displayMode = "MENU"
Stuffing_DDMenu.info = {}
Stuffing_DDMenu.HideMenu = function()
	if UIDROPDOWNMENU_OPEN_MENU == Stuffing_DDMenu then
		CloseDropDownMenus()
	end
end

local function Stuffing_OnShow()
	Stuffing:PLAYERBANKSLOTS_CHANGED(29)

	for i = 0, #BAGS_BACKPACK - 1 do
		Stuffing:BAG_UPDATE(i)
	end

	Stuffing:Layout()
	Stuffing:SearchReset()
	PlaySound(SOUNDKIT.IG_BACKPACK_OPEN)
end

local function StuffingBank_OnHide()
	if _G["StuffingFrameReagent"] and _G["StuffingFrameReagent"]:IsShown() then return end
	CloseBankFrame()
	if Stuffing.frame:IsShown() then
		Stuffing.frame:Hide()
	end
	PlaySound(SOUNDKIT.IG_BACKPACK_CLOSE)
end

local function Stuffing_OnHide()
	if _G["StuffingFrameReagent"] and _G["StuffingFrameReagent"]:IsShown() then
		CloseBankFrame()
	end
	if Stuffing.bankFrame and Stuffing.bankFrame:IsShown() then
		Stuffing.bankFrame:Hide()
	end
	PlaySound(SOUNDKIT.IG_BACKPACK_CLOSE)
end

local function Stuffing_Open()
	if not Stuffing.frame:IsShown() then
		Stuffing.frame:Show()
	end
end

local function Stuffing_Close()
	C_Timer.After(0.01, function() -- fix showing GameMenu when pressing ESC
		if Stuffing.frame:IsShown() then
			Stuffing.frame:Hide()
		end
	end)
end

local function Stuffing_Toggle()
	if Stuffing.frame:IsShown() then
		Stuffing.frame:Hide()
	else
		Stuffing.frame:Show()
	end
end

local old_ToggleBag = ToggleBag
local function Stuffing_ToggleBag(id)
	if T.Classic and id == -2 then
		old_ToggleBag(KEYRING_CONTAINER)
		return
	end
	Stuffing_Toggle()
end

-- Bag slot stuff
local trashButton = {}
local trashBag = {}

local ItemDB = {}
local function _getRealItemLevel(link, bag, slot)
	if ItemDB[link] then return ItemDB[link] end

	local realItemLevel = C_Item.GetCurrentItemLevel(ItemLocation:CreateFromBagAndSlot(bag, slot))

	ItemDB[link] = tonumber(realItemLevel)
	return realItemLevel
end

function Stuffing:SlotUpdate(b)
	local info = C_Container.GetContainerItemInfo(b.bag, b.slot)
	local count, locked, quality, clink
	if info then
		count, locked, quality, clink = info.stackCount, info.isLocked, info.quality, info.hyperlink
	end
	local texture = info and info.iconFileID or 0
	local questData = C_Container.GetContainerItemQuestInfo(b.bag, b.slot)
	local isQuestItem, questId, isActiveQuest = questData.isQuestItem, questData.questID, questData.isActive
	local itemIsUpgrade

	-- Set all slot color to default ViksUI on update
	if not b.frame.lock then
		b.frame:SetBackdropBorderColor(unpack(C.media.border_color))
	end

	if b.cooldown and StuffingFrameBags and StuffingFrameBags:IsShown() then
		local start, duration, enable = C_Container.GetContainerItemCooldown(b.bag, b.slot)
		if T.Classic and HasWandEquipped() then
			local wandID = GetInventoryItemID("player", 18)
			local wandSpeed = select(2, C_Container.GetItemCooldown(wandID)) or 0
			if wandSpeed == 0 then
				CooldownFrame_Set(b.cooldown, start, duration, enable)
			else
				if wandSpeed < 1.5 then wandSpeed = 1.5 end
				if duration and duration > wandSpeed then
					CooldownFrame_Set(b.cooldown, start, duration, enable)
				end
			end
		else
			CooldownFrame_Set(b.cooldown, start, duration, enable)
		end
	end

	if C.bag.ilvl == true and b.frame.text then
		b.frame.text:SetText("")
	end

	if T.Mainline then
		b.frame.Azerite:Hide()
		b.frame.Conduit:Hide()
		b.frame.Conduit2:Hide()
		b.frame.profQuality:Hide()

		b.frame:UpdateItemContextMatching() -- Update Scrap items
	end

	if T.Mainline and b.frame.UpgradeIcon then
		b.frame.UpgradeIcon:SetPoint("TOPLEFT", C.bag.button_size/2.7, -C.bag.button_size/2.7)
		b.frame.UpgradeIcon:SetSize(C.bag.button_size/1.7, C.bag.button_size/1.7)
		-- Use Pawn's (third-party addon) function if present; else fallback to Blizzard's.
		-- 10.0.2 Build 46658 No longer have IsContainerItemAnUpgrade
		itemIsUpgrade = PawnIsContainerItemAnUpgrade and PawnIsContainerItemAnUpgrade(b.frame:GetParent():GetID(), b.frame:GetID())
		b.frame.UpgradeIcon:SetShown(itemIsUpgrade or false)
	end

	if C_AddOns.IsAddOnLoaded("CanIMogIt") then
		CIMI_AddToFrame(b.frame, ContainerFrameItemButton_CIMIUpdateIcon)
		ContainerFrameItemButton_CIMIUpdateIcon(b.frame.CanIMogItOverlay)
	end

	if clink then
		b.name, _, _, b.itemlevel, b.level, _, _, _, _, _, _, b.itemClassID, b.itemSubClassID = GetItemInfo(clink)

		if C.bag.ilvl then
			if info.itemID == 82800 then -- pet
				local petID, petLevel, petName = strmatch(clink, "|H%w+:(%d+):(%d+):.-|h%[(.-)%]|h")
				b.name = petName
				b.itemlevel = petLevel
				b.frame.text:SetText(b.itemlevel)
			elseif info.itemID == 180653 or info.itemID == 187786 then -- keystone
				b.itemlevel, b.name = strmatch(clink, "|H%w+:%d+:%d+:(%d+):.-|h%[(.-)%]|h")
				b.itemlevel = tonumber(b.itemlevel) or 0
				b.frame.text:SetText(b.itemlevel)
			else
				if b.itemlevel and quality > 1 and (b.itemClassID == 2 or b.itemClassID == 4 or (b.itemClassID == 3 and b.itemSubClassID == 11)) then
					b.itemlevel = _getRealItemLevel(clink, b.bag, b.slot) or b.itemlevel
					b.frame.text:SetText(b.itemlevel)
				end
			end
		end

		if not b.name then	-- Keystone bug (FIXME: maybe not needed as check before)
			b.name = clink:match("%[(.-)%]") or ""
		end

		if T.Mainline then
			if C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID(clink) then
				b.frame.Azerite:SetAtlas("AzeriteIconFrame")
				b.frame.Azerite:Show()
			elseif C_Soulbinds.IsItemConduitByItemInfo(clink) then
				b.frame.Conduit:SetAtlas("ConduitIconFrame")
				b.frame.Conduit:Show()
				local color = BAG_ITEM_QUALITY_COLORS[quality]
				if color then
					b.frame.Conduit:SetVertexColor(color.r, color.g, color.b)
				end
				b.frame.Conduit2:SetAtlas("ConduitIconFrame-Corners")
				b.frame.Conduit2:Show()
			end

			local profQual = C_TradeSkillUI.GetItemReagentQualityByItemInfo(clink) or C_TradeSkillUI.GetItemCraftedQualityByItemInfo(clink)
			if profQual then
				local atlas = ("Professions-Icon-Quality-Tier%d-Inv"):format(profQual)
				b.frame.profQuality:SetAtlas(atlas, TextureKitConstants.UseAtlasSize)
				b.frame.profQuality:Show()
			end
		end

		if (IsItemUnusable(clink) or b.level and b.level > T.level) and not locked then
			_G[b.frame:GetName().."IconTexture"]:SetVertexColor(1, 0.1, 0.1)
		else
			_G[b.frame:GetName().."IconTexture"]:SetVertexColor(1, 1, 1)
		end

		-- Color slot according to item quality
		if not b.frame.lock and quality and quality > 1 and not (isQuestItem or questId) then
			local R, G, B = GetItemQualityColor(quality)
			if b.frame then
				b.frame:SetBackdropBorderColor(R, G, B)
			end
		elseif questId and not isActiveQuest then
			b.frame:SetBackdropBorderColor(1, 0.3, 0.3)
		elseif questId or isQuestItem then
			b.frame:SetBackdropBorderColor(1, 1, 0)
		end
	else
		b.name, b.level = nil, nil
	end

	SetItemButtonTexture(b.frame, texture)
	SetItemButtonCount(b.frame, count)
	SetItemButtonDesaturated(b.frame, locked)

	if C.bag.new_items then
		local IsNewItem = C_NewItems.IsNewItem(b.bag, b.slot)
		if IsNewItem then
			if not b.frame.Animation then
				b.frame.Animation = b.frame:CreateAnimationGroup()
				b.frame.Animation:SetLooping("BOUNCE")

				b.frame.Animation.FadeOut = b.frame.Animation:CreateAnimation("Alpha")
				b.frame.Animation.FadeOut:SetFromAlpha(1)
				b.frame.Animation.FadeOut:SetToAlpha(0.6)
				b.frame.Animation.FadeOut:SetDuration(0.4)
				b.frame.Animation.FadeOut:SetSmoothing("IN_OUT")
				b.frame:HookScript("OnEnter", function(self)
					local IsNewItem = C_NewItems.IsNewItem(b.bag, b.slot)

					if not IsNewItem and b.frame.Animation:IsPlaying() then
						b.frame.Animation:Stop()
					end
				end)
			end

			if not b.frame.Animation:IsPlaying() then
				b.frame.Animation:Play()
			end
		end
	end

	b.frame:Show()
end

function Stuffing:BagSlotUpdate(bag)
	if not self.buttons then
		return
	end

	for _, v in ipairs(self.buttons) do
		if v.bag == bag then
			self:SlotUpdate(v)
		end
	end
end

function Stuffing:UpdateCooldowns(b)
	if b.cooldown and StuffingFrameBags and StuffingFrameBags:IsShown() then
		local start, duration, enable = C_Container.GetContainerItemCooldown(b.bag, b.slot)
		if T.Classic and HasWandEquipped() then
			local wandID = GetInventoryItemID("player", 18)
			local wandSpeed = select(2, C_Container.GetItemCooldown(wandID)) or 0
			if wandSpeed == 0 then
				CooldownFrame_Set(b.cooldown, start, duration, enable)
			else
				if wandSpeed < 1.5 then wandSpeed = 1.5 end
				if duration and duration > wandSpeed then
					CooldownFrame_Set(b.cooldown, start, duration, enable)
				end
			end
		else
			CooldownFrame_Set(b.cooldown, start, duration, enable)
		end
	end
end

function Stuffing:CreateReagentContainer()
	ReagentBankFrame:StripTextures()

	local Reagent = CreateFrame("Frame", "StuffingFrameReagent", UIParent)
	local SwitchBankButton = CreateFrame("Button", nil, Reagent)
	local NumRows, LastRowButton, NumButtons, LastButton = 0, ReagentBankFrameItem1, 1, ReagentBankFrameItem1
	local Deposit = ReagentBankFrame.DespositButton

	Reagent:SetWidth(((C.bag.button_size + C.bag.button_space) * C.bag.bank_columns) + 17)
	Reagent:SetPoint("TOPLEFT", _G["StuffingFrameBank"], "TOPLEFT", 0, 0)
	Reagent:SetTemplate("Transparent")
	Reagent:SetFrameStrata(_G["StuffingFrameBank"]:GetFrameStrata())
	Reagent:SetFrameLevel(_G["StuffingFrameBank"]:GetFrameLevel() + 5)
	Reagent:EnableMouse(true)
	Reagent:SetMovable(true)
	Reagent:SetClampedToScreen(true)
	Reagent:SetClampRectInsets(0, 0, 0, -20)
	Reagent:SetScript("OnMouseDown", function(self, button)
		if IsShiftKeyDown() and button == "LeftButton" then
			self:StartMoving()
		end
	end)
	Reagent:SetScript("OnMouseUp", Reagent.StopMovingOrSizing)

	SwitchBankButton:SetSize(80, 20)
	SwitchBankButton:SkinButton()
	SwitchBankButton:SetPoint("TOPLEFT", 10, -4)
	SwitchBankButton:FontString("text", C.font.bags_font, C.font.bags_font_size, C.font.bags_font_style)
	SwitchBankButton.text:SetPoint("CENTER")
	SwitchBankButton.text:SetText(BANK)
	SwitchBankButton:SetScript("OnClick", function()
		Reagent:Hide()
		_G["StuffingFrameBank"]:Show()
		BankFrame_ShowPanel(BANK_PANELS[1].name)
		PlaySound(SOUNDKIT.IG_BACKPACK_OPEN)
	end)

	Deposit:SetParent(Reagent)
	Deposit:ClearAllPoints()
	Deposit:SetSize(170, 20)
	Deposit:SetPoint("TOPLEFT", SwitchBankButton, "TOPRIGHT", 3, 0)
	Deposit:SkinButton()
	Deposit:FontString("text", C.font.bags_font, C.font.bags_font_size, C.font.bags_font_style)
	Deposit.text:SetShadowOffset(C.font.bags_font_shadow and 1 or 0, C.font.bags_font_shadow and -1 or 0)
	Deposit.text:SetTextColor(1, 1, 1)
	Deposit.text:SetText(REAGENTBANK_DEPOSIT)
	Deposit:SetFontString(Deposit.text)

	-- Close button
	local Close = CreateFrame("Button", "StuffingCloseButtonReagent", Reagent, "UIPanelCloseButton")
	T.SkinCloseButton(Close, nil, nil, true)
	Close:SetSize(15, 15)
	Close:RegisterForClicks("AnyUp")
	Close:SetScript("OnClick", function(self, btn)
		if btn == "RightButton" then
			if Stuffing_DDMenu.initialize ~= Stuffing.Menu then
				CloseDropDownMenus()
				Stuffing_DDMenu.initialize = Stuffing.Menu
			end
			ToggleDropDownMenu(nil, nil, Stuffing_DDMenu, self:GetName(), 0, 0)
			return
		else
			Reagent:Hide()
			StuffingBank_OnHide()
		end
	end)

	local tooltip_hide = function()
		GameTooltip:Hide()
	end

	local tooltip_show = function(self)
		GameTooltip:SetOwner(self, "ANCHOR_LEFT", 19, 7)
		GameTooltip:ClearLines()
		GameTooltip:SetText(L_BAG_RIGHT_CLICK_CLOSE)
	end

	Close:HookScript("OnEnter", tooltip_show)
	Close:HookScript("OnLeave", tooltip_hide)

	for i = 1, 98 do
		local button = _G["ReagentBankFrameItem"..i]
		local icon = _G[button:GetName().."IconTexture"]
		local count = _G[button:GetName().."Count"]

		ReagentBankFrame:SetParent(Reagent)
		ReagentBankFrame:ClearAllPoints()
		ReagentBankFrame:SetAllPoints()

		button:StyleButton()
		button:SetTemplate("Default")
		button:SetNormalTexture(0)
		button.IconBorder:SetAlpha(0)

		button:ClearAllPoints()
		button:SetSize(C.bag.button_size, C.bag.button_size)

		local _, _, _, quality = GetContainerItemInfo(-3, i)
		local clink = C_Container.GetContainerItemLink(-3, i)
		if clink then
			if quality and quality > 1 then
				local r, g, b = GetItemQualityColor(quality)
				button:SetBackdropBorderColor(r, g, b)
			end
		end

		if i == 1 then
			button:SetPoint("TOPLEFT", Reagent, "TOPLEFT", 10, -27)
			LastRowButton = button
			LastButton = button
		elseif NumButtons == C.bag.bank_columns then
			button:SetPoint("TOPRIGHT", LastRowButton, "TOPRIGHT", 0, -(C.bag.button_space + C.bag.button_size))
			button:SetPoint("BOTTOMLEFT", LastRowButton, "BOTTOMLEFT", 0, -(C.bag.button_space + C.bag.button_size))
			LastRowButton = button
			NumRows = NumRows + 1
			NumButtons = 1
		else
			button:SetPoint("TOPRIGHT", LastButton, "TOPRIGHT", (C.bag.button_space + C.bag.button_size), 0)
			button:SetPoint("BOTTOMLEFT", LastButton, "BOTTOMLEFT", (C.bag.button_space + C.bag.button_size), 0)
			NumButtons = NumButtons + 1
		end

		icon:CropIcon()

		count:SetFont(C.font.bags_font, C.font.bags_font_size, C.font.bags_font_style)
		count:SetShadowOffset(C.font.bags_font_shadow and 1 or 0, C.font.bags_font_shadow and -1 or 0)
		count:SetPoint("BOTTOMRIGHT", 1, 1)

		LastButton = button
	end
	Reagent:SetHeight(((C.bag.button_size + C.bag.button_space) * (NumRows + 1) + 40) - C.bag.button_space)

	MoneyFrame_Update(ReagentBankFrame.UnlockInfo.CostMoneyFrame, GetReagentBankCost())
	ReagentBankFrameUnlockInfo:StripTextures()
	ReagentBankFrameUnlockInfo:SetAllPoints(Reagent)
	ReagentBankFrameUnlockInfo:SetTemplate("Overlay")
	ReagentBankFrameUnlockInfo:SetFrameStrata("FULLSCREEN")
	ReagentBankFrameUnlockInfoPurchaseButton:SkinButton()
end

function Stuffing:BagFrameSlotNew(p, slot)
	for _, v in ipairs(self.bagframe_buttons) do
		if v.slot == slot then
			return v, false
		end
	end

	local ret = {}

	if slot > (T.Classic and 3 or 5) then
		ret.slot = slot
		slot = slot - (T.Classic and 4 or 5)
		ret.frame = CreateFrame(T.Classic and "CheckButton" or "ItemButton", "StuffingBBag"..slot.."Slot", p, "BankItemButtonBagTemplate")
		Mixin(ret.frame, BackdropTemplateMixin)
		ret.frame:StripTextures()
		ret.frame:SetID(slot)
		hooksecurefunc(ret.frame.IconBorder, "SetVertexColor", function(self, r, g, b)
			if r ~= 0.65882 and g ~= 0.65882 and b ~= 0.65882 then
				self:GetParent():SetBackdropBorderColor(r, g, b)
			end
			self:SetTexture(0)
		end)

		hooksecurefunc(ret.frame.IconBorder, "Hide", function(self)
			self:GetParent():SetBackdropBorderColor(unpack(C.media.border_color))
		end)

		table.insert(self.bagframe_buttons, ret)

		BankFrameItemButton_Update(ret.frame)

		if not ret.frame.tooltipText then
			ret.frame.tooltipText = ""
		end

		ret.frame.ID = ret.frame:GetInventorySlot()
		local quality = GetInventoryItemQuality("player", ret.frame.ID)
		if quality then
			ret.frame.quality = quality
		end

		if slot > GetNumBankSlots() then
			SetItemButtonTextureVertexColor(ret.frame, 1.0, 0.1, 0.1)
		else
			SetItemButtonTextureVertexColor(ret.frame, 1.0, 1.0, 1.0)
		end
	else
		if T.Classic then
			ret.frame = CreateFrame(T.Classic and "CheckButton" or "ItemButton", "StuffingFBag"..slot.."Slot", p, "BagSlotButtonTemplate")
		else
			ret.frame = CreateFrame(T.Classic and "CheckButton" or "ItemButton", "StuffingFBag"..(slot + 1).."Slot", p, "")
		end
		Mixin(ret.frame, BackdropTemplateMixin)

		ret.frame.ID = C_Container.ContainerIDToInventoryID(slot + 1)
		local bag_tex = GetInventoryItemTexture("player", ret.frame.ID)
		_G[ret.frame:GetName().."IconTexture"]:SetTexture(bag_tex)
		ret.frame:SetID(ret.frame.ID)

		ret.frame:RegisterForDrag("LeftButton")
		ret.frame:SetScript("OnDragStart", function(self)
			PickupBagFromSlot(self:GetID())
		end)
		ret.frame:SetScript("OnReceiveDrag", function(self)
			PutItemInBag(self:GetID())
		end)

		local tooltip_hide = function()
			GameTooltip:Hide()
		end

		local tooltip_show = function(self)
			GameTooltip:SetOwner(self, "ANCHOR_LEFT", 19, 7)
			GameTooltip:ClearLines()
			if GetInventoryItemLink("player", ret.frame.ID) then
				GameTooltip:SetInventoryItem("player", self:GetID())
			else
				local text = ret.slot == 4 and EQUIP_CONTAINER_REAGENT or EQUIP_CONTAINER
				GameTooltip:AddLine(text)
				GameTooltip:Show()
			end
		end

		ret.frame:HookScript("OnEnter", tooltip_show)
		ret.frame:HookScript("OnLeave", tooltip_hide)

		ret.frame:SetTemplate("Default")

		local quality = GetInventoryItemQuality("player", ret.frame.ID)
		if quality then
			ret.frame.quality = quality
			-- else
			-- C_Timer.After(1, function() -- TODO: Test it if quality not returned after first open
			-- ret.frame.quality = GetInventoryItemQuality("player", ret.frame.ID)
			-- end)
		end

		ret.slot = slot
		table.insert(self.bagframe_buttons, ret)
	end

	ret.frame:StyleButton()
	ret.frame:SetTemplate("Default")
	ret.frame:SetNormalTexture(0)

	ret.icon = _G[ret.frame:GetName().."IconTexture"]
	ret.icon:CropIcon()

	-- C_Timer.After(2, function()
	if ret.frame.quality and ret.frame.quality > 1 then
		local r, g, b = GetItemQualityColor(ret.frame.quality)
		ret.frame:SetBackdropBorderColor(r, g, b)
	end
	-- end)

	return ret
end

function Stuffing:SlotNew(bag, slot)
	for _, v in ipairs(self.buttons) do
		if v.bag == bag and v.slot == slot then
			v.lock = false
			return v, false
		end
	end

	local tpl = "ContainerFrameItemButtonTemplate"

	if bag == -1 then
		tpl = "BankItemButtonGenericTemplate"
	end

	local ret = {}

	if #trashButton > 0 then
		local f = -1
		for i, v in ipairs(trashButton) do
			local b, s = v:GetName():match("(%d+)_(%d+)")

			b = tonumber(b)
			s = tonumber(s)

			if b == bag and s == slot then
				f = i
				break
			else
				v:Hide()
			end
		end

		if f ~= -1 then
			ret.frame = trashButton[f]
			table.remove(trashButton, f)
			ret.frame:Show()
		end
	end

	if not ret.frame then
		ret.frame = CreateFrame(T.Classic and "Button" or "ItemButton", "StuffingBag"..bag.."_"..slot, self.bags[bag], tpl)
		ret.frame:StyleButton()
		ret.frame:SetTemplate("Default")
		ret.frame:SetNormalTexture(0)
		ret.frame:SetFrameStrata("HIGH")

		ret.icon = _G[ret.frame:GetName().."IconTexture"]
		ret.icon:CropIcon()

		ret.count = _G[ret.frame:GetName().."Count"]
		ret.count:SetFont(C.font.bags_font, C.font.bags_font_size, C.font.bags_font_style)
		ret.count:SetShadowOffset(C.font.bags_font_shadow and 1 or 0, C.font.bags_font_shadow and -1 or 0)
		ret.count:SetPoint("BOTTOMRIGHT", 1, 1)

		if C.bag.ilvl == true then
			ret.frame.text = ret.frame:CreateFontString(nil, "ARTWORK")
			ret.frame.text:SetFont(C.font.bags_font, C.font.bags_font_size, C.font.bags_font_style)
			ret.frame.text:SetPoint("TOPLEFT", 1, -1)
			ret.frame.text:SetTextColor(1, 1, 0)
		end

		ret.frame.Azerite = ret.frame:CreateTexture(nil, "ARTWORK")
		ret.frame.Azerite:SetAtlas("AzeriteIconFrame")
		ret.frame.Azerite:SetPoint("TOPLEFT", ret.frame, 1, -1)
		ret.frame.Azerite:SetPoint("BOTTOMRIGHT", ret.frame, -1, 1)
		ret.frame.Azerite:Hide()

		ret.frame.Conduit = ret.frame:CreateTexture(nil, "ARTWORK")
		ret.frame.Conduit:SetAtlas("ConduitIconFrame")
		ret.frame.Conduit:SetPoint("TOPLEFT", ret.frame, 2, -2)
		ret.frame.Conduit:SetPoint("BOTTOMRIGHT", ret.frame, -2, 2)
		ret.frame.Conduit:Hide()

		ret.frame.Conduit2 = ret.frame:CreateTexture(nil, "ARTWORK")
		ret.frame.Conduit2:SetAtlas("ConduitIconFrame-Corners")
		ret.frame.Conduit2:SetPoint("TOPLEFT", ret.frame, 2, -2)
		ret.frame.Conduit2:SetPoint("BOTTOMRIGHT", ret.frame, -2, 2)
		ret.frame.Conduit2:Hide()

		ret.frame.profQuality = ret.frame:CreateTexture(nil, "ARTWORK")
		ret.frame.profQuality:SetPoint("TOPLEFT", ret.frame, 0, 0)
		ret.frame.profQuality:Hide()

		local Battlepay = _G[ret.frame:GetName()].BattlepayItemTexture
		if Battlepay then
			Battlepay:SetAlpha(0)
		end
	end

	ret.bag = bag
	ret.slot = slot
	ret.frame:SetID(slot)

	ret.cooldown = _G[ret.frame:GetName().."Cooldown"]
	ret.cooldown:Show()

	self:SlotUpdate(ret)

	return ret, true
end

-- From OneBag
local BAGTYPE_PROFESSION = 0x0008 + 0x0010 + 0x0020 + 0x0040 + 0x0080 + 0x0200 + 0x0400 + 0x10000
local BAGTYPE_QUIVER = 0x0001 + 0x0002
local BAGTYPE_SOUL = 0x004
local BAGTYPE_FISHING = 32768

function Stuffing:BagType(bag)
	local bagType = select(2, C_Container.GetContainerNumFreeSlots(bag))

	if bit.band(bagType, BAGTYPE_QUIVER) > 0 then
		return ST_QUIVER
	elseif bit.band(bagType, BAGTYPE_SOUL) > 0 then
		return ST_SOULBAG
	elseif bagType and bit.band(bagType, BAGTYPE_FISHING) > 0 then
		return ST_FISHBAG
	elseif bagType and bit.band(bagType, BAGTYPE_PROFESSION) > 0 then
		return ST_SPECIAL
	end

	return ST_NORMAL
end

function Stuffing:BagNew(bag, f)
	for _, v in pairs(self.bags) do
		if v:GetID() == bag then
			v.bagType = self:BagType(bag)
			return v
		end
	end

	local ret

	if #trashBag > 0 then
		local f = -1
		for i, v in pairs(trashBag) do
			if v:GetID() == bag then
				f = i
				break
			end
		end

		if f ~= -1 then
			ret = trashBag[f]
			table.remove(trashBag, f)
			ret:Show()
			ret.bagType = self:BagType(bag)
			return ret
		end
	end

	ret = CreateFrame("Frame", "StuffingBag"..bag, f)
	ret.bagType = self:BagType(bag)

	ret:SetID(bag)
	return ret
end

local bind = {
	[0] = "",
	[1] = "bop bound"..ITEM_BIND_ON_PICKUP,
	[2] = "boe"..ITEM_BIND_ON_EQUIP,
	[3] = ITEM_BIND_ON_USE,
	[4] = ITEM_BIND_QUEST
}

local bindAccount = {
	[ITEM_ACCOUNTBOUND] = true,
	[ITEM_BIND_TO_ACCOUNT] = true,
	[ITEM_BNETACCOUNTBOUND] = true,
}

function Stuffing:SearchUpdate(str)
	str = string.lower(str)

	for _, b in ipairs(self.buttons) do
		if b.frame and not b.name then
			if str == "" then
				b.frame.searchOverlay:Hide()
			else
				b.frame.searchOverlay:Show()
			end
		end
		if b.name then
			local ilink = C_Container.GetContainerItemLink(b.bag, b.slot)
			if ilink then
				local _, setName = T.Mainline and C_Container.GetContainerItemEquipmentSetInfo(b.bag, b.slot)
				setName = setName or ""
				local _, _, _, _, minLevel, class, subclass, _, equipSlot, _, _, _, _, bindType = GetItemInfo(ilink)
				class = class or ""
				subclass = subclass or ""
				equipSlot = equipSlot or ""
				bindType = bind[bindType] or ""
				minLevel = minLevel or 1
				local isBoA = false
				if str and str == "boa" and T.Mainline then
					local data = C_TooltipInfo.GetBagItem(b.bag, b.slot)
					if data then
						for j = 2, 5 do
							local lineData = data.lines[j]
							if not lineData then break end
							local title = lineData.leftText
							if title and bindAccount[title] then
								isBoA = true
								break
							end
						end
					end
				end

				if not isBoA and not string.find(string.lower(b.name), str) and not string.find(string.lower(setName), str) and not string.find(string.lower(class), str) and not string.find(string.lower(subclass), str) and not string.find(string.lower(equipSlot), str) and not string.find(string.lower(bindType), str) then
					if IsItemUnusable(b.name) or minLevel > T.level then
						_G[b.frame:GetName().."IconTexture"]:SetVertexColor(0.5, 0.5, 0.5)
					end
					SetItemButtonDesaturated(b.frame, true)
					b.frame.searchOverlay:Show()
				else
					if IsItemUnusable(b.name) or minLevel > T.level then
						_G[b.frame:GetName().."IconTexture"]:SetVertexColor(1, 0.1, 0.1)
					end
					SetItemButtonDesaturated(b.frame, false)
					b.frame.searchOverlay:Hide()
				end
			end
		end
	end

	if ReagentBankFrameItem1 then
		for slotID = 1, 98 do
			local _, _, _, _, _, _, ilink = GetContainerItemInfo(-3, slotID)
			local button = _G["ReagentBankFrameItem"..slotID]
			if ilink then
				local name, _, _, _, minLevel, class, subclass = GetItemInfo(ilink)
				class = class or ""
				subclass = subclass or ""
				minLevel = minLevel or 1
				if not string.find(string.lower(name), str) and not string.find(string.lower(class), str) and not string.find(string.lower(subclass), str) then
					if IsItemUnusable(name) or minLevel > T.level then
						_G[button:GetName().."IconTexture"]:SetVertexColor(0.5, 0.5, 0.5)
					end
					SetItemButtonDesaturated(button, true)
					button.searchOverlay:Show()
				else
					if IsItemUnusable(name) or minLevel > T.level then
						_G[button:GetName().."IconTexture"]:SetVertexColor(1, 0.1, 0.1)
					end
					SetItemButtonDesaturated(button, false)
					button.searchOverlay:Hide()
				end
			end
		end
	end
end

function Stuffing:SearchReset()
	for _, b in ipairs(self.buttons) do
		if IsItemUnusable(b.name) or (b.level and b.level > T.level) then
			_G[b.frame:GetName().."IconTexture"]:SetVertexColor(1, 0.1, 0.1)
		end
		b.frame.searchOverlay:Hide()
		SetItemButtonDesaturated(b.frame, false)
	end

	self.frame.editbox:SetText("")
	self.frame.editbox:Hide()
	self.frame.editbox:ClearFocus()
	self.frame.detail:Show()
end

local function DragFunction(self, mode)
	for index = 1, select("#", self:GetChildren()) do
		local frame = select(index, self:GetChildren())
		if frame:GetName() and frame:GetName():match("StuffingBag") then
			if mode then
				frame:Hide()
			else
				frame:Show()
			end
		end
	end
end

function Stuffing:CreateBagFrame(w)
	local n = "StuffingFrame"..w
	local f = CreateFrame("Frame", n, UIParent)
	f:EnableMouse(true)
	f:SetMovable(true)
	f:SetFrameStrata("HIGH")
	f:SetFrameLevel(10)
	f:RegisterForDrag("LeftButton")
	f:SetScript("OnDragStart", function(self)
		if IsAltKeyDown() or IsShiftKeyDown() then
			self:StartMoving()
			DragFunction(self, true)
			f.moved = true
		end
	end)

	f:SetScript("OnDragStop", function(self)
		if f.moved then	-- prevent false register without modifier key
			self:StopMovingOrSizing()
			DragFunction(self, false)
			local ap, p, rp, x, y = f:GetPoint()
			if not p then p = UIParent end
			local positionTable = T.CurrentProfile()
			positionTable[f:GetName()] = {ap, p:GetName(), rp, x, y}
			f.moved = nil
		end
	end)

	f:SetScript("OnMouseDown", function(_, button)
		if IsControlKeyDown() and button == "RightButton" then
			f:ClearAllPoints()
			if w == "Bank" then
				f:SetPoint(unpack(C.position.bank))
			else
				f:SetPoint(unpack(C.position.bag))
			end
			f:SetUserPlaced(false)
			local positionTable = T.CurrentProfile()
			positionTable[f:GetName()] = nil
		end
	end)

	local positionTable = T.CurrentProfile()
	if positionTable and positionTable[f:GetName()] then
		f:SetPoint(unpack(positionTable[f:GetName()]))
	else
		if w == "Bank" then
			f:SetPoint(unpack(C.position.bank))
		else
			f:SetPoint(unpack(C.position.bag))
		end
	end

	if w == "Bank" then
		-- Set frame level to be higher than other bags
		f:SetFrameLevel(f:GetFrameLevel() + 3)

		-- Reagent button
		if T.Mainline then
			f.b_reagent = CreateFrame("Button", "StuffingReagentButton"..w, f)
			f.b_reagent:SetSize(105, 20)
			f.b_reagent:SetPoint("TOPLEFT", 10, -4)
			f.b_reagent:RegisterForClicks("AnyUp")
			f.b_reagent:SkinButton()
			f.b_reagent:SetScript("OnClick", function()
				BankFrame_ShowPanel(BANK_PANELS[2].name)
				PlaySound(SOUNDKIT.IG_BACKPACK_OPEN)
				if not ReagentBankFrame.isMade then
					self:CreateReagentContainer()
					ReagentBankFrame.isMade = true
				else
					_G["StuffingFrameReagent"]:Show()
				end
				_G["StuffingFrameBank"]:Hide()
			end)
			f.b_reagent:FontString("text", C.font.bags_font, C.font.bags_font_size, C.font.bags_font_style)
			f.b_reagent.text:SetPoint("CENTER")
			f.b_reagent.text:SetText(REAGENT_BANK)
			f.b_reagent:SetFontString(f.b_reagent.text)
		end

		-- Buy button
		f.b_purchase = CreateFrame("Button", "StuffingPurchaseButton"..w, f)
		f.b_purchase:SetSize(80, 20)
		if T.Classic then
			f.b_purchase:SetPoint("TOPLEFT", 10, -4)
		else
			f.b_purchase:SetPoint("TOPLEFT", f.b_reagent, "TOPRIGHT", 3, 0)
		end
		f.b_purchase:RegisterForClicks("AnyUp")
		f.b_purchase:SkinButton()
		f.b_purchase:SetScript("OnClick", function() StaticPopup_Show("BUY_BANK_SLOT") end)
		f.b_purchase:FontString("text", C.font.bags_font, C.font.bags_font_size, C.font.bags_font_style)
		f.b_purchase.text:SetPoint("CENTER")
		f.b_purchase.text:SetText(BANKSLOTPURCHASE)
		f.b_purchase:SetFontString(f.b_purchase.text)
		local _, full = GetNumBankSlots()
		if full then
			f.b_purchase:Hide()
		else
			f.b_purchase:Show()
		end
	end

	-- Close button
	f.b_close = CreateFrame("Button", "StuffingCloseButton"..w, f, "UIPanelCloseButton")
	T.SkinCloseButton(f.b_close, nil, nil, true)
	f.b_close:SetSize(15, 15)
	f.b_close:RegisterForClicks("AnyUp")
	f.b_close:SetScript("OnClick", function(self, btn)
		if btn == "RightButton" then
			if Stuffing_DDMenu.initialize ~= Stuffing.Menu then
				CloseDropDownMenus()
				Stuffing_DDMenu.initialize = Stuffing.Menu
			end
			ToggleDropDownMenu(nil, nil, Stuffing_DDMenu, self:GetName(), 0, 0)
			return
		elseif btn == "LeftButton" and IsShiftKeyDown() then
			if InCombatLockdown() then
				print("|cffffff00"..ERR_NOT_IN_COMBAT.."|r") return
			end
			Stuffing:SetBagsForSorting("d")
			Stuffing:Restack()
			return
		end
		self:GetParent():Hide()
	end)

	local tooltip_hide = function()
		GameTooltip:Hide()
	end

	local tooltip_show = function(self)
		GameTooltip:SetOwner(self, "ANCHOR_LEFT", 19, 7)
		GameTooltip:ClearLines()
		GameTooltip:SetText(L_BAG_RIGHT_CLICK_CLOSE)
	end

	f.b_close:HookScript("OnEnter", tooltip_show)
	f.b_close:HookScript("OnLeave", tooltip_hide)

	-- Create the bags frame
	local fb = CreateFrame("Frame", n.."BagsFrame", f)
	fb:SetPoint("BOTTOMLEFT", f, "TOPLEFT", 0, 3)
	fb:SetFrameStrata("MEDIUM")
	f.bags_frame = fb

	return f
end

function Stuffing:InitBank()
	if self.bankFrame then
		return
	end

	local f = self:CreateBagFrame("Bank")
	f:SetScript("OnHide", StuffingBank_OnHide)
	self.bankFrame = f
end

function Stuffing:InitBags()
	if self.frame then return end

	self.buttons = {}
	self.bags = {}
	self.bagframe_buttons = {}
	self.bags_num = {}

	local f = self:CreateBagFrame("Bags")
	f:SetScript("OnShow", Stuffing_OnShow)
	f:SetScript("OnHide", Stuffing_OnHide)

	-- Search editbox (tekKonfigAboutPanel.lua)
	local editbox = CreateFrame("EditBox", nil, f)
	editbox:Hide()
	editbox:SetAutoFocus(false)
	editbox:SetHeight(32)
	editbox:CreateBackdrop("Overlay")
	editbox.backdrop:SetPoint("TOPLEFT", -2, 1)
	editbox.backdrop:SetPoint("BOTTOMRIGHT", 2, -1)

	local fullReset = function(self)
		Stuffing:SearchReset()
	end

	local clearFocus = function(self)
		self:HighlightText(0, 0)
		self:ClearFocus()
	end

	local gainFocus = function(self)
		self:HighlightText()
	end

	local updateSearch = function(self, t)
		if t == true then
			Stuffing:SearchUpdate(self:GetText())
		end
	end

	editbox:SetScript("OnEscapePressed", fullReset)
	editbox:SetScript("OnEnterPressed", clearFocus)
	editbox:SetScript("OnEditFocusLost", clearFocus)
	editbox:SetScript("OnEditFocusGained", gainFocus)
	editbox:SetScript("OnTextChanged", updateSearch)
	-- editbox:SetText(SEARCH)

	local detail = f:CreateFontString(nil, "ARTWORK", "GameFontHighlightLarge")
	detail:SetPoint("TOPLEFT", f, 12, -8)
	detail:SetPoint("RIGHT", f, -150, -8)
	detail:SetHeight(13)
	detail:SetShadowColor(0, 0, 0, 0)
	detail:SetJustifyH("LEFT")
	detail:SetText("|cff9999ff"..SEARCH.."|r")
	editbox:SetAllPoints(detail)

	local buttons = {}
	local filterTable
	if T.Classic then
		filterTable = {
			[1] = {134811, GetItemClassInfo(0)},	-- Consumable
			[2] = {135280, GetItemClassInfo(2)},	-- Weapon
			[3] = {132341, GetItemClassInfo(4)},	-- Armor
			[4] = {132281, GetItemClassInfo(7)},	-- Tradeskill
			[5] = {134269, ITEM_BIND_QUEST},		-- Quest
			[6] = {133784, ITEM_BIND_ON_EQUIP},		-- BoE
		}
	else
		filterTable = {
			[1] = {3566860, GetItemClassInfo(0)},	-- Consumable
			[2] = {135280, GetItemClassInfo(2)},	-- Weapon
			[3] = {132341, GetItemClassInfo(4)},	-- Armor
			[4] = {132281, GetItemClassInfo(7)},	-- Tradeskill
			[5] = {236667, ITEM_BIND_QUEST},		-- Quest
			[6] = {133784, ITEM_BIND_ON_EQUIP},		-- BoE
		}
	end
	for i = 1, #filterTable do
		local button = CreateFrame("Button", "BagsFilterButton"..i, C.bag.filter and f or editbox)
		button:SetSize(25, 25)
		button:SetTemplate("Overlay")
		button:EnableMouse(true)
		button:RegisterForClicks("AnyUp")
		if i == 1 then
			button:SetPoint("TOPRIGHT", f, "TOPLEFT", -1, 0)
		else
			button:SetPoint("TOP", buttons[i-1], "BOTTOM", 0, -1)
		end
		buttons[i] = button
		local icon, text = unpack(filterTable[i])
		button.Icon = button:CreateTexture(nil, "OVERLAY")
		button.Icon:SetTexture(icon)
		button.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		button.Icon:SetPoint("TOPLEFT", button, 2, -2)
		button.Icon:SetPoint("BOTTOMRIGHT", button, -2, 2)
		button:SetScript("OnClick", function(self)
			if editbox:GetText() == text then
				Stuffing:SearchReset()
			else
				detail:Hide()
				editbox:Show()
				editbox:SetText(text)
				Stuffing:SearchUpdate(text)
			end
		end)

		local tooltip_hide = function()
			GameTooltip:Hide()
		end

		local tooltip_show = function(self)
			GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT", -5, 5)
			GameTooltip:ClearLines()
			GameTooltip:SetText(text)
		end

		button:SetScript("OnEnter", tooltip_show)
		button:SetScript("OnLeave", tooltip_hide)
	end

	local button = CreateFrame("Button", nil, f)
	button:EnableMouse(true)
	button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	button:SetAllPoints(detail)
	button.ttText = L_BAG_RIGHT_CLICK_SEARCH
	button:SetScript("OnClick", function(self, btn)
		if btn == "RightButton" then
			self:GetParent().detail:Hide()
			self:GetParent().editbox:Show()
			self:GetParent().editbox:HighlightText()
			self:GetParent().editbox:SetFocus()
		else
			if self:GetParent().editbox:IsShown() then
				Stuffing:SearchReset()
			end
		end
	end)

	local tooltip_hide = function()
		GameTooltip:Hide()
	end

	local tooltip_show = function(self)
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", -12, 11)
		GameTooltip:ClearLines()
		GameTooltip:SetText(self.ttText)
	end

	button:SetScript("OnEnter", tooltip_show)
	button:SetScript("OnLeave", tooltip_hide)

	f.editbox = editbox
	f.detail = detail
	f.button = button
	self.frame = f
	f:Hide()
end

function Stuffing:Layout(isBank)
	local slots = 0
	local rows = 0
	local off = 20
	local cols, f, bs

	if isBank then
		bs = BAGS_BANK
		cols = C.bag.bank_columns
		f = self.bankFrame
		f:SetAlpha(1)
	else
		bs = BAGS_BACKPACK
		cols = C.bag.bag_columns
		f = self.frame

		f.editbox:SetFont(C.media.normal_font, C.font.bags_font_size + 3, "")
		f.detail:SetFont(C.font.bags_font, C.font.bags_font_size, C.font.bags_font_style)
		f.detail:SetShadowOffset(C.font.bags_font_shadow and 1 or 0, C.font.bags_font_shadow and -1 or 0)
	end

	f:SetClampedToScreen(1)
	f:SetTemplate("Transparent")

	-- Bag frame stuff
	local fb = f.bags_frame
	if bag_bars == 1 then
		fb:SetClampedToScreen(1)
		fb:SetTemplate("Transparent")

		local bsize = C.bag.button_size

		local w = 2 * 10
		w = w + ((#bs - 1) * bsize)
		w = w + ((#bs - 2) * 4)

		fb:SetHeight(2 * 10 + bsize)
		fb:SetWidth(w)
		fb:Show()
	else
		fb:Hide()
	end

	local idx = 0
	for _, v in ipairs(bs) do
		if (not isBank and v <= (T.Classic and 3 or 4)) or (isBank and v ~= -1) then
			local bsize = C.bag.button_size
			local b = self:BagFrameSlotNew(fb, v)
			local xoff = 10

			xoff = xoff + (idx * bsize)
			xoff = xoff + (idx * 4)

			b.frame:ClearAllPoints()
			b.frame:SetPoint("LEFT", fb, "LEFT", xoff, 0)
			b.frame:SetSize(bsize, bsize)

			local btns = self.buttons
			b.frame:HookScript("OnEnter", function()
				local bag
				if isBank then bag = v else bag = v + 1 end

				for _, val in ipairs(btns) do
					if val.bag == bag then
						val.frame.searchOverlay:Hide()
					else
						val.frame.searchOverlay:Show()
					end
				end
			end)

			b.frame:HookScript("OnLeave", function()
				for _, btn in ipairs(btns) do
					btn.frame.searchOverlay:Hide()
				end
			end)

			b.frame:SetScript("OnClick", nil)

			idx = idx + 1
		end
	end

	for _, i in ipairs(bs) do
		local x = C_Container.GetContainerNumSlots(i)
		if x > 0 then
			if not self.bags[i] then
				self.bags[i] = self:BagNew(i, f)
			end

			slots = slots + C_Container.GetContainerNumSlots(i)
		end
		self.bags_num[i] = x
	end

	rows = floor(slots / cols)
	if (slots % cols) ~= 0 then
		rows = rows + 1
	end

	f:SetWidth(cols * C.bag.button_size + (cols - 1) * C.bag.button_space + 10 * 2)
	f:SetHeight(rows * C.bag.button_size + (rows - 1) * C.bag.button_space + off + 10 * 2)

	local idx = 0
	for _, i in ipairs(bs) do
		local bag_cnt = C_Container.GetContainerNumSlots(i)
		local specialType = select(2, C_Container.GetContainerNumFreeSlots(i))
		if bag_cnt > 0 then
			self.bags[i] = self:BagNew(i, f)
			local bagType = self.bags[i].bagType

			self.bags[i]:Show()
			for j = 1, bag_cnt do
				local b, isnew = self:SlotNew(i, j)
				local xoff
				local yoff
				local x = (idx % cols)
				local y = floor(idx / cols)

				if isnew then
					table.insert(self.buttons, idx + 1, b)
				end

				xoff = 10 + (x * C.bag.button_size) + (x * C.bag.button_space)
				yoff = off + 10 + (y * C.bag.button_size) + ((y - 1) * C.bag.button_space)
				yoff = yoff * -1

				b.frame:ClearAllPoints()
				b.frame:SetPoint("TOPLEFT", f, "TOPLEFT", xoff, yoff)
				b.frame:SetSize(C.bag.button_size, C.bag.button_size)
				b.frame.lock = false
				b.frame:SetAlpha(1)

				if bagType == ST_QUIVER then
					b.frame:SetBackdropBorderColor(0.8, 0.8, 0.2)	-- Quiver
					b.frame.lock = true
				elseif bagType == ST_SOULBAG then
					b.frame:SetBackdropBorderColor(0.8, 0.2, 0.2)	-- Soul Bag
					b.frame.lock = true
				elseif bagType == ST_FISHBAG then
					b.frame:SetBackdropBorderColor(1, 0, 0)	-- Tackle
					b.frame.lock = true
				elseif bagType == ST_SPECIAL then
					if specialType == 0x0008 then			-- Leatherworking
						b.frame:SetBackdropBorderColor(0.8, 0.7, 0.3)
					elseif specialType == 0x0010 then		-- Inscription
						b.frame:SetBackdropBorderColor(0.3, 0.3, 0.8)
					elseif specialType == 0x0020 then		-- Herbs
						b.frame:SetBackdropBorderColor(0.3, 0.7, 0.3)
					elseif specialType == 0x0040 then		-- Enchanting
						b.frame:SetBackdropBorderColor(0.6, 0, 0.6)
					elseif specialType == 0x0080 then		-- Engineering
						b.frame:SetBackdropBorderColor(0.9, 0.4, 0.1)
					elseif specialType == 0x0200 then		-- Gems
						b.frame:SetBackdropBorderColor(0, 0.7, 0.8)
					elseif specialType == 0x0400 then		-- Mining
						b.frame:SetBackdropBorderColor(0.4, 0.3, 0.1)
					elseif specialType == 0x10000 then		-- Cooking
						b.frame:SetBackdropBorderColor(0.9, 0, 0.1)
					end
					b.frame.lock = true
				elseif T.Mainline and i == 5 then 		-- Reagent
					b.frame:SetBackdropBorderColor(0.5, 0.25, 0.1)
					b.frame.lock = true
				end

				idx = idx + 1
			end
		end
	end
end

function Stuffing:SetBagsForSorting(c)
	Stuffing_Open()

	self.sortBags = {}

	local cmd = ((c == nil or c == "") and {"d"} or {strsplit("/", c)})

	for _, s in ipairs(cmd) do
		if s == "c" then
			self.sortBags = {}
		elseif s == "d" then
			if not self.bankFrame or not self.bankFrame:IsShown() then
				for _, i in ipairs(BAGS_BACKPACK) do
					if self.bags[i] and self.bags[i].bagType == ST_NORMAL then
						table.insert(self.sortBags, i)
					end
				end
			elseif not _G["StuffingFrameReagent"] or not _G["StuffingFrameReagent"]:IsShown() then
				for _, i in ipairs(BAGS_BANK) do
					if self.bags[i] and self.bags[i].bagType == ST_NORMAL then
						table.insert(self.sortBags, i)
					end
				end
			end
		elseif s == "p" then
			if not self.bankFrame or not self.bankFrame:IsShown() then
				for _, i in ipairs(BAGS_BACKPACK) do
					if self.bags[i] and self.bags[i].bagType == ST_SPECIAL then
						table.insert(self.sortBags, i)
					end
				end
			else
				for _, i in ipairs(BAGS_BANK) do
					if self.bags[i] and self.bags[i].bagType == ST_SPECIAL then
						table.insert(self.sortBags, i)
					end
				end
			end
		else
			table.insert(self.sortBags, tonumber(s))
		end
	end
end

function Stuffing:ADDON_LOADED(addon)
	if addon ~= "ViksUI" then return nil end

	self:RegisterEvent("BAG_UPDATE")
	self:RegisterEvent("ITEM_LOCK_CHANGED")
	self:RegisterEvent("BANKFRAME_OPENED")
	self:RegisterEvent("BANKFRAME_CLOSED")
	self:RegisterEvent("PLAYERBANKSLOTS_CHANGED")
	self:RegisterEvent("PLAYERBANKBAGSLOTS_CHANGED")
	if T.TBC or T.Wrath or T.Cata then
		self:RegisterEvent("GUILDBANKFRAME_OPENED")
		self:RegisterEvent("GUILDBANKFRAME_CLOSED")
	end
	if T.Mainline then
		self:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_SHOW")
		self:RegisterEvent("PLAYER_INTERACTION_MANAGER_FRAME_HIDE")
		self:RegisterEvent("PLAYERREAGENTBANKSLOTS_CHANGED")
		self:RegisterEvent("BAG_CONTAINER_UPDATE")
	end
	self:RegisterEvent("BAG_CLOSED")
	self:RegisterEvent("BAG_UPDATE_COOLDOWN")
	self:RegisterEvent("BAG_UPDATE_DELAYED")

	self:InitBags()

	tinsert(UISpecialFrames, "StuffingFrameBags")
	tinsert(UISpecialFrames, "StuffingFrameReagent")

	ToggleBackpack = Stuffing_Toggle
	ToggleBag = Stuffing_Toggle
	ToggleAllBags = Stuffing_Toggle
	OpenAllBags = Stuffing_Open
	OpenBackpack = Stuffing_Open
	CloseAllBags = Stuffing_Close
	CloseBackpack = Stuffing_Close

	OpenAllBagsMatchingContext = function()
		local count = 0
		for i = 0, NUM_BAG_FRAMES do
			if ItemButtonUtil.GetItemContextMatchResultForContainer(i) == ItemButtonUtil.ItemContextMatchResult.Match then
				Stuffing_Open()
				count = count + 1
			end
		end
		return count
	end

	BankFrame:UnregisterAllEvents()
	BankFrame:SetScale(0.00001)
	BankFrame:SetAlpha(0)
	BankFrame:SetPoint("TOPLEFT")
end

function Stuffing:PLAYER_ENTERING_WORLD()
	Stuffing:UnregisterEvent("PLAYER_ENTERING_WORLD")
	ToggleBackpack()
	ToggleBackpack()
end

function Stuffing:PLAYERBANKSLOTS_CHANGED(id)
	if self.bankFrame and self.bankFrame:IsShown() then
		self:BagSlotUpdate(-1)
	end
end

function Stuffing:PLAYERREAGENTBANKSLOTS_CHANGED(id)
	local button = _G["ReagentBankFrameItem"..id]
	if not button then return end
	local clink = C_Container.GetContainerItemLink(-3, id)
	button:SetBackdropBorderColor(unpack(C.media.border_color))

	if clink then
		local _, _, _, quality = GetContainerItemInfo(-3, id)
		if quality and quality > 1 then
			local r, g, b = GetItemQualityColor(quality)
			button:SetBackdropBorderColor(r, g, b)
		end
	end
end

function Stuffing:BAG_UPDATE(id)
	self:BagSlotUpdate(id)
end

function Stuffing:BAG_UPDATE_DELAYED()
	for _, i in ipairs(BAGS_BACKPACK) do
		local numSlots = C_Container.GetContainerNumSlots(i)
		if self.bags_num[i] and self.bags_num[i] ~= numSlots then
			self:Layout()
			return
		end
	end
end

function Stuffing:ITEM_LOCK_CHANGED(bag, slot)
	if slot == nil then return end
	for _, v in ipairs(self.buttons) do
		if v.bag == bag and v.slot == slot then
			self:SlotUpdate(v)
			break
		end
	end
end

function Stuffing:BANKFRAME_OPENED()
	if not self.bankFrame then
		self:InitBank()
	end

	self:Layout(true)
	for _, x in ipairs(BAGS_BANK) do
		self:BagSlotUpdate(x)
	end

	self.bankFrame:Show()
	Stuffing_Open()

	for _, v in ipairs(self.bagframe_buttons) do
		if v.frame and v.frame.GetInventorySlot then
			v.frame:SetBackdropBorderColor(unpack(C.media.border_color))
			BankFrameItemButton_Update(v.frame)

			if not v.frame.tooltipText then
				v.frame.tooltipText = ""
			end
		end
	end
end

function Stuffing:BANKFRAME_CLOSED()
	if StuffingFrameReagent then
		StuffingFrameReagent:Hide()
	end
	if self.bankFrame then
		self.bankFrame:Hide()
	end
end

function Stuffing:GUILDBANKFRAME_OPENED()
	Stuffing_Open()
end

function Stuffing:GUILDBANKFRAME_CLOSED()
	Stuffing_Close()
end

function Stuffing:PLAYER_INTERACTION_MANAGER_FRAME_SHOW(...)
	local type = ...
	if type == 10 then	-- Guild bank
		Stuffing_Open()
	elseif type == 40 then	-- ScrappingMachine
		for i = 0, #BAGS_BACKPACK - 1 do
			Stuffing:BAG_UPDATE(i)
		end
	end
end

function Stuffing:PLAYER_INTERACTION_MANAGER_FRAME_HIDE(...)
	local type = ...
	if type == 10 then	-- Guild bank
		Stuffing_Close()
	end
end

function Stuffing:BAG_CLOSED(id)
	local b = self.bags[id]
	if b then
		table.remove(self.bags, id)
		b:Hide()
		table.insert(trashBag, #trashBag + 1, b)
		self.bags_num[id] = -1
	end

	while true do
		local changed = false

		for i, v in ipairs(self.buttons) do
			if v.bag == id then
				v.frame:Hide()
				v.frame.lock = false

				table.insert(trashButton, #trashButton + 1, v.frame)
				table.remove(self.buttons, i)

				v = nil
				changed = true
			end
		end

		if not changed then
			break
		end
	end
	if id > (T.Classic and 4 or 5) then
		Stuffing_Close() -- prevent graphical bug with empty slots
	end
end

function Stuffing:BAG_UPDATE_COOLDOWN()
	for _, v in pairs(self.buttons) do
		self:UpdateCooldowns(v)
	end
end

function Stuffing:BAG_CONTAINER_UPDATE()
	for _, v in ipairs(self.bagframe_buttons) do
		if v.frame and v.slot < (T.Classic and 4 or 5) then -- exclude bank
			v.frame.ID = C_Container.ContainerIDToInventoryID(v.slot + 1)

			local slotLink = GetInventoryItemLink("player", v.frame.ID)
			v.frame:SetBackdropBorderColor(unpack(C.media.border_color))
			if slotLink then
				local _, _, quality = GetItemInfo(slotLink)
				if quality and quality > 1 then
					local r, g, b = GetItemQualityColor(quality)
					v.frame:SetBackdropBorderColor(r, g, b)
				end
			end

			local bag_tex = GetInventoryItemTexture("player", v.frame.ID)
			_G[v.frame:GetName().."IconTexture"]:SetTexture(bag_tex)
		end
	end
end

local function InBags(x)
	if not Stuffing.bags[x] then
		return false
	end

	for _, v in ipairs(Stuffing.sortBags) do
		if x == v then
			return true
		end
	end
	return false
end

local BS_bagGroups
local BS_itemSwapGrid

local function BS_clearData()
	BS_itemSwapGrid = {}
	BS_bagGroups = {}
end

function Stuffing:SortOnUpdate(elapsed)
	self.elapsed = (self.elapsed or 0) + elapsed

	if self.elapsed < 0.05 then
		return
	end

	self.elapsed = 0

	local changed = false
	local blocked = false

	for bagIndex in pairs(BS_itemSwapGrid) do
		for slotIndex in pairs(BS_itemSwapGrid[bagIndex]) do
			local destinationBag = BS_itemSwapGrid[bagIndex][slotIndex].destinationBag
			local destinationSlot = BS_itemSwapGrid[bagIndex][slotIndex].destinationSlot

			local _, _, locked1 = GetContainerItemInfo(bagIndex, slotIndex)
			local _, _, locked2 = GetContainerItemInfo(destinationBag, destinationSlot)

			if locked1 or locked2 then
				blocked = true
			elseif bagIndex ~= destinationBag or slotIndex ~= destinationSlot then
				C_Container.PickupContainerItem(bagIndex, slotIndex)
				C_Container.PickupContainerItem(destinationBag, destinationSlot)

				local tempItem = BS_itemSwapGrid[destinationBag][destinationSlot]
				BS_itemSwapGrid[destinationBag][destinationSlot] = BS_itemSwapGrid[bagIndex][slotIndex]
				BS_itemSwapGrid[bagIndex][slotIndex] = tempItem

				changed = true
				return
			end
		end
	end

	if not changed and not blocked then
		self:SetScript("OnUpdate", nil)
		BS_clearData()
	end
end

function Stuffing:SortBags()
	BS_clearData()

	local bagList
	if _G["StuffingFrameReagent"] and _G["StuffingFrameReagent"]:IsShown() then
		bagList = {-3}
	elseif Stuffing.bankFrame and Stuffing.bankFrame:IsShown() then
		bagList = T.Vanilla and {10, 9, 8, 7, 6, 5, -1} or T.Classic and {11, 10, 9, 8, 7, 6, 5, -1} or {12, 11, 10, 9, 8, 7, 6, -1}
	else
		bagList = {4, 3, 2, 1, 0}
	end

	for _, slotNum in pairs(bagList) do
		if C_Container.GetContainerNumSlots(slotNum) > 0 then
			BS_itemSwapGrid[slotNum] = {}
			local family = select(2, C_Container.GetContainerNumFreeSlots(slotNum))
			if family then
				if family == 0 then family = "Default" end
				if not BS_bagGroups[family] then
					BS_bagGroups[family] = {}
					BS_bagGroups[family].bagSlotNumbers = {}
				end
				table.insert(BS_bagGroups[family].bagSlotNumbers, slotNum)
			end
		end
	end

	for _, group in pairs(BS_bagGroups) do
		group.itemList = {}
		for _, bagSlot in pairs(group.bagSlotNumbers) do
			for itemSlot = 1, C_Container.GetContainerNumSlots(bagSlot) do
				local itemLink = C_Container.GetContainerItemLink(bagSlot, itemSlot)
				if itemLink ~= nil then
					local newItem = {}

					local n, _, q, iL, rL, c1, c2, _, Sl, _, _, classID = GetItemInfo(itemLink)
					local p = 1
					-- Hearthstone
					if n == GetItemInfo(6948) or n == GetItemInfo(110560) or n == GetItemInfo(140192) then
						p = 99
					elseif n == GetItemInfo(141605) then -- Flight Master's Whistle
						p = 98
					elseif n == GetItemInfo(128353) then -- Admiral's Compass
						p = 97
					end
					-- Fix for battle pets
					if not n then
						n = itemLink
						q = select(4, GetContainerItemInfo(bagSlot, itemSlot))
						iL = 1
						rL = 1
						c1 = "Pet"
						c2 = "Pet"
						Sl = ""
					end

					-- Keystone
					local ks = strmatch(itemLink, "keystone:(%d+)")
					if ks then
						p = 10
					end

					if classID == 0 then	-- Consumable
						p = 9
					elseif classID == 2 or classID == 4 then	-- Weapon and Armor
						p = 8
					end

					newItem.sort = p..q..c1..c2..rL..n..iL..Sl

					tinsert(group.itemList, newItem)

					BS_itemSwapGrid[bagSlot][itemSlot] = newItem
					newItem.startBag = bagSlot
					newItem.startSlot = itemSlot
				end
			end
		end

		table.sort(group.itemList, function(a, b)
			return a.sort > b.sort
		end)

		for index, item in pairs(group.itemList) do
			local gridSlot = index
			for _, bagSlotNumber in pairs(group.bagSlotNumbers) do
				if gridSlot <= C_Container.GetContainerNumSlots(bagSlotNumber) then
					BS_itemSwapGrid[item.startBag][item.startSlot].destinationBag = bagSlotNumber
					BS_itemSwapGrid[item.startBag][item.startSlot].destinationSlot = C_Container.GetContainerNumSlots(bagSlotNumber) - gridSlot + 1
					break
				else
					gridSlot = gridSlot - C_Container.GetContainerNumSlots(bagSlotNumber)
				end
			end
		end
	end

	self:SetScript("OnUpdate", Stuffing.SortOnUpdate)
end

function Stuffing:RestackOnUpdate(e)
	if not self.elapsed then
		self.elapsed = 0
	end

	self.elapsed = self.elapsed + e

	if self.elapsed < 0.1 then return end

	self.elapsed = 0
	self:Restack()
end

function Stuffing:Restack()
	local st = {}
	local sr = {}
	local did_restack = false

	Stuffing_Open()

	if _G["StuffingFrameReagent"] and _G["StuffingFrameReagent"]:IsShown() then
		for slotID = 1, 98 do
			local _, cnt, _, _, _, _, clink = GetContainerItemInfo(-3, slotID)
			if clink then
				local n, _, _, _, _, _, _, s = GetItemInfo(clink)

				if n and cnt ~= s then
					if not sr[clink] then
						sr[clink] = {{item = slotID, size = cnt, max = s}}
					else
						table.insert(sr[clink], {item = slotID, size = cnt, max = s})
					end
				end
			end
		end

		for _, v in pairs(sr) do
			if #v > 1 then
				for j = 2, #v, 2 do
					local a, b = v[j - 1], v[j]
					local _, _, l1 = GetContainerItemInfo(-3, a.item)
					local _, _, l2 = GetContainerItemInfo(-3, b.item)

					if l1 or l2 then
						did_restack = true
					else
						C_Container.PickupContainerItem(-3, a.item)
						C_Container.PickupContainerItem(-3, b.item)
						did_restack = true
					end
				end
			end
		end
	else
		for _, v in pairs(self.buttons) do
			if InBags(v.bag) then
				local _, cnt, _, _, _, _, clink = GetContainerItemInfo(v.bag, v.slot)
				if clink then
					local n, _, _, _, _, _, _, s = GetItemInfo(clink)

					if n and cnt ~= s then
						if not st[clink] then
							st[clink] = {{item = v, size = cnt, max = s}}
						else
							table.insert(st[clink], {item = v, size = cnt, max = s})
						end
					end
				end
			end
		end
		for _, v in pairs(st) do
			if #v > 1 then
				for j = 2, #v, 2 do
					local a, b = v[j - 1], v[j]
					local _, _, l1 = GetContainerItemInfo(a.item.bag, a.item.slot)
					local _, _, l2 = GetContainerItemInfo(b.item.bag, b.item.slot)

					if l1 or l2 then
						did_restack = true
					else
						C_Container.PickupContainerItem(a.item.bag, a.item.slot)
						C_Container.PickupContainerItem(b.item.bag, b.item.slot)
						did_restack = true
					end
				end
			end
		end
	end

	if did_restack then
		self:SetScript("OnUpdate", Stuffing.RestackOnUpdate)
	else
		self:SetScript("OnUpdate", nil)
	end
end

function Stuffing:PLAYERBANKBAGSLOTS_CHANGED()
	if not StuffingPurchaseButtonBank then return end
	local numSlots, full = GetNumBankSlots()
	if full then
		StuffingPurchaseButtonBank:Hide()
	else
		StuffingPurchaseButtonBank:Show()
	end

	local button
	for i = 1, NUM_BANKBAGSLOTS, 1 do
		button = _G["StuffingBBag"..i.."Slot"]
		if button then
			if i <= numSlots then
				SetItemButtonTextureVertexColor(button, 1.0, 1.0, 1.0)
			else
				SetItemButtonTextureVertexColor(button, 1.0, 0.1, 0.1)
			end
		end
	end
end

function Stuffing.Menu(self, level)
	if not level then return end

	local info = self.info

	wipe(info)

	if level ~= 1 then return end

	if T.Mainline then
		wipe(info)
		info.text = BAG_FILTER_CLEANUP.." Blizzard"
		info.notCheckable = 1
		info.func = function()
			if _G["StuffingFrameReagent"] and _G["StuffingFrameReagent"]:IsShown() then
				C_Container.SortReagentBankBags()
			elseif Stuffing.bankFrame and Stuffing.bankFrame:IsShown() then
				C_Container.SortBankBags()
			else
				C_Container.SortBags()
			end
		end
		UIDropDownMenu_AddButton(info, level)
	end

	wipe(info)
	info.text = BAG_FILTER_CLEANUP
	info.notCheckable = 1
	info.func = function()
		if InCombatLockdown() then
			print("|cffffff00"..ERR_NOT_IN_COMBAT.."|r") return
		end
		Stuffing:SortBags()
	end
	UIDropDownMenu_AddButton(info, level)

	wipe(info)
	info.text = L_BAG_STACK_MENU
	info.notCheckable = 1
	info.func = function()
		if InCombatLockdown() then
			print("|cffffff00"..ERR_NOT_IN_COMBAT.."|r") return
		end
		Stuffing:SetBagsForSorting("d")
		Stuffing:Restack()
	end
	UIDropDownMenu_AddButton(info, level)

	wipe(info)
	info.text = L_BAG_SHOW_BAGS
	info.checked = function()
		return bag_bars == 1
	end

	info.func = function()
		if bag_bars == 1 then
			bag_bars = 0
		else
			bag_bars = 1
		end
		Stuffing:Layout()
		if Stuffing.bankFrame and Stuffing.bankFrame:IsShown() then
			Stuffing:Layout(true)
		end
	end
	UIDropDownMenu_AddButton(info, level)

	if T.Classic then
		wipe(info)
		info.text = BINDING_NAME_TOGGLEKEYRING
		info.notCheckable = 1
		info.func = function()
			if InCombatLockdown() then
				print("|cffffff00"..ERR_NOT_IN_COMBAT.."|r") return
			end
			Stuffing_ToggleBag(-2)
		end
		UIDropDownMenu_AddButton(info, level)
	end

	wipe(info)
	info.disabled = nil
	info.notCheckable = 1
	info.text = CLOSE
	info.func = self.HideMenu
	info.tooltipTitle = CLOSE
	UIDropDownMenu_AddButton(info, level)
end

StaticPopupDialogs.BUY_BANK_SLOT = {
	text = CONFIRM_BUY_BANK_SLOT,
	button1 = YES,
	button2 = NO,
	OnAccept = PurchaseSlot,
	OnShow = function(self)
		MoneyFrame_Update(self.moneyFrame, GetBankSlotCost())
	end,
	hasMoneyFrame = 1,
	timeout = 0,
	hideOnEscape = 1,
	preferredIndex = 5,
}

-- Kill Blizzard functions
LootWonAlertFrame_OnClick = T.dummy
LootUpgradeFrame_OnClick = T.dummy
LegendaryItemAlertFrame_OnClick = T.dummy
