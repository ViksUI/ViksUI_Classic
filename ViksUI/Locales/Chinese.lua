local T, C, L = unpack(ViksUI)
if T.client ~= "zhCN" then return end

----------------------------------------------------------------------------------------
--	Localization for zhCN client
--	Translation: Ianchan, Mania, Nanjiqq, Tat2dawn
----------------------------------------------------------------------------------------
-- Announce flasks and food
L_ANNOUNCE_FF_NOFOOD = "缺少食物: "
L_ANNOUNCE_FF_NOFLASK = "缺少合剂: "
L_ANNOUNCE_FF_ALLBUFFED = "已获得所有增益 !"
L_ANNOUNCE_FF_CHECK_BUTTON = "检查食物和合剂"

-- Says thanks for some spells
L_ANNOUNCE_SS_THANKS = "谢谢你的 "
L_ANNOUNCE_SS_RECEIVED = " 收到来自于 "

-- Pull countdown announce
L_ANNOUNCE_PC_GO = "开始 !"
L_ANNOUNCE_PC_MSG = "准备接怪: %s，倒数 %s.."
L_ANNOUNCE_PC_ABORTED = "取消拉怪 !"

-- Announce feasts and portals
L_ANNOUNCE_FP_STAT = "%s 放置了 %s - [%s]。"
L_ANNOUNCE_FP_PRE = "%s 放置了 %s"
L_ANNOUNCE_FP_PUT = "%s 放置了 %s"
L_ANNOUNCE_FP_CAST = "%s 开启了 %s"
L_ANNOUNCE_FP_CLICK = "%s 正在开启 %s... 请点击 !"
L_ANNOUNCE_FP_USE = "%s 使用了 %s。"

-- Announce your interrupts
L_ANNOUNCE_INTERRUPTED = "已打断"

-- Tooltip
L_TOOLTIP_NO_TALENT = "没有天赋"
L_TOOLTIP_LOADING = "读取中..."
L_TOOLTIP_ACH_STATUS = "你的状态: "
L_TOOLTIP_ACH_COMPLETE = "你的状态: 完成"
L_TOOLTIP_ACH_INCOMPLETE = "你的状态: 未完成"
L_TOOLTIP_SPELL_ID = "法术ID: "
L_TOOLTIP_ITEM_ID = "物品ID: "
L_TOOLTIP_WHO_TARGET = "关注"
L_TOOLTIP_ITEM_COUNT = "物品数量: "
L_TOOLTIP_INSPECT_OPEN = "检查框体已开启"

-- Misc
L_MISC_UNDRESS = "无装备"
L_MISC_DRINKING = " 进食中..."
L_MISC_BUY_STACK = "Alt+右键批量购买"
L_MISC_ONECLICK_BUYOUT = "Shift+右键 不弹出确认框体直接购买"
L_MISC_ONECLICK_BID = "Shift+右鍵 不弹出确认框体直接竞标"
L_MISC_ONECLICK_CANCEL = "Shift+右键 不弹出确认框体直接取消选择的物品"
L_MISC_UI_OUTDATED = "ViksUI 版本已过期，请至 http://goo.gl/QAj0J6 下载最新版。"
L_MISC_HEADER_MARK = "鼠标悬停显示团队图标"
L_MISC_BINDER_OPEN = "鼠标绑定"
L_MISC_GROCERY_BUY = "购买"
L_MISC_GROCERY_DESC = "杂货商自动购买"
L_MISC_SCROLL = "附魔羊皮纸"
L_MISC_COLLAPSE = "The Collapse" -- Need review
L_MISC_HEADER_QUEST = "Auto quest button" -- Needs review

-- Raid Utility
L_RAID_UTIL_DISBAND = "解散团队"

-- Zone name
L_ZONE_TOLBARAD = "托尔巴拉德"
L_ZONE_TOLBARADPEN = "托尔巴拉德半岛"
L_ZONE_ARATHIBASIN = "阿拉希盆地"
L_ZONE_GILNEAS = "吉尔尼斯之战"
L_ZONE_ANCIENTDALARAN = "达拉然巨坑"

