local T, C, L = unpack(ViksUI)
if T.client ~= "zhTW" then return end

----------------------------------------------------------------------------------------
--	Localization for zhTW client
--	Translation: Aelb, Ianchan, Leg883, Mania, Nanjiqq, Spacedragon, Tat2dawn, Tibles
----------------------------------------------------------------------------------------
-- Announce flasks and food
L_ANNOUNCE_FF_NOFOOD = "缺少食物: "
L_ANNOUNCE_FF_NOFLASK = "缺少精煉: "
L_ANNOUNCE_FF_ALLBUFFED = "已獲得所有增益 !"
L_ANNOUNCE_FF_CHECK_BUTTON = "檢查食物和精煉"

-- Says thanks for some spells
L_ANNOUNCE_SS_THANKS = "謝謝你的 "
L_ANNOUNCE_SS_RECEIVED = " 收到來自于 "

-- Pull countdown announce
L_ANNOUNCE_PC_GO = "開始 !"
L_ANNOUNCE_PC_MSG = "準備接怪: %s，倒數 %s.."
L_ANNOUNCE_PC_ABORTED = "取消拉怪 !"

-- Announce feasts and portals
L_ANNOUNCE_FP_STAT = "%s 放置了 %s - [%s]。"
L_ANNOUNCE_FP_PRE = "%s 放置了 %s"
L_ANNOUNCE_FP_PUT = "%s 放置了 %s"
L_ANNOUNCE_FP_CAST = "%s 開啟了 %s"
L_ANNOUNCE_FP_CLICK = "%s 正在開啟 %s... 請點擊 !"
L_ANNOUNCE_FP_USE = "%s 使用了 %s。"

-- Announce your interrupts
L_ANNOUNCE_INTERRUPTED = "已打斷"

-- Tooltip
L_TOOLTIP_NO_TALENT = "沒有天賦"
L_TOOLTIP_LOADING = "讀取中..."
L_TOOLTIP_ACH_STATUS = "你的狀態: "
L_TOOLTIP_ACH_COMPLETE = "你的狀態: 完成"
L_TOOLTIP_ACH_INCOMPLETE = "你的狀態: 未完成"
L_TOOLTIP_SPELL_ID = "法術ID: "
L_TOOLTIP_ITEM_ID = "物品ID: "
L_TOOLTIP_WHO_TARGET = "關注"
L_TOOLTIP_ITEM_COUNT = "物品數量: "
L_TOOLTIP_INSPECT_OPEN = "檢查框體已開啟"

-- Misc
L_MISC_UNDRESS = "無裝備"
L_MISC_DRINKING = " 進食中..."
L_MISC_BUY_STACK = "Alt+右鍵點擊購買一疊"
L_MISC_ONECLICK_BUYOUT = "Shift+右鍵,不彈出確認窗口直接購買"
L_MISC_ONECLICK_BID = "Shift+右鍵,不彈出確認窗口直接競標"
L_MISC_ONECLICK_CANCEL = "Shift+右鍵,不彈出確認窗口直接取消選擇的物品"
L_MISC_UI_OUTDATED = "ViksUI 版本已過期，請至 http://goo.gl/QAj0J6 下載最新版"
L_MISC_HEADER_MARK = "鼠標懸停顯示團隊圖標"
L_MISC_BINDER_OPEN = "鼠標綁定"
L_MISC_GROCERY_BUY = "購買"
L_MISC_GROCERY_DESC = "雜貨商自動購買"
L_MISC_SCROLL = "附魔卷軸"
L_MISC_COLLAPSE = "The Collapse" -- Need review
L_MISC_HEADER_QUEST = "Auto quest button" -- Needs review
-- Raid Utility
L_RAID_UTIL_DISBAND = "解散團隊"

-- Zone name
L_ZONE_TOLBARAD = "托巴拉德"
L_ZONE_TOLBARADPEN = "托巴拉德半島"
L_ZONE_ARATHIBASIN = "阿拉希盆地"
L_ZONE_GILNEAS = "吉爾尼斯之戰"
L_ZONE_ANCIENTDALARAN = "達拉然陷坑"

