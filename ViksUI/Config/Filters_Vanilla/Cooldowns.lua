local T, C, L = unpack(ViksUI)

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Rebirth -> http://www.wowhead.com/spell=20484
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
if C.raidcooldown.enable == true then
	T.raid_spells = {
		-- Battle resurrection
		{20484, 1800},	-- Rebirth (1800sec base / -600sec from 5pc AQ Set)
		{20707, 1800},	-- Soulstone Resurrection
		{27740, 3600},	-- Reincarnation (3600sec base / -1200sec from talents / -600sec for Totem)
		-- Jumper Cables
		-- {8342, 1800},	-- Goblin Jumper Cables
		-- {22999, 1800},	-- Goblin Jumper Cables XL
		-- Healing
		{740, 300},		-- Tranquility (300sec base / -150sec from 8pc T1)
		{724, 600},		-- Lightwell
		{409324, 120},	-- Ancestral Guidance [Season of Discovery]
		-- Defense
		{428713, 60},	-- Barkskin [Season of Discovery]
		{408024, 180},	-- Survival Instincts [Season of Discovery]
		{1022, 300},	-- Blessing of Protection (300sec base / -120sec from talents)
		{498, 300},		-- Divine Protection
		{407804, 120},	-- Divine Sacrifice [Season of Discovery]
		{633, 3600},	-- Lay on Hands (3600sec base / -1200sec from talents / -720sec from 4pc T3)
		{425294, 120},	-- Dispersion [Season of Discovery]
		{402004, 180},	-- Pain Suppression [Season of Discovery]
		{425207, 180},	-- Power Word: Barrier [Season of Discovery]
		{426195, 180},	-- Vengeance [Season of Discovery]
		{871, 1800},	-- Shield Wall
		{12975, 600},	-- Last Stand
		-- Taunts
		{5209, 600},	-- Challenging Roar
		{1161, 600},	-- Challenging Shout
		{694, 120},		-- Mocking Blow
		-- Mana Regeneration
		{29166, 360},	-- Innervate
		{16190, 300},	-- Mana Tide Totem
		-- Other
		{6346, 30},		-- Fear Ward
		{10060, 180},	-- Power Infusion
	}

	if #C.raidcooldown.spells_list > 0 then
		T.raid_spells = C.raidcooldown.spells_list
	else
		if C.options.raidcooldown and C.options.raidcooldown.spells_list then
			C.options.raidcooldown.spells_list = nil
		end
	end
	T.RaidSpells = {}
	for _, spell in pairs(T.raid_spells) do
		T.RaidSpells[spell[1]] = spell[2]
	end
end

if C.enemycooldown.enable == true then
	T.enemy_spells = {
		-- Interrupts and Silences
		{410176, 10},	-- Skull Bash [Season of Discovery]
		{2139, 30},		-- Counterspell (24sec base / -2sec from ZG neck)
		{425609, 10},	-- Rebuke [Season of Discovery]
		{15487, 45},	-- Silence
		{1766, 10},		-- Kick (10sec base / -0.5sec from ZG neck)
		{8042, 5},		-- Earth Shock (6sec base / -1sec from talents)
		{19244, 30},	-- Spell Lock (Felhunter)
		{6552, 10},		-- Pummel
		-- Crowd Controls
		{1499, 15},		-- Freezing Trap
		{19503, 30},	-- Scatter Shot
		{19386, 120},	-- Wyvern Sting
		{11113, 45},	-- Blast Wave
		{853, 45},		-- Hammer of Justice (60sec base / -10sec from 4pc PvP / -15sec from talents)
		{20066, 60},	-- Repentance
		{6789, 120},	-- Death Coil (120sec base / -18sec from 5pc ZG Set)
		{8122, 26},		-- Psychic Scream (30sec base / -4sec from talents)
		{2094, 210},	-- Blind (300sec base / -90sec from talents)
		{5484, 40},		-- Howl of Terror
		{12809, 45},	-- Concussion Blow
		-- Defense abilities
		{22812, 60},	-- Barkskin
		{428713, 60},	-- Barkskin [Season of Discovery]
		{408024, 180},	-- Survival Instincts [Season of Discovery]
		{19263, 300},	-- Deterrence
		{11958, 300},	-- Ice Block
		{1044, 14},		-- Blessing of Freedom (20sec base / -6sec from talents)
		{1022, 180},	-- Blessing of Protection (300sec base / -120sec from talents)
		{498, 300},		-- Divine Protection
		{642, 300},		-- Divine Shield
		{6346, 30},		-- Fear Ward
		{402004, 180},	-- Pain Suppression [Season of Discovery]
		{425207, 180},	-- Power Word: Barrier [Season of Discovery]
		{426490, 180},	-- Rallying Cry [Season of Discovery]
		{5277, 210},	-- Evasion (300sec base / -90sec from talents / -60sec from 3pc AQ Set)
		{424919, 20},	-- Main Gauche [Season of Discovery]
		{1856, 210},	-- Vanish (300sec base / -90sec from talents / -30sec from 3pc T1)
		-- {8178, 13},	-- Grounding Totem Effect (15sec base / -2sec from talents)
		{425463, 20},	-- Demonic Grace [Season of Discovery]
		{18499, 30},	-- Berserker Rage
		{12328, 180},	-- Death Wish
		{20600, 180},	-- Perception
		{20594, 180},	-- Stoneform
		{7744, 120},	-- Will of the Forsaken
		-- Heals
		-- Disarms
		{409495, 60},	-- Chimera Shot - Scorpid [Season of Discovery]
		-- {14251, 6},		-- Riposte
		{676, 60},		-- Disarm
		-- Mana Regeneration
		{29166, 360},	-- Innervate
		{16190, 300},	-- Mana Tide Totem
		-- Trinket (TEMPORARY)
		{23277, 300},	-- PvP Trinket (Druid)
		{5579, 300},	-- PvP Trinket (Hunter/Shaman/Warrior)
		{23274, 300},	-- PvP Trinket (Mage)
		{23276, 300},	-- PvP Trinket (Paladin/Priest)
		{23273, 300},	-- PvP Trinket (Rogue/Warlock)
	}

	if #C.enemycooldown.spells_list > 0 then
		T.enemy_spells = C.enemycooldown.spells_list
	else
		if C.options.enemycooldown and C.options.enemycooldown.spells_list then
			C.options.enemycooldown.spells_list = nil
		end
	end
	T.EnemySpells = {}
	for _, spell in pairs(T.enemy_spells) do
		T.EnemySpells[spell[1]] = spell[2]
	end
end

if C.pulsecooldown.enable == true then
	local function SpellName(id)
		local name = GetSpellInfo(id)
		if name then
			return name
		else
			print("|cffff0000ViksUI: Pulse cooldown spell ID ["..tostring(id).."] no longer exists!|r")
			return "Empty"
		end
	end

	T.pulse_ignored_spells = {
		-- SpellName(spellID),	-- Spell name
	}
	for _, spell in pairs(C.pulsecooldown.spells_list) do
		T.pulse_ignored_spells[SpellName(spell)] = true
	end
end
