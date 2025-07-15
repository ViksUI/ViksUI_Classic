local T, C, L = unpack(ViksUI)

C["position"] = {
	-- ActionBar positions
	["bottom_bars"] = {"BOTTOM", UIParent, "BOTTOM", 0, 40},						-- Bottom bars
	["right_bars"] = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -21, 330},			-- Right bars
	["pet_horizontal"] = {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 2, (C.panels.CPTextheight+(C.panels.CPbarsheight*2))+26},			-- Horizontal pet bar
	["stance_bar"] = {"BOTTOMRIGHT", UIParent, "BOTTOM", -202, 167},				-- Stance bar
	["vehicle_bar"] = {"BOTTOMRIGHT", ActionButton1, "BOTTOMLEFT", -3, 0},			-- Vehicle button
	["extra_button"] = {"BOTTOMRIGHT", ActionButton1, "BOTTOMLEFT", -3, 0},			-- Extra action button
	["zone_button"] = {"BOTTOMRIGHT", ActionButton1, "BOTTOMLEFT", -3, 0},			-- Zone action button
	["micro_menu"] = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -4, 200},					-- Micro menu
	-- UnitFrame positions
	unitframes = {
		["player"] = {"TOPRIGHT", UIParent, "BOTTOM", -158, 320},					-- Player frame
		["player_heal"] = {"TOPRIGHT", UIParent, "BOTTOM", -270, 305},				-- Player frame Heal
		["target"] = {"TOPLEFT", UIParent, "BOTTOM", 158, 320},						-- Target frame
		["target_heal"] = {"TOPLEFT", UIParent, "BOTTOM", 270, 305},				-- Target frame Heal
		["target_target"] = {"BOTTOM", UIParent, "BOTTOM", 0, 259},					-- ToT frame
		["target_target_heal"] = {"BOTTOM", UIParent, "BOTTOM", 580, 300},			-- ToT frame Heal
		["pet"] = {"BOTTOM", UIParent, "BOTTOM", 0, 289},							-- Pet frame
		["pet_heal"] = {"TOPRIGHT", UIParent, "BOTTOM", -540, 285},					-- Pet frame Heal
		["focus"] = {"TOPLEFT", UIParent, "BOTTOM", 430, 382},						-- Focus frame
		["focus_heal"] = {"TOPLEFT", UIParent, "BOTTOM", 560, 490},					-- Focus frame Heal
		["focus_target"] = {"TOPLEFT", "oUF_Target", "BOTTOMLEFT", 0, -11},			-- Focus target frame
		["party_heal"] = {"TOPLEFT", "oUF_Player", "BOTTOMRIGHT", 11, -12},			-- Heal layout Party frames
		["raid_heal"] = {"TOPLEFT", "oUF_Player", "BOTTOMRIGHT", 11, -12},			-- Heal layout Raid frames
		["party_dps"] = {"BOTTOMLEFT", UIParent, "LEFT", 23, -70},					-- DPS layout Party frames
		["raid_dps"] = {"TOPLEFT", UIParent, "TOPLEFT", 22, -22},					-- DPS layout Raid frames
		["arena"] = {"BOTTOMRIGHT", UIParent, "RIGHT", -60, -70},					-- Arena frames
		["boss"] = {"RIGHT", UIParent, "RIGHT", -70, -120},							-- Boss frames
		["boss_heal"] = {"RIGHT", UIParent, "RIGHT", -100, -90},					-- Boss frames Heal
		["tank"] = {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 200, 320},				-- Tank frames
		["tank_heal"] = {"BOTTOM", UIParent, "BOTTOM", -80, 330},					-- Tank frames Heal
		["player_portrait"] = {"TOPRIGHT", "oUF_Player", "TOPLEFT", -12, 27},		-- Player Portrait
		["target_portrait"] = {"TOPLEFT", "oUF_Target", "TOPRIGHT", 10, 27},		-- Target Portrait
		["player_castbar"] = {"TOPRIGHT", UIParent, "BOTTOM", -92, 261},			-- Player Castbar
		["player_castbar_heal"] = {"TOPRIGHT", UIParent, "BOTTOM", -182, 282},		-- Player Castbar Heal
		["target_castbar"] = {"TOPLEFT", UIParent, "BOTTOM", 117, 261},				-- Target Castbar
		["target_castbar_heal"] = {"TOPLEFT", UIParent, "BOTTOM", 208, 282},		-- Target Castbar Heal
		["focus_castbar"] = {"TOPLEFT", UIParent, "BOTTOM", 449, 344},				-- Focus Castbar icon
		["focus_castbar_heal"] = {"TOPLEFT", UIParent, "BOTTOM", 579, 450},			-- Focus Castbar icon Heal
	},
	-- Filger positions
	filger = {
		["player_buff_icon"] = {"RIGHT", UIParent, "CENTER", -280, 23},				-- "P_BUFF_ICON"
		["player_proc_icon"] = {"RIGHT", UIParent, "CENTER", -280, 80},				-- "P_PROC_ICON"
		["special_proc_icon"] = {"RIGHT", UIParent, "CENTER", -280, -18},			-- "SPECIAL_P_BUFF_ICON"
		["target_debuff_icon"] = {"LEFT", UIParent, "CENTER", 280, 80},				-- "T_DEBUFF_ICON"
		["target_buff_icon"] = {"LEFT", UIParent, "CENTER", 280, 134},				-- "T_BUFF"
		["pve_debuff"] = {"RIGHT", UIParent, "CENTER", -280, 134},					-- "PVE/PVP_DEBUFF"
		["pve_cc"] = {"LEFT", UIParent, "CENTER", 280, 38},							-- "PVE/PVP_CC"
		["cooldown"] = {"RIGHT", UIParent, "CENTER", -416, -234},					-- "COOLDOWN"
		["target_bar"] = {"LEFT", UIParent, "CENTER", 556, -140},					-- "T_DE/BUFF_BAR"
		["player_bar"] = {"RIGHT", UIParent, "CENTER", -416, -200},					-- "P_BUFF_BAR"
	},
	-- Miscellaneous positions
	["minimap"] = {"TOPRIGHT", UIParent, "TOPRIGHT", -3, -(C.panels.yoffset+C.panels.CPbarsheight+2)},				-- Minimap
	["minimap_buttons"] = {"TOPLEFT", Minimap, "BOTTOMLEFT", -2, -4},				-- Minimap buttons
	["minimapline"] = {"TOPRIGHT", UIParent, "TOPRIGHT", -14, -(C.panels.yoffset+C.panels.CPbarsheight+2)},				-- Minimap Line
	["tooltip"] = {"TOPLEFT", UIParent, "TOPLEFT", 2, -20},							-- Tooltip
	["vehicle"] = {"TOPRIGHT", Minimap, "BOTTOMLEFT", -10, -25},					-- Vehicle frame
	["ghost"] = {"TOP", UIParent, "TOP", 0, -30},									-- Ghost frame
	["bag"] = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -40, 200},					-- Bag
	["bank"] = {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 20, 200},						-- Bank
	["archaeology"] = {"RIGHT", CPMinimb2, "RIGHT", -40, 1},						-- Archaeology frame
	["auto_button"] = {"LEFT", UIParent, "LEFT", 0, 0},								-- Auto button
	["chat"] = {"BOTTOMLEFT", LChat, "BOTTOMLEFT", 5, 21},							-- Chat
	["chat_right"] = {"BOTTOMLEFT", RChat, "BOTTOMLEFT", 5, 21},					-- Chat on right side
	["chatr"] = {"BOTTOMLEFT", RChat, "BOTTOMLEFT", 5, 21},							-- Chat
	["bn_popup"] = {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 5, (C.panels.CPTextheight+(C.panels.CPbarsheight*2))+40},					-- Battle.net popup
	["bn_popup_line"] = {"BOTTOMLEFT", UIParent, "BOTTOMLEFT", 40, 280},			-- Battle.net popup with line style
	["map"] = {"BOTTOM", UIParent, "BOTTOM", -120, 320},							-- Map
	["quest"] = {"TOPLEFT", Minimap, "BOTTOMLEFT", 0, -25},							-- Quest log
	["loot"] = {"TOPLEFT", UIParent, "TOPLEFT", 245, -220},							-- Loot
	["group_loot"] = {"BOTTOMLEFT", "oUF_Player", "TOPLEFT", -2, 173},				-- Group roll loot
	["threat_meter"] = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -4, 200},			-- Threat meter
	["bg_score"] = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 0, 350},				-- BG stats
	["raid_cooldown"] = {"LEFT", UIParent, "LEFT", 5, 130},							-- Raid cooldowns
	["enemy_cooldown"] = {"CENTER", UIParent, "CENTER", 0, -150},					-- Enemy cooldowns
	["pulse_cooldown"] = {"CENTER", UIParent, "CENTER", 0, 0},						-- Pulse cooldowns
	["player_buffs"] = {"TOPRIGHT", Minimap, "TOPLEFT", -6, 2},						-- Player buffs
	["player_debuffs"] = {"BOTTOMRIGHT", Minimap, "BOTTOMLEFT", -6, -2},			-- Player debuffs
	["self_buffs"] = {"TOP", UIParent, "TOP", 0, -60},								-- Self buff reminder
	["raid_buffs"] = {"TOPLEFT", Minimap, "BOTTOMLEFT", 0, -25},					-- Raid buff reminder
	["raid_buffs_line"] = {"TOPLEFT", Minimap, "BOTTOMLEFT", 0, -40},				-- Raid buff reminder
	["raid_utility"] = {"TOP", UIParent, "TOP", -280, -20},							-- Raid utility
	["raid_tool"] = {"TOP", RChat, "TOP", 0, 20},									-- Raid utility
	["top_panel"] = {"TOP", UIParent, "TOP", 0, -30},								-- Top panel
	["achievement"] = {"TOP", UIParent, "TOP", 0, -21},								-- Achievements frame
	["uierror"] = {"TOP", UIParent, "TOP", 0, -30},									-- Errors frame
	["talking_head"] = {"TOP", UIParent, "TOP", 0, -25},							-- Talking Head
	["alt_power_bar"] = {"TOP", UIWidgetTopCenterContainerFrame, "BOTTOM", 0, -7},	-- Alt power bar
	["uiwidget_top"] = {"TOP", UIParent, "TOP", 0, -25},							-- Top Widget
	["uiwidget_below"] = {"BOTTOM", UIParent, "BOTTOM", 0, 216},					-- Below Widget
	["capture_bar"] = {"TOP", UIParent, "TOP", 0, 3},								-- BG capture bars
	["frame4"] = {"BOTTOMRIGHT", "oUF_Target", "TOPRIGHT", 2, 278},
	-- xCT positions
	xct = {
		["frame1"] = {"BOTTOMLEFT", "oUF_Player", "TOPLEFT", -3, 60},
		["frame2"] = {"BOTTOMRIGHT", "oUF_Player", "TOPRIGHT", 5, 60},
		["frame3"] = {"CENTER", 0, 205},
		["frame4"] = {"BOTTOMRIGHT", "oUF_Target", "TOPRIGHT", 2, 278},
	},
}