-- WatchFrame Wowhead link
L_WATCH_WOWHEAD_LINK = "Wowhead鏈接"

-- Toggle Menu
L_TOGGLE_ADDON = "插件 "
L_TOGGLE_ADDONS = " 插件系列"
L_TOGGLE_EXPAND = "展開 "
L_TOGGLE_COLLAPSE = "折疊 "
L_TOGGLE_RCLICK = "右鍵 啟用/禁用"
L_TOGGLE_LCLICK = "左鍵 顯示/隱藏窗口 "
L_TOGGLE_RELOAD = " (需要重載插件)"
L_TOGGLE_NOT_FOUND = " 未創建"

-- UnitFrame
L_UF_GHOST = "靈魂"
L_UF_DEAD = "死亡"
L_UF_OFFLINE = "離線"
L_UF_MANA = "低法力值"

-- Map
L_MAP_CURSOR = "滑鼠: "
L_MAP_BOUNDS = "超出範圍 !"
L_MAP_FOG = "地圖全亮"
L_MAP_COORDS = "坐標"

-- Minimap
L_MINIMAP_CALENDAR = "日曆"
L_MINIMAP_HEAL_LAYOUT = "左鍵 - HPS 佈局"
L_MINIMAP_DPS_LAYOUT = "右鍵 - DPS 佈局"
L_MINIMAP_BLIZZ_LAYOUT = "中鍵 - 暴雪 佈局"
L_MINIMAP_FARM = "小地圖大小"
L_MINIMAP_TOGGLE = "快捷列自由折疊"

-- Chat
L_CHAT_WHISPER = "From"
L_CHAT_BN_WHISPER = "From"
L_CHAT_AFK = "[AFK]"
L_CHAT_DND = "[DND]"
L_CHAT_GM = "[GM]"
L_CHAT_GUILD = "G"
L_CHAT_PARTY = "P"
L_CHAT_PARTY_LEADER = "PL"
L_CHAT_RAID = "R"
L_CHAT_RAID_LEADER = "RL"
L_CHAT_RAID_WARNING = "RW"
L_CHAT_INSTANCE_CHAT = "I"
L_CHAT_INSTANCE_CHAT_LEADER = "IL"
L_CHAT_OFFICER = "O"
L_CHAT_PET_BATTLE = "PB"
L_CHAT_COME_ONLINE = "|cff298F00上線了|r"
L_CHAT_GONE_OFFLINE = "|cffff0000下線了|r"

-- Errors frame
L_ERRORFRAME_L = "點擊查看錯誤"

-- Bags
L_BAG_BANK = "Bank"
L_BAG_NO_SLOTS = "Can't buy anymore slots!"
L_BAG_COSTS = "Cost: %.2f gold"
L_BAG_BUY_SLOTS = "Buy new slot with /bags purchase yes"
L_BAG_OPEN_BANK = "You need to open your bank first."
L_BAG_SORT = "Sort your bags or your bank, if open."
L_BAG_STACK = "Fill up partial stacks in your bags or bank, if open."
L_BAG_BUY_BANKS_SLOT = "Buy bank slot (need to have bank open)."
L_BAG_SORT_MENU = "Sort"
L_BAG_SORT_SPECIAL = "Sort Special"
L_BAG_STACK_MENU = "Stack"
L_BAG_STACK_SPECIAL = "Stack Special"
L_BAG_SHOW_BAGS = "顯示背包"
L_BAG_SORTING_BAGS = "Sorting finished."
L_BAG_NOTHING_SORT = "Nothing to sort."
L_BAG_BAGS_BIDS = "Using bags: "
L_BAG_STACK_END = "Restacking finished."
L_BAG_RIGHT_CLICK_SEARCH = "點擊右鍵以搜尋物品"
L_BAG_STACK_MENU = "堆疊"
L_BAG_BUTTONS_DEPOSIT = "Deposit Reagents"
L_BAG_BUTTONS_SORT = "LM:Cleanup / RM:Blizzard"
L_BAG_BUTTONS_ARTIFACT = "Right click to use Artifact Power item in bag"
L_BAG_RIGHT_CLICK_CLOSE = "右鍵點擊打開菜單"