-- WatchFrame Wowhead link
L_WATCH_WOWHEAD_LINK = "Wowhead链接"

-- Toggle Menu
L_TOGGLE_ADDON = "插件 "
L_TOGGLE_ADDONS = " 插件系列"
L_TOGGLE_EXPAND = "展开 "
L_TOGGLE_COLLAPSE = "折叠 "
L_TOGGLE_RCLICK = "右键 启用/禁用 "
L_TOGGLE_LCLICK = "左键 显示/隐藏窗口 "
L_TOGGLE_RELOAD = " (需要重载插件)"
L_TOGGLE_NOT_FOUND = " 未创建"

-- UnitFrame
L_UF_GHOST = "灵魂"
L_UF_DEAD = "死亡"
L_UF_OFFLINE = "离线"
L_UF_MANA = "低法力值"

-- Map
L_MAP_CURSOR = "指针: "
L_MAP_BOUNDS = "超出范围 !"
L_MAP_FOG = "地图全亮"
L_MAP_COORDS = "坐标"

-- Minimap
L_MINIMAP_CALENDAR = "日历"
L_MINIMAP_HEAL_LAYOUT = "左鍵 - HPS 布局"
L_MINIMAP_DPS_LAYOUT = "右键 - DPS 布局"
L_MINIMAP_BLIZZ_LAYOUT = "中键 - 暴雪 布局"
L_MINIMAP_FARM = "小地图大小"
L_MINIMAP_TOGGLE = "动作条自由折叠"							  								  

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
L_CHAT_COME_ONLINE = "|cff298F00上线了|r"
L_CHAT_GONE_OFFLINE = "|cffff0000下线了|r"

-- Errors frame
L_ERRORFRAME_L = "点击查看错误"

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
L_BAG_SHOW_BAGS = "显示背包"
L_BAG_SORTING_BAGS = "Sorting finished."
L_BAG_NOTHING_SORT = "Nothing to sort."
L_BAG_BAGS_BIDS = "Using bags: "
L_BAG_STACK_END = "Restacking finished."
L_BAG_RIGHT_CLICK_SEARCH = "右键搜寻物品"
L_BAG_STACK_MENU = "堆叠"
L_BAG_BUTTONS_DEPOSIT = "Deposit Reagents"
L_BAG_BUTTONS_SORT = "LM:Cleanup / RM:Blizzard"
L_BAG_BUTTONS_ARTIFACT = "Right click to use Artifact Power item in bag"
L_BAG_RIGHT_CLICK_CLOSE = "右键开启菜单"

-- Grab mail
L_MAIL_STOPPED = "无法拾取，背包已满。"
L_MAIL_UNIQUE = "中止，在背包或银行发现重复的唯一物品。"
L_MAIL_COMPLETE = "完成"
L_MAIL_NEED = "需要信箱"
L_MAIL_MESSAGES = "新邮件"

-- Loot
L_LOOT_RANDOM = "随机拾取"
L_LOOT_SELF = "个人拾取"
L_LOOT_FISH = "钓鱼拾取"
L_LOOT_ANNOUNCE = "向频道通告"
L_LOOT_TO_RAID = "  团队"
L_LOOT_TO_PARTY = "  队伍"
L_LOOT_TO_GUILD = "  公会"
L_LOOT_TO_SAY = "  说"

-- LitePanels AFK module
L_PANELS_AFK = "正处于暂离状态 !"
L_PANELS_AFK_RCLICK = "右键隐藏"
L_PANELS_AFK_LCLICK = "左键脱离暂离状态"

-- Cooldowns
L_COOLDOWNS = "CD: "
L_COOLDOWNS_COMBATRESS = "战复"
L_COOLDOWNS_COMBATRESS_REMAINDER = "战复剩余: "
L_COOLDOWNS_NEXTTIME = "下次: "

-- Autoinvite
L_INVITE_ENABLE = "自动邀请已启用 关键词: "
L_INVITE_DISABLE = "自动邀请已关闭"

