local T, C, L = unpack(ViksUI)
if C.automation.accept_quest ~= true then return end

----------------------------------------------------------------------------------------
--	Quest automation (QuickQuest by p3lim) for WoW Classic: Mists of Pandaria API
----------------------------------------------------------------------------------------
local _, ns = ...
local QuickQuestDB = {
	general = {
		share = false,
		skipgossip = true,
		skipgossipwhen = 1,
		paydarkmoonfaire = true,
		pausekey = 'SHIFT',
		pausekeyreverse = false,
	},
	blocklist = {
		items = {
			-- Inscription weapons
			[79343] = true, -- Inscribed Tiger Staff
			[79340] = true, -- Inscribed Crane Staff
			[79341] = true, -- Inscribed Serpent Staff

			-- Darkmoon Faire artifacts
			[71635] = true, -- Imbued Crystal
			[71636] = true, -- Monstrous Egg
			[71637] = true, -- Mysterious Grimoire
			[71638] = true, -- Ornate Weapon
			[71715] = true, -- A Treatise on Strategy
			[71951] = true, -- Banner of the Fallen
			[71952] = true, -- Captured Insignia
			[71953] = true, -- Fallen Adventurer's Journal
			[71716] = true, -- Soothsayer's Runes

			-- Tiller Gifts
			[79264] = true, -- Ruby Shard
			[79265] = true, -- Blue Feather
			[79266] = true, -- Jade Cat
			[79267] = true, -- Lovely Apple
			[79268] = true, -- Marsh Lily

			-- Misc
			[88604] = true, -- Nat's Fishing Journal
		},
		npcs = {
			[103792] = true, -- Griftah
			[143925] = true, -- Dark Iron Mole Machine
		},
		quests = {
			-- Example: [36054] = true, -- Sealing Fate: Gold
		},
	},
}

local EventHandler = CreateFrame('Frame')
EventHandler.events = {}
EventHandler:SetScript('OnEvent', function(self, event, ...)
	self:Trigger(event, ...)
end)

function EventHandler:Register(event, func)
	if not self.events[event] then self.events[event] = {} end
	for _, f in ipairs(self.events[event]) do
		if f == func then return end
	end
	table.insert(self.events[event], func)
	self:RegisterEvent(event)
end

function EventHandler:Unregister(event, func)
	local funcs = self.events[event]
	if not funcs then return end
	for i = #funcs, 1, -1 do
		if funcs[i] == func then
			table.remove(funcs, i)
		end
	end
	if #funcs == 0 then
		self:UnregisterEvent(event)
	end
end

function EventHandler:Trigger(event, ...)
	local funcs = self.events[event]
	if funcs then
		for _, func in ipairs(funcs) do
			func(...)
		end
	end
end

ns.EventHandler = EventHandler

-- Utility: Get NPC ID for MoP Classic
local NPC_ID_PATTERN = "Creature%-.-%-.-%-.-%-.-%-(.-)$"
function ns.GetNPCID(unit)
	local guid = UnitGUID(unit or "npc")
	if guid then
		local id = guid:match(NPC_ID_PATTERN)
		if id then return tonumber(id) end
	end
end

function ns.ShouldAcceptTrivialQuests()
	-- For MoP Classic, check if trivial quests are being tracked
	for i=1, GetNumTrackingTypes() do
		local name, _, active = GetTrackingInfo(i)
		-- "Trivial Quests" tracking name is localized
		if name == MINIMAP_TRACKING_TRIVIAL_QUESTS then
			return active
		end
	end
end

function ns.tLength(t)
	local n = 0
	for _ in pairs(t) do n = n + 1 end
	return n
end

local paused = false

-- Blocked Quest Logic
local function IsQuestIgnored(questID)
	if not questID then return false end
	if QuickQuestDB.blocklist.quests[questID] then return true end
	if ns.ignoredQuests and ns.ignoredQuests[questID] then return true end
	return false
end