-- Grab mail
L_MAIL_STOPPED = "無法拾取, 背囊已滿."
L_MAIL_UNIQUE = "中止,在背包或銀行發現重複的唯一物品."
L_MAIL_COMPLETE = "完成"
L_MAIL_NEED = "需要一個信箱"
L_MAIL_MESSAGES = "新郵件"

-- Loot
L_LOOT_RANDOM = "隨機玩家"
L_LOOT_SELF = "自己拾取"
L_LOOT_FISH = "釣魚拾取"
L_LOOT_ANNOUNCE = "向頻道通告"
L_LOOT_TO_RAID = " 團隊"
L_LOOT_TO_PARTY = " 隊伍"
L_LOOT_TO_GUILD = " 公會"
L_LOOT_TO_SAY = " 說"

-- LitePanels AFK module
L_PANELS_AFK = "你處于暫離狀態"
L_PANELS_AFK_RCLICK = "右鍵點擊隱藏"
L_PANELS_AFK_LCLICK = "左鍵點擊脫離暫離狀態"

-- Cooldowns
L_COOLDOWNS = "CD: "
L_COOLDOWNS_COMBATRESS = "戰復"
L_COOLDOWNS_COMBATRESS_REMAINDER = "戰復剩餘: "
L_COOLDOWNS_NEXTTIME = "下次: "

-- Autoinvite
L_INVITE_ENABLE = "自動邀請功能已啟用: "
L_INVITE_DISABLE = "自動邀請功能已關閉"

-- Bind key
L_BIND_SAVED = "所有快捷鍵設置被保存"
L_BIND_DISCARD = "所有新的快捷鍵設置被取消"
L_BIND_INSTRUCT = "將滑鼠懸停至任意快捷欄進行綁定. 按ESC或者右鍵點擊以清除當前快捷欄的按鍵綁定."
L_BIND_CLEARED = "已經清除所有的快捷鍵設置"
L_BIND_BINDING = "綁定"
L_BIND_KEY = "按鍵"
L_BIND_NO_SET = "沒有綁定快捷鍵"

-- Info text
L_INFO_ERRORS = "目前沒有錯誤"
L_INFO_INVITE = "接受邀請 "
L_INFO_DUEL = "拒絕決鬥請求 "
L_INFO_PET_DUEL = "拒絕寵物對戰請求 "
L_INFO_DISBAND = "解散隊伍"
L_INFO_SETTINGS_DBM = "鍵入 /settings dbm, 載入 DBM 的設定"
L_INFO_SETTINGS_BIGWIGS = "鍵入 /settings bw, 載入 BigWigs 的設定"
L_INFO_SETTINGS_MSBT = "鍵入 /settings msbt, 載入 MSBT 的設定"
L_INFO_SETTINGS_SKADA = "鍵入 /settings skada, 載入 Skada 的設定"
L_INFO_SETTINGS_ALL = "鍵入 /settings all, 載入所有UI設定"
L_INFO_SETTINGS_CHAT = "Type /settings chat, to apply the default chat settings."
L_INFO_SETTINGS_CVAR = "Type /settings cvar, to apply the default cvar(Game UI) settings."
L_INFO_SETTINGS_ALL = "Type /settings all, to apply the settings for all modifications."
L_INFO_NOT_INSTALLED = " 沒有安裝"
L_INFO_SKIN_DISABLED1 = "介面樣式啟用"
L_INFO_SKIN_DISABLED2 = " 已禁用"

-- Moving elements
L_MOVE_RIGHT_CLICK = "右鍵重置位置"
L_MOVE_MIDDLE_CLICK = "中鍵臨時隱藏"

-- Popups
L_POPUP_INSTALLUI = "該角色首次使用ViksUI.你必須重新加載UI來配置."
L_POPUP_RESETUI = "你確定要重新加載ViksUI?"
L_POPUP_RESETSTATS = "你確定要重置本次遊戲時間和金幣收益統計數據嗎?"
L_POPUP_SWITCH_RAID = "選擇團隊佈局."
L_POPUP_DISBAND_RAID = "你確定要解散團隊?"
L_POPUP_DISABLEUI = "ViksUI並不支援此解析度, 你想要停用ViksUI嗎? (若果您想要嘗試其他解析度, 請按取消)"
L_POPUP_SETTINGS_ALL = "應用所有的UI設置(DBM/DXE, Skada and MSBT)?"
L_POPUP_SETTINGS_DBM = "需要改變DBM描點及風格化元素."
L_POPUP_SETTINGS_BW = "需要改變BigWigs描點及風格化元素."
L_POPUP_ARMORY = "查看英雄榜"
L_POPUP_CURRENCY_CAP = "您擁有的最高級貨幣為"

-- Welcome message
L_WELCOME_LINE_1 = "歡迎使用ViksUI "
L_WELCOME_LINE_2_1 = "輸入/cfg進行UI設置,或者訪問https://discord.gg/Dhp5nHh"
L_WELCOME_LINE_2_2 = "獲取更多信息"

-- Combat text
L_COMBATTEXT_KILLING_BLOW = "最後一擊"
L_COMBATTEXT_TEST_DISABLED = "戰鬥信息測試模式已禁用"
L_COMBATTEXT_TEST_ENABLED = "戰鬥信息測試模式已啟用"
L_COMBATTEXT_TEST_USE_MOVE = "鍵入 /xct move 移動/調整戰鬥信息框架大小"
L_COMBATTEXT_TEST_USE_TEST = "鍵入 /xct test 啟用/禁用戰鬥信息測試模式"
L_COMBATTEXT_TEST_USE_RESET = "鍵入 /xct reset 重置到初始位置"
L_COMBATTEXT_POPUP = "保存戰鬥信息窗口的位置須重載插件"
L_COMBATTEXT_UNSAVED = "戰鬥信息窗口位置尚未保存，不要忘記重新載入插件。"
L_COMBATTEXT_UNLOCKED = "戰鬥信息已解鎖"