-- Bind key
L_BIND_SAVED = "快捷键设置已保存"
L_BIND_DISCARD = "新的快捷键设置已撤消"
L_BIND_INSTRUCT = "将鼠标悬停至任意快捷键进行绑定。按Esc或者右键清除当前快捷键的按键绑定。"
L_BIND_CLEARED = "已清除所有快捷键设置"
L_BIND_BINDING = "绑定"
L_BIND_KEY = "按键"
L_BIND_NO_SET = "没有绑定快捷键"

-- Info text
L_INFO_ERRORS = "目前没有错误"
L_INFO_INVITE = "接受邀请"
L_INFO_DUEL = "拒绝决斗请求"
L_INFO_PET_DUEL = "拒绝宠物对战请求"
L_INFO_DISBAND = "解散队伍..."
L_INFO_SETTINGS_DBM = "键入 /settings dbm 载入 DBM 的设定"
L_INFO_SETTINGS_BIGWIGS = "键入 /settings bw 载入 BigWigs 的设定"
L_INFO_SETTINGS_MSBT = "键入 /settings msbt 载入 MSBT 的设定"
L_INFO_SETTINGS_SKADA = "键入 /settings skada 载入 Skada 的设定"
L_INFO_SETTINGS_CHAT = "Type /settings chat, to apply the default chat settings."
L_INFO_SETTINGS_CVAR = "Type /settings cvar, to apply the default cvar(Game UI) settings."
L_INFO_SETTINGS_ALL = "键入 /settings all 载入所有UI设定"
L_INFO_NOT_INSTALLED = " 没有安装"
L_INFO_SKIN_DISABLED1 = "界面美化启用"
L_INFO_SKIN_DISABLED2 = " 已禁用"

-- Moving elements
L_MOVE_RIGHT_CLICK = "右键重置位置"
L_MOVE_MIDDLE_CLICK = "中键临时隐藏"

-- Popups
L_POPUP_INSTALLUI = "该角色首次使用ViksUI，你必须重新加载UI来配置。"
L_POPUP_RESETUI = "你确定要重新加载ViksUI?"
L_POPUP_RESETSTATS = "你确定要重置所有角色游戏时间和金币的统计数据?"
L_POPUP_SWITCH_RAID = "选择团队布局"
L_POPUP_DISBAND_RAID = "你确定要解散团队?"
L_POPUP_DISABLEUI = "ViksUI不支持此分辨率，是否停用ViksUI? (若要尝试其他分辨率请按取消)"
L_POPUP_SETTINGS_ALL = "套用所有插件设置?(DBM/BigWigs/Skada/MSBT)"
L_POPUP_SETTINGS_DBM = "需要改变DBM锚点及样式元素"
L_POPUP_SETTINGS_BW = "需要改变BigWigs锚点及样式元素"
L_POPUP_ARMORY = "英雄榜"
L_POPUP_CURRENCY_CAP = "你拥有的最高级货币为"

-- Welcome message
L_WELCOME_LINE_1 = "欢迎使用ViksUI "
L_WELCOME_LINE_2_1 = "键入 /cfg 进行插件设置, 或者访问https://discord.gg/Dhp5nHh"
L_WELCOME_LINE_2_2 = "获取更多信息。"

-- Combat text
L_COMBATTEXT_KILLING_BLOW = "最后一击"
L_COMBATTEXT_TEST_DISABLED = "战斗信息测试模式已禁用"
L_COMBATTEXT_TEST_ENABLED = "战斗信息测试模式已启用"
L_COMBATTEXT_TEST_USE_MOVE = "键入 /xct move 移动/调整战斗信息框架大小"
L_COMBATTEXT_TEST_USE_TEST = "键入 /xct test 启用/禁用战斗信息测试模式"
L_COMBATTEXT_TEST_USE_RESET = "键入 /xct reset 恢复到初始位置"
L_COMBATTEXT_POPUP = "保存战斗信息窗口的位置须重载插件"
L_COMBATTEXT_UNSAVED = "战斗信息窗口位置尚未保存，不要忘记重新载入插件。"
L_COMBATTEXT_UNLOCKED = "战斗信息已解锁"