-- GOSSIP_SHOW: Accept/Turn-In logic
EventHandler:Register("GOSSIP_SHOW", function()
	if paused then return end
	local npcID = ns.GetNPCID()
	if QuickQuestDB.blocklist.npcs[npcID] then return end

	-- Check which API is available
	local GetGossipActiveQuests = _G.GetGossipActiveQuests
	local GetGossipAvailableQuests = _G.GetGossipAvailableQuests
	local GetNumGossipActiveQuests = _G.GetNumGossipActiveQuests
	local GetNumGossipAvailableQuests = _G.GetNumGossipAvailableQuests

	if type(GetGossipActiveQuests) == "function" then
		local activeQuests = {GetGossipActiveQuests()}
		for i = 1, #activeQuests, 6 do
			local isComplete = activeQuests[i+3]
			local questID = activeQuests[i+6]
			if isComplete and not IsQuestIgnored(questID) then
				SelectGossipActiveQuest((i-1)/6+1)
			end
		end

		local availableQuests = {GetGossipAvailableQuests()}
		for i = 1, #availableQuests, 7 do
			local isTrivial = availableQuests[i+3]
			local questID = availableQuests[i+7]
			if (not isTrivial or ns.ShouldAcceptTrivialQuests()) and not IsQuestIgnored(questID) then
				SelectGossipAvailableQuest((i-1)/7+1)
			end
		end
	else
		-- fallback: no gossip functions? Nothing to do
		-- or you could print a warning here
		return
	end

	-- Optionally skip single gossip option
	if QuickQuestDB.general.skipgossip then
		local numOptions = GetNumGossipOptions and GetNumGossipOptions() or 0
		if numOptions == 1 then
			SelectGossipOption(1)
		end
	end
end)

-- QUEST_GREETING: Accept/Turn-In logic
EventHandler:Register("QUEST_GREETING", function()
	if paused then return end
	local npcID = ns.GetNPCID()
	if QuickQuestDB.blocklist.npcs[npcID] then return end

	-- Turn in all completed quests
	for i=1, GetNumActiveQuests() do
		local name, isComplete = GetActiveTitle(i)
		if isComplete and not IsQuestIgnored(GetActiveQuestID(i)) then
			SelectActiveQuest(i)
		end
	end

	-- Accept all available quests
	for i=1, GetNumAvailableQuests() do
		local isTrivial, _, _, _, questID = GetAvailableQuestInfo(i)
		if (not isTrivial or ns.ShouldAcceptTrivialQuests()) and not IsQuestIgnored(questID) then
			SelectAvailableQuest(i)
		end
	end
end)

-- QUEST_DETAIL: Accept or ignore quest
EventHandler:Register("QUEST_DETAIL", function()
	if paused then return end
	local questID = GetQuestID()
	if IsQuestIgnored(questID) then
		CloseQuest()
	else
		AcceptQuest()
	end
end)

-- QUEST_PROGRESS: Complete quest
EventHandler:Register("QUEST_PROGRESS", function()
	if paused then return end
	if not IsQuestCompletable() then return end

	-- Block logic for required quest items
	for i=1, GetNumQuestItems() do
		local link = GetQuestItemLink("required", i)
		if link then
			local itemID = tonumber(link:match("item:(%d+)"))
			if QuickQuestDB.blocklist.items[itemID] then
				ns.ignoredQuests = ns.ignoredQuests or {}
				ns.ignoredQuests[GetQuestID()] = true
				CloseQuest()
				return
			end
		end
	end

	CompleteQuest()
end)

-- QUEST_COMPLETE: Pick quest reward
EventHandler:Register("QUEST_COMPLETE", function()
	if paused then return end
	local nChoices = GetNumQuestChoices()
	if nChoices <= 1 then
		GetQuestReward(1)
	else
		local bestValue, bestIdx = 0, 1
		for i=1, nChoices do
			local link = GetQuestItemLink("choice", i)
			if link then
				local _, _, _, _, _, _, _, _, _, _, value = GetItemInfo(link)
				if value and value > bestValue then
					bestValue = value
					bestIdx = i
				end
			end
		end
		GetQuestReward(bestIdx)
	end
end)

-- QUEST_ACCEPT_CONFIRM: Auto-accept shared quests
EventHandler:Register("QUEST_ACCEPT_CONFIRM", function()
	if paused then return end
	ConfirmAcceptQuest()
end)

-- MODIFIER_STATE_CHANGED: Pause automation with key
EventHandler:Register("MODIFIER_STATE_CHANGED", function(key, state)
	if key == QuickQuestDB.general.pausekey then
		if QuickQuestDB.general.pausekeyreverse then
			paused = state ~= 1
		else
			paused = state == 1
		end
	end
end)

EventHandler:Register("PLAYER_LOGIN", function()
	if QuickQuestDB.general.pausekeyreverse then
		paused = true
	end
end)