-- LiteStats
L_STATS_ACC_PLAYED = "帳號啟用總時間"
L_STATS_ADDED_JUNK = "增加自動販售例外名單"
L_STATS_REMOVE_EXCEPTION = "新增/移除 例外名單"
L_STATS_AUTO_REPAIR = "自動修裝"
L_STATS_GUILD_REPAIR = "公會銀行修裝"
L_STATS_AUTO_SELL = "自動販售灰色物品"
L_STATS_BANDWIDTH = "寬頻:"
L_STATS_DOWNLOAD = "下載:"
L_STATS_CLEARED_JUNK = "清除自動販售例外名單列表"
L_STATS_CLEAR_EXCEPTIONS = "清除例外名單列表"
L_STATS_CURRENCY_PROFESSIONS_T = "Professions" -- Needs review
L_STATS_CURRENCY_RAID = "Raid Seals" -- Needs review
L_STATS_WORLD_MAP = "點擊開啟世界地圖"
L_STATS_CURRENT_XP = "目前/升級所需 經驗值"
L_STATS_MEMORY_USAGE = "插件資源佔用:"
L_STATS_GARBAGE_COLLECTED = "垃圾資源清除"
L_STATS_CHANGE_SORTING = "[公會]右鍵更改排列方式,Shift+右鍵反轉排列方式"
L_STATS_HIDDEN = "隱藏"
L_STATS_VIEW_NOTES = "按住Alt鍵檢視公會成員階級/註記/幹部註記"
L_STATS_HR = "小時"
L_STATS_INF = "無限"
L_STATS_ALREADY_EXCEPTIONS = "物品已在例外名單列表"
L_STATS_NOT_JUNK = "is not junk."
L_STATS_ITEMLINK = "物品鏈結"
L_STATS_JUNK_EXCEPTIONS = "自動販售例外名單"
L_STATS_JUNK_LIST = "自動販售列表"
L_STATS_JUNK_PROFIT = "自動販售所得金額"
L_STATS_KILLS = "K"
L_STATS_OPEN_CALENDAR = "左鍵開啟行事曆"
L_STATS_OPEN_CHARACTER = "左鍵開啟人物欄"
L_STATS_OPEN_CURRENCY = "左鍵開啟貨幣欄"
L_STATS_OPEN_TALENT = "左鍵開啟天賦視窗"
L_STATS_XP_RATE = "當前等級經驗值趴數"
L_STATS_IGNORED_ITEMS = "列出目前忽略物品"
L_STATS_TOGGLE_TIME = "當地/伺服器 及24小時制可顯示於時間管理器"
L_STATS_LOCATION = "位置/座標"
L_STATS_MEMORY = "記憶體"
L_STATS_ON = "啟用"
L_STATS_OTHER_OPTIONS = "其它選項可能配置在 %s"
L_STATS_PLAYED_LEVEL = "當前等級總上線時間"
L_STATS_PLAYED_SESSION = "此次上線時段耗費時間"
L_STATS_PLAYED_TOTAL = "總上線時間"
L_STATS_QUEST = "任務"
L_STATS_QUESTS_TO = "任務/殺怪 得到經驗值 %s"
L_STATS_REMAINING_XP = "升級尚需經驗值"
L_STATS_REMOVED_JUNK = "移除自動販售例外名單"
L_STATS_RESTED_XP = "休息獎勵經驗值"
L_STATS_RC_COLLECTS_GARBAGE = "右鍵點擊清除插件垃圾資源"
L_STATS_RC_TIME_MANAGER = "右鍵開啟時間管理器"
L_STATS_RC_EXPERIENCE = "右鍵切換顯示經驗值/上線時間/角色資訊"
L_STATS_RC_AUTO_REPAIRING = "右鍵顯示自動修裝"
L_STATS_RC_AUTO_SELLING = "右鍵開啟自動販售"
L_STATS_RC_TALENT = "右鍵切換天賦"
L_STATS_SERVER_GOLD = "帳號總現金"
L_STATS_SESSION_GAIN = "此次在線時段獲得/損失金額"
L_STATS_SESSION_XP = "此次在線時段所得經驗值"
L_STATS_SORTING_BY = "排列方式: "
L_STATS_SEALS = "本週已領徽印"
L_STATS_SPEC = "專精"
L_STATS_TIPS = "提示: "
L_STATS_OPEN_CALENDAR = "左鍵開/關行事曆"
L_STATS_RC_TIME_MANAGER = "右鍵開/關計時器"
L_STATS_TOGGLE_TIME = "當地/伺服器及24小時制可於計時器中設置"
L_STATS_MEMORY = "記憶體"
L_STATS_RC_COLLECTS_GARBAGE = "幀數模塊上滑鼠懸停顯示，右鍵整理記憶體"
L_STATS_VIEW_NOTES = "按住Alt鍵檢視: 好友的所在地 公會成員的階級/註記/幹部註記"
L_STATS_CHANGE_SORTING = "[公會]右鍵密語/邀請，中鍵更改排列方式，Shift+中鍵反轉排序"
L_STATS_OPEN_CHARACTER = "左鍵開/關角色界面"
L_STATS_RC_AUTO_REPAIRING1 = "右鍵開/關自動修裝"
L_STATS_RC_AUTO_REPAIRING2 = "中鍵開/關公會修裝"
L_STATS_EQUIPMENT_CHANGER = "Shift+左鍵或Alt+左鍵開啟套裝選單"
L_STATS_RC_EXPERIENCE = "右鍵切換在線時間/神器信息/經驗值/聲望值"
L_STATS_WATCH_FACTIONS = "左鍵開/關相關界面"
L_STATS_TOOLTIP_EXPERIENCE = "未達最高等級時將優先顯示經驗值訊息"
L_STATS_TOOLTIP_TIME_PLAYED = "達到最高等級後將優先顯示角色在線時間"
L_STATS_OPEN_TALENT = "左鍵開啟專精選單，Shift+左鍵開啟專精界面"
L_STATS_RC_TALENT = "右鍵開啟拾取專精選單"
L_STATS_LOCATION = "位置/座標"
L_STATS_WORLD_MAP = "點擊開/關世界地圖"
L_STATS_INSERTS_COORDS = "Shift+左鍵地名/座標自動複製到輸入框"
L_STATS_OPEN_CURRENCY = "左鍵開/關兌換通貨界面"
L_STATS_RC_AUTO_SELLING = "右鍵開/關自動販售"
L_STATS_NEED_TO_SELL = "鍵入 /junk 列出常用命令"
L_STATS_WATCH_CURRENCY = "在兌換通貨界面已選定的通貨將在金幣提示信息中顯示"
L_STATS_OTHER_OPTIONS = "其它選項可以在這裡設置: %s"