-- LiteStats
L_STATS_ACC_PLAYED = "帐号启用总时间"
L_STATS_ADDED_JUNK = "增加自动出售例外名单"
L_STATS_REMOVE_EXCEPTION = "新增/移除例外名单"
L_STATS_AUTO_REPAIR = "自动修装"
L_STATS_GUILD_REPAIR = "公会银行修装"
L_STATS_AUTO_SELL = "自动出售灰色物品"
L_STATS_BANDWIDTH = "宽带占用:"
L_STATS_DOWNLOAD = "下载:"
L_STATS_CLEARED_JUNK = "清除自动出售例外名单列表"
L_STATS_CLEAR_EXCEPTIONS = "清除例外名单列表"
L_STATS_CURRENCY_RAID = "副本徽记"
L_STATS_WORLD_MAP = "点击开启世界地图"
L_STATS_CURRENT_XP = "当前/升级所需经验值"
L_STATS_MEMORY_USAGE = "插件内存占用:"
L_STATS_GARBAGE_COLLECTED = "整理内存"
L_STATS_CHANGE_SORTING = "[公会]右键更改排列方式,Shift+右键反向排列"
L_STATS_HIDDEN = "隐藏"
L_STATS_JUNK_ALREADY_ADDITIONS = "已加入自动出售名单"
L_STATS_JUNK_ITEMLINK = "物品链接"
L_STATS_JUNK_ADDITIONS = "自动出售名单"
L_STATS_JUNK_LIST = "自动出售常用命令"
L_STATS_JUNK_PROFIT = "自动出售所得金额"
L_STATS_JUNK_CLEARED = "自动出售名单已清除"
L_STATS_JUNK_CLEAR_ADDITIONS = "清除自动出售名单"
L_STATS_JUNK_ADDED = "自动出售 - 已加入"
L_STATS_JUNK_ADD_ITEM = "增加/移除 物品"
L_STATS_JUNK_REMOVED = "自动出售 - 已移除"
L_STATS_JUNK_ITEMS_LIST = "列出自动出售名单"
L_STATS_KILLS = "击杀"
L_STATS_OPEN_CALENDAR = "左键开启日历"
L_STATS_OPEN_CHARACTER = "左键开启角色面板"
L_STATS_OPEN_CURRENCY = "左键单击开启货币面板."
L_STATS_OPEN_TALENT = "左键开启天赋面板"
L_STATS_XP_RATE = "当前等级经验百分值"
L_STATS_HR = "小时"
L_STATS_INF = "无限"
L_STATS_ON = "启用"
L_STATS_PLAYED_LEVEL = "当前等级总在线时间"
L_STATS_PLAYED_SESSION = "此次在线时长"
L_STATS_ACC_PLAYED = "帐号启用总时间"
L_STATS_PLAYED_TOTAL = "总在线时长"
L_STATS_QUEST = "任务"
L_STATS_QUESTS_TO = "任务/杀怪得到经验值 %s"
L_STATS_CURRENT_XP = "当前/升级所需经验值"
L_STATS_REMAINING_XP = "升级尚需经验值"
L_STATS_REMOVED_JUNK = "移除自动出售例外名单"
L_STATS_RESTED_XP = "休息奖励经验值"
L_STATS_RC_COLLECTS_GARBAGE = "右键点击整理内存"
L_STATS_RC_TIME_MANAGER = "右键开启计时器"
L_STATS_RC_EXPERIENCE = "右键切换经验值/在线时间/角色信息显示"
L_STATS_RC_AUTO_REPAIRING = "右键显示自动修装"
L_STATS_RC_AUTO_SELLING = "右键开启自动出售"
L_STATS_RC_TALENT = "右键切换天赋"
L_STATS_SERVER_GOLD = "帐号总现金"
L_STATS_SESSION_GAIN = "此次在线时段获得/损失金额"
L_STATS_SESSION_XP = "此次在线时段所得经验值"
L_STATS_SORTING_BY = "排列方式: "
L_STATS_SEALS = "本周已领徽记"
L_STATS_SPEC = "专精"
L_STATS_TIPS = "提示: "
L_STATS_OPEN_CALENDAR = "左键开/关日历"
L_STATS_RC_TIME_MANAGER = "右键开/关计时器"
L_STATS_TOGGLE_TIME = "本地/服务器及24小时制可于计时器中设置"
L_STATS_MEMORY = "内存"
L_STATS_RC_COLLECTS_GARBAGE = "帧数模块上鼠标悬停显示，右键整理内存"
L_STATS_VIEW_NOTES = "按住Alt键检视: 好友的所在地 公会成员的会阶/注记/干部注记"
L_STATS_CHANGE_SORTING = "[公会]右键密语/邀请，中键更改排列方式，Shift+中键反转排序"
L_STATS_OPEN_CHARACTER = "左键开/关角色界面"
L_STATS_RC_AUTO_REPAIRING1 = "右键开/关自动修装"
L_STATS_RC_AUTO_REPAIRING2 = "中键开/关公会修装"
L_STATS_EQUIPMENT_CHANGER = "Shift+左键或Alt+左键开启套装选单"
L_STATS_RC_EXPERIENCE = "右键切换在线时间/神器信息/经验值/声望值"
L_STATS_WATCH_FACTIONS = "左键开/关相关界面"
L_STATS_TOOLTIP_EXPERIENCE = "未达最高等级时将优先显示经验值信息"
L_STATS_TOOLTIP_TIME_PLAYED = "达到最高等级后将优先显示角色在线时间"
L_STATS_OPEN_TALENT = "左键开启专精选单，Shift+左键开启专精界面"
L_STATS_RC_TALENT = "右键开启拾取专精选单"
L_STATS_LOCATION = "位置/座标"
L_STATS_WORLD_MAP = "点击开/关世界地图"
L_STATS_INSERTS_COORDS = "Shift+左键地名/座标自动复制到输入框"
L_STATS_OPEN_CURRENCY = "左键开/关货币界面"
L_STATS_RC_AUTO_SELLING = "右键开/关自动出售"
L_STATS_NEED_TO_SELL = "键入 /junk 列出常用命令"
L_STATS_WATCH_CURRENCY = "在货币界面已选定的货币将在金幣提示信息中显示"
L_STATS_OTHER_OPTIONS = "其它选项可以在这里设置: %s"