-- Slash commands
L_SLASHCMD_HELP = {
	"可用的斜杠命令:",
	"/rl - 重載介面",
	"/rc - 提出準備就緒的確認",
	"/gm - 打開GM面板",
	"/dis ADDON_NAME - 禁用插件",
	"/en ADDON_NAME - 開啟插件",
	"/rd - 解散隊伍",
	"/toraid - 轉換為團隊或隊伍",
	"/teleport - 傳出隨機副本的命令",
	"/spec - 切換天賦",
	"/heal - 載入治療模式介面",
	"/dps - 載入傷害輸出模式介面",
	"/frame - 在聊天窗口輸出框架名稱",
	"/farmmode - 打開/關閉 小地圖採集模式",
	"/moveui - 解鎖/鎖定 介面內所有移動的框體",
	"/resetui - 重置介面設置到初始狀態",
	"/resetuf - 重置頭像面板到初始狀態",
	"/resetconfig - 重置已修改的設置",
	"/resetstats - 重置人物屬性狀態面板",
	"/settings ADDON_NAME - 設置插件",
	"/ls - 載入設置",
	"/xct - 戰鬥信息選項",
	"/raidcd - 團隊技能冷卻監視條選項",
	"/enemycd - 敵對技能冷卻監視選項",
	"/pulsecd - 冷卻提醒選項",
	"/threat - 仇恨條選項",
	"/tt - 密語當前所選定的目標",
	"/ainv - 打開/關閉 自動接受公會/好友組隊邀請",
	"/testuf - 測試頭像框體位置",
	"/cfg - 打開介面設置面板",
}

------------------------------------------------
L.DataText = {} -- Data Text Locales  -- Needs review
------------------------------------------------