-- Slash commands
L_SLASHCMD_HELP = {
	"可用的命令: ",
	"/rl or // - 重载界面",
	"/rc - 就位确认",
	"/gm - 开启GM界面",
	"/dis ADDON_NAME - 禁用指定插件",
	"/en ADDON_NAME - 启用指定插件",
	"/rd - 解散队伍",
	"/toraid - 转换为队伍/团队",
	"/teleport - 传送随机副本",
	"/ss - 切换天赋",
	"/tt - 密语当前目标",
	"/heal - 载入HPS布局",
	"/dps - 载入DPS布局",
	"/frame - 在聊天窗口输出鼠标指向的框体的名字",
	"/farmmode - 开启/关闭小地图采集模式",
	"/resetui - 重置一般设置到初始值",
	"/resetuf - 重置头像框架到初始位置",
	"/resetconfig - 重置Viks_ConfigUI到初始值",
	"/resetstats - 重置所有角色游戏时间和金币的统计数据",
	"/settings - 设置指定插件",
	"/ls - 信息条功能说明",
	"/xct - 战斗信息选项",
	"/raidcd - 团队技能冷却测试模式",
	"/enemycd - 敌对技能冷却测试模式",
	"/pulsecd - 技能冷却闪烁测试模式",
	"/threat - 仇恨栏測試模式",
	"/testuf - 头像框架测试模式",
	"/moveui - 解锁/锁定 界面中所有可移动的框体，Ctrl+右键选中的框架重置到预设位置", -- Need review
	"/cfg - 开启ViksUI设置界面",
	"/installui - Opens installer.",
	"/vbt - Opens Bartender Select Profile.",
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