L.DataText.LootSpec = "Loot Specialization"
L.DataText.Garrison = "Garrison"
L.DataText.Zone = "Zone"
L.DataText.AvoidanceBreakdown = "Avoidance Breakdown"
L.DataText.Level = "Lvl"
L.DataText.Boss = "Boss"
L.DataText.Miss = "Miss"
L.DataText.Dodge = "Dodge"
L.DataText.Block = "Block"
L.DataText.Parry = "Parry"
L.DataText.Avoidance = "Avoidance"
L.DataText.AvoidanceShort = "Avd: "
L.DataText.Memory = "Memory"
L.DataText.Hit = "Hit"
L.DataText.Power = "Power"
L.DataText.Mastery = "Mastery"
L.DataText.Crit = "Crit"
L.DataText.Regen = "Regen"
L.DataText.Versatility = "Versatility"
L.DataText.Leech = "Leech"
L.DataText.Multistrike = "Multistrike"
L.DataText.Session = "Session: "
L.DataText.Earned = "Earned:"
L.DataText.Spent = "Spent:"
L.DataText.Deficit = "Deficit:"
L.DataText.Profit = "Profit:"
L.DataText.Character = "Character: "
L.DataText.Server = "Server: "
L.DataText.Gold = "Gold"
L.DataText.TotalGold = "Total: "
L.DataText.GoldShort = "|cffffd700g|r"
L.DataText.SilverShort = "|cffc7c7cfs|r"
L.DataText.CopperShort = "|cffeda55fc|r"
L.DataText.Talents = "Talents"
L.DataText.NoTalent = "No Talents"
L.DataText.Download = "Download: "
L.DataText.Bandwidth = "Bandwidth: "
L.DataText.Guild = "Guild"
L.DataText.NoGuild = "No Guild"
L.DataText.Bags = "Bags"
L.DataText.BagSlots = "Bags Slots"
L.DataText.Friends = "Friends"
L.DataText.Online = "Online: "
L.DataText.Armor = "Armor"
L.DataText.Durability = "Durability"
L.DataText.TimeTo = "Time to"
L.DataText.FriendsList = "Friends list:"
L.DataText.Spell = "SP"
L.DataText.AttackPower = "AP"
L.DataText.Haste = "Haste"
L.DataText.DPS = "DPS"
L.DataText.HPS = "HPS"
L.DataText.Session = "Session: "
L.DataText.Character = "Character: "
L.DataText.Server = "Server: "
L.DataText.Total = "Total: "
L.DataText.SavedRaid = "Saved Raid(s)"
L.DataText.Currency = "Currency"
L.DataText.FPS = "FPS &"
L.DataText.MS = "MS"
L.DataText.FPSAndMS = "FPS & MS"
L.DataText.Critical = " Crit"
L.DataText.Heal = " Heal"
L.DataText.Time = "Time"
L.DataText.ServerTime = "Server Time: "
L.DataText.LocalTime = "Local Time: "
L.DataText.Mitigation = "Mitigation By Level: "
L.DataText.Healing = "Healing: "
L.DataText.Damage = "Damage: "
L.DataText.Honor = "Honor: "
L.DataText.KillingBlow = "Killing Blows: "
L.DataText.StatsFor = "Stats for "
L.DataText.HonorableKill = "Honorable Kills:"
L.DataText.Death = "Deaths:"
L.DataText.HonorGained = "Honor Gained:"
L.DataText.DamageDone = "Damage Done:"
L.DataText.HealingDone = "Healing Done:"
L.DataText.BaseAssault = "Bases Assaulted:"
L.DataText.BaseDefend = "Bases Defended:"
L.DataText.TowerAssault = "Towers Assaulted:"
L.DataText.TowerDefend = "Towers Defended:"
L.DataText.FlagCapture = "Flags Captured:"
L.DataText.FlagReturn = "Flags Returned:"
L.DataText.GraveyardAssault = "Graveyards Assaulted:"
L.DataText.GraveyardDefend = "Graveyards Defended:"
L.DataText.DemolisherDestroy = "Demolishers Destroyed:"
L.DataText.GateDestroy = "Gates Destroyed:"
L.DataText.TotalMemory = "Total Memory Usage:"
L.DataText.ControlBy = "Controlled by:"
L.DataText.CallToArms = "Call to Arms"
L.DataText.ArmError = "Could not get Call To Arms information."
L.DataText.NoDungeonArm = "No dungeons are currently offering a Call To Arms."
L.DataText.CartControl = "Carts Controlled:"
L.DataText.VictoryPts = "Victory Points:"
L.DataText.OrbPossession = "Orb Possessions:"
L.DataText.Slots = {
	[1] = {1, "Head", 1000},
	[2] = {3, "Shoulder", 1000},
	[3] = {5, "Chest", 1000},
	[4] = {6, "Waist", 1000},
	[5] = {9, "Wrist", 1000},
	[6] = {10, "Hands", 1000},
	[7] = {7, "Legs", 1000},
	[8] = {8, "Feet", 1000},
	[9] = {16, "Main Hand", 1000},
	[10] = {17, "Off Hand", 1000},
	[11] = {18, "Ranged", 1000}
}
