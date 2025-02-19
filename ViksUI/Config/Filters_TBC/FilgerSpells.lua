local T, C, L = unpack(ViksUI)
if C.unitframe.enable ~= true or C.filger.enable ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Renew -> http://www.wowhead.com/spell=139
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------

--[[
How to add Abilities in Filger For Dummies (https://web.archive.org/web/20210305093450/http://shestak.org/forum/showthread.php?t=126)

What is filger???? Filger creates icons/bars for aura tracking which appear on screen, like so (https://web.archive.org/web/20160627223910/http://shestak.org/forum/picture.php?albumid=9&pictureid=44).


In order to add a aura to Filger, you need to:

	1. Ask yourself: "Do I need this?"
	2. Open the ViksUI/Config/Filters/FilgerSpells.lua file (see notes)
	3. Determine the type of missing aura:
		1. Player applied buffs on self (P_BUFF_ICON)
		2. Proc-based buffs (enchants/talents/accessories/etc.) on self (P_PROC_ICON)
		3. Player applied buffs/debuffs on target (T_DEBUFF_ICON)
		4. Player applied HoTs/DoTs on target (T_DE/BUFF_BAR)
		5. Player applied CC on focus (PVE/PVP_CC)
		6. Player ability cooldowns (COOLDOWN)
		7. Consumable based (items/potions/etc.) on self (SPECIAL_P_BUFF_ICON)
		8. Enemy applied CC and root/slowing effects on self (PVE / PVP_DEBUFF)
		9. Important defensive abilities or CC on the target (from all sources) (T_BUFF)
	4. If the aura belongs to groups 1-6, you need:
		1. Find a section for your class in the file.
		2. Find the sub-section corresponding to the aura type (section names list above in brackets).
	5. If the aura belongs to groups 7-9, you need:
		1. Find the section near the end (after ALL the classes) in the file.
		2. Find the sub-section corresponding to the aura type (section names list above in brackets).
	6. Ensure that the aura you'd like to track actually exists and isn't already being tracked.
	7. Find out the spell ID. For this you can:
		1. In the ViksUI configuration, navigate to the tooltips section and enable spell IDs on toooltips. Once applied, hver your mouse over an ability on your action bar or spellbook an reference the tooltip.
		2. Look up the spell ID in a database like Wowhead and copy the numbers from the URL (see: spell=).
	8. Add the desired aura, referencing existing entries to ensure proper format. See the notes for further information.
	9. ...
	10. PROFIT!

Note 1: Description of the contents of a single cell with a spell
	A simple aura tracking (in this case a DoT on the target).
		-- Vampiric Touch		-- 1
		{
			spellID = 34914,	-- 2
			unitId = "target",	-- 3
			caster = "player",	-- 4
			filter = "DEBUFF",	-- 5
			absID = true,		-- 6
			count = 2			-- 7
		},

		1.	Spell name
		2.	Spell ID
		3.	Unit to track (player / target / focus)
		4.	Unit who applied the aura (player / target / focus / all)
			Restrospectively:
				player - the player
				target - the player's target
				foocus - the player's focus target
				all    - any source (only usable for "caster")
		5.	Spell tracking type (BUFF / DEBUFF / CD)
		6.	Strict spell name matching (will not trigger off spells with the same name or different ranks)
		7.	The number of stacks required before displaying

	A hidden CD
		-- Power Torrent
		{
			spellID = 74241,	-- 1
			slotID = 16,		-- 2
			filter = "ICD",		-- 3
			trigger = "BUFF",	-- 4
			duration = 45		-- 5
		},
		-- Cauterize
		{
			spellID = 87023,	-- 1
			filter = "ICD",		-- 3
			trigger = "DEBUFF",	-- 4
			duration = 60		-- 5
		},

		1.	ID of buff/debuff to track
		2.	If specified, instead of displaying the aura icon, Filger will display the item's icon by gear slotID.
		3.	Spell tracking type
		4.	Proc type (BUFF / DEBUFF)
		5.	Hidden CD duration

	Active spell without an aura
		-- Summon Gargoyle
		{
			spellID = 49206,	-- 1
			filter = "ICD",		-- 2
			trigger = "NONE",	-- 3
			duration = 40		-- 4
		},

		1.	ID of spell cast
		2.	Spell tracking type (ICD)
		3.	Proc type (NONE)
		4.	Active duration

Note 2: An illustrative example of each section in how it displays on screen.
	https://web.archive.org/web/20160627223910/http://shestak.org/forum/picture.php?albumid=9&pictureid=44


Note: To help facilitatein the above process, it is recommended that you open the .lua file using a decent text editor such as Notepad++ (see example - https://web.archive.org/web/20160627231758/http://shestak.org/forum/picture.php?albumid=9&pictureid=45).

------
-- Ravager
			{spellID = 152277, unitID = "player", caster = "player", filter = "BUFF", spec = 3},
--]]

P_BUFF_ICON_Anchor = CreateFrame("Frame", "P_BUFF_ICON_Anchor", UIParent)
P_PROC_ICON_Anchor = CreateFrame("Frame", "P_PROC_ICON_Anchor", UIParent)
SPECIAL_P_BUFF_ICON_Anchor = CreateFrame("Frame", "SPECIAL_P_BUFF_ICON_Anchor", UIParent)
T_DEBUFF_ICON_Anchor = CreateFrame("Frame", "T_DEBUFF_ICON_Anchor", UIParent)
T_BUFF_Anchor = CreateFrame("Frame", "T_BUFF_Anchor", UIParent)
PVE_PVP_DEBUFF_Anchor = CreateFrame("Frame", "PVE_PVP_DEBUFF_Anchor", UIParent)
PVE_PVP_CC_Anchor = CreateFrame("Frame", "PVE_PVP_CC_Anchor", UIParent)
COOLDOWN_Anchor = CreateFrame("Frame", "COOLDOWN_Anchor", UIParent)
T_DE_BUFF_BAR_Anchor = CreateFrame("Frame", "T_DE_BUFF_BAR_Anchor", UIParent)

C["filger_spells"] = {
	["DRUID"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = 3,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Barkskin
			{spellID = 22812, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dash
			{spellID = 1850, unitID = "player", caster = "player", filter = "BUFF"},
			-- Enrage
			{spellID = 5229, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Frenzied Regeneration
			{spellID = 22842, unitID = "player", caster = "player", filter = "BUFF"},
			-- Natural Perfection
			{spellID = 45281, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nature's Grace
			{spellID = 16886, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nature's Grasp
			{spellID = 16689, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nature's Swiftness
			{spellID = 17116, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tiger's Fury
			{spellID = 5217, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = C.filger.buffs_space,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Buffs
			-- Clearcasting [Omen of Clarity]
			{spellID = 16870, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- Item Sets
			-- Heroic Resolution (Attack Power, Proc) [Desolation Battlegear / Doomplate Battlegear / Wastewalker Armor]
			{spellID = 37612, unitID = "player", caster = "player", filter = "BUFF"},
			-- Insight (Spell Power, Proc) [Mana-Etched Regalia]
			{spellID = 37620, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Lesser Spell Blasting (Spell Power, Proc) [Spellstrike Infusion]
			{spellID = 32108, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mend (Special, Proc) [Nordrassil Regalia]
			{spellID = 37325, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nurture (Special, Proc) [Nordrassil Harness]
			{spellID = 37316, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wrath of Elune (Special, Proc) [Wyrmhide Battlegear / Gladiator's Wildhide]
			{spellID = 46833, unitID = "player", caster = "player", filter = "BUFF"},

			-- Idols
			-- Lunar Grace (Spell Power, Proc) [Idol of the Unseen Moon]
			{spellID = 43740, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mark of the White Stag (Attack Power, Mangle) [Idol of the White Stag]
			{spellID = 41038, unitID = "player", caster = "player", filter = "BUFF"},
			-- Primal Instinct (Agility, Mangle) [Idol of Terror]
			{spellID = 43738, unitID = "player", caster = "player", filter = "BUFF"},
			-- Resilient (Resilience, Moonfire/Mangle) [Idol of Resolve / Idol of Steadfastness]
			{spellID = 43839, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- Class
			-- Blessing of Cenarius (Strength, Proc) [Ashtongue Talisman of Equilibrium - Mangle]
			{spellID = 40452, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blessing of Remulos (Spell Power, Proc) [Ashtongue Talisman of Equilibrium - Starfire]
			{spellID = 40445, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blessing of Elune (Healing Power, Proc) [Ashtongue Talisman of Equilibrium - Rejuvenation]
			{spellID = 40446, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cenarion Blessing (Spell Power/Healing Power, Proc) [Living Root of the Wildheart - Caster]
			{spellID = 37344, unitID = "player", caster = "player", filter = "BUFF"},
			-- Feline Blessing (Strength, Proc) [Living Root of the Wildheart - Cat]
			{spellID = 37341, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lunar Blessing (Spell Power, Proc) [Living Root of the Wildheart - Moonkin]
			{spellID = 37343, unitID = "player", caster = "player", filter = "BUFF"},
			-- Slyvan Blessing (Healing Power, Proc) [Living Root of the Wildheart - Tree]
			{spellID = 37342, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ursine Blessing (Armor, Proc) [Living Root of the Wildheart - Bear]
			{spellID = 37340, unitID = "player", caster = "player", filter = "BUFF"},
			-- Metamorphosis Rune (Special, Use) [Rune of Metamorphosis]
			{spellID = 23724, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nimble Healing Touch (Special, Use) [Wushoolay's Charm of Nature]
			{spellID = 24542, unitID = "player", caster = "player", filter = "BUFF"},

			-- Darkmoon Cards
			-- Aura of the Blue Dragon (Special, Proc) [Darkmoon Card: Blue Dragon]
			{spellID = 23684, unitID = "player", caster = "player", filter = "BUFF"},
			-- Aura of the Crusader (Attack Power, Proc) [Darkmoon Card: Crusade]
			{spellID = 39439, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Aura of the Crusader (Spell Power, Proc) [Darkmoon Card: Crusade]
			{spellID = 39441, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Aura of Wrath (Critical Strike, Proc) [Darkmoon Card: Wrath]
			{spellID = 39443, unitID = "player", caster = "player", filter = "BUFF"},
			-- Delusional (Attack Power, Proc) [Darkmoon Card: Madness] - Rogue, Hunter, Paladin, Warrior, Druid, Shaman
			{spellID = 40997, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dementia (Special Power, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin
			{spellID = 41404, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Dementia +5% (Special Power, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin
			{spellID = 41406, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Dementia -5% (Special Power, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin
			{spellID = 41409, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Kleptomania (Agility, Proc) [Darkmoon Card: Madness] - Warrior, Rogue, Paladin, Hunter, Druid
			{spellID = 40998, unitID = "player", caster = "player", filter = "BUFF"},
			-- Manic (Haste, Proc) [Darkmoon Card: Madness] - All classes except Hunter
			{spellID = 41005, unitID = "player", caster = "player", filter = "BUFF"},
			-- Martyr Complex (Stamina, Proc) [Darkmoon Card: Madness] - All classes
			{spellID = 41011, unitID = "player", caster = "player", filter = "BUFF"},
			-- Megalomania (Spell Power, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin
			{spellID = 40999, unitID = "player", caster = "player", filter = "BUFF"},
			-- Narcissism (Intellect, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin, Hunter
			{spellID = 41009, unitID = "player", caster = "player", filter = "BUFF"},
			-- Paranoia (Critical Strike, Proc) [Darkmoon Card: Madness] - All classes except Hunter
			{spellID = 41002, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Sociopath (Strength, Proc) [Darkmoon Card: Madness] - Paladin, Rogue, Druid, Warrior
			{spellID = 39511, unitID = "player", caster = "player", filter = "BUFF"},

			-- PvP Trinkets
			-- Aura of Protection (Absorb, Use) [Arena Grand Master]
			{spellID = 23506, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage Absorb (Absorb, Use) [Arathi Basin Trinket]
			{spellID = 25750, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tremendous Fortitude (Health, Use) [Battlemaster]
			{spellID = 44055, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shell of Deterrence (Absorb, Use) [Runed Fungalcap]
			{spellID = 31771, unitID = "player", caster = "player", filter = "BUFF"},

			-- Universal
			-- Arcane Shroud (Threat Reduction, Use) [Fetish of the Sand Reaver]
			{spellID = 26400, unitID = "player", caster = "player", filter = "BUFF"},
			-- Chitinous Spikes (Special, Use) [Fetish of Chitinous Spikes]
			{spellID = 26168, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of the Scale (Special, Use) [Heart of the Scale]
			{spellID = 17275, unitID = "player", caster = "player", filter = "BUFF"},
			-- Loatheb's Reflection (Magic Resistance, Use) [Loatheb's Reflection]
			{spellID = 28778, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mercurial Shield (Magic Resistance, Use) [Petrified Scarab]
			{spellID = 26464, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Burrower's Shell (Absorb, Use) [The Burrower's Shell]
			{spellID = 29506, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Lion Horn of Stormwind (Special, Proc) [The Lion Horn of Stormwind]
			{spellID = 18946, unitID = "player", caster = "player", filter = "BUFF"},

			-- Tanking
			-- Adamantine Shell (Armor, Use) [Adamantine Figurine]
			{spellID = 33479, unitID = "player", caster = "player", filter = "BUFF"},
			-- Argussian Compass (Absorb, Use) [Argussian Compass]
			{spellID = 39228, unitID = "player", caster = "player", filter = "BUFF"},
			-- Avoidance (Dodge, Use) [Charm of Alacrity]
			{spellID = 32600, unitID = "player", caster = "player", filter = "BUFF"},
			-- Brittle Armor (Special, Use) [Zandalarian Hero Badge]
			{spellID = 24575, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dawnstone Crab (Dodge, Use) [Figurine - Dawnstone Crab]
			{spellID = 31039, unitID = "player", caster = "player", filter = "BUFF"},
			-- Displacement (Defense Rating, Use) [Scarab of Displacement]
			{spellID = 38351, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Empyrean Tortoise (Dodge, Use) [Figurine - Empyrean Tortoise]
			{spellID = 46780, unitID = "player", caster = "player", filter = "BUFF"},
			-- Evasive Maneuvers (Dodge, Proc) [Commendation of Kael'thas]
			{spellID = 45058, unitID = "player", caster = "player", filter = "BUFF"},
			-- Force of Will (Special, Proc) [Force of Will]
			{spellID = 15595, unitID = "player", caster = "player", filter = "BUFF"},
			-- Hardened Skin (Armor, Use) [Ancient Aqir Artifact]
			{spellID = 43713, unitID = "player", caster = "player", filter = "BUFF"},
			-- Protector's Vigor (Health, Use) [Shadowmoon Insignia]
			{spellID = 40464, unitID = "player", caster = "player", filter = "BUFF"},
			-- Regeneration (HoT, Use) [Spyglass of the Hidden Fleet]
			-- {spellID = 38325, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Tenacity (Health, Use) [Brooch of the Immortal King]
			-- {spellID = 40538, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Tenacity (Health, Use) [Regal Protectorate]
			{spellID = 33668, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Tenacity (Health, Use) [Steely Naaru Sliver]
			-- {spellID = 45049, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Time's Favor (Dodge, Use) [Moroes' Lucky Pocket Watch]
			{spellID = 34519, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vigilance of the Colossus (Special, Use) [Figurine of the Colossus]
			{spellID = 33089, unitID = "player", caster = "player", filter = "BUFF"},

			-- Damage [Physical]
			-- Ancient Power (Attack Power, Use) [Core of Ar'kelos]
			{spellID = 35733, unitID = "player", caster = "player", filter = "BUFF"},
			-- Armor Penetration (Armor Penetration, Use) [Icon of Unyielding Courage]
			{spellID = 34106, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Battle Trance (Attack Power, Proc) [Blackened Naaru Sliver]
			{spellID = 45040, unitID = "player", caster = "player", filter = "BUFF"},
			-- Burning Hatred (Attack Power, Use) [Ogre Mauler's Badge / Uniting Charm]
			{spellID = 32362, unitID = "player", caster = "player", filter = "BUFF"},
			-- Call of the Berserker (Attack Power, Use) [Berserker's Call]
			{spellID = 43716, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combat Insight (Attack Power, Proc) [Blackened Naaru Sliver]
			{spellID = 45041, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combat Valor (Attack Power, Proc) [Skyguard Silver Cross]
			{spellID = 41261, unitID = "player", caster = "player", filter = "BUFF"},
			-- Consume Life (Special, Use) [Fetish of the Fallen]
			{spellID = 33015, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Dire Drunkard (Attack Power, Use) [Empty Mug of Direbrew]
			{spellID = 51955, unitID = "player", caster = "player", filter = "BUFF"},
			-- Disdain (Attack Power, Proc) [Shard of Contempt]
			{spellID = 45053, unitID = "player", caster = "player", filter = "BUFF"},
			-- Earthstrike (Attack Power, Use) [Earthstrike]
			{spellID = 25891, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ferocity (Attack Power, Use) [Ancient Draenei War Talisman / Bladefist's Breadth]
			{spellID = 33667, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Forceful Strike (Armor Penetration, Proc) [Madness of the Betrayer]
			{spellID = 40477, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fury of the Crashing Waves (Attack Power, Proc) [Tsunami Talisman]
			{spellID = 42084, unitID = "player", caster = "player", filter = "BUFF"},
			--[[
			-- Haste (Physical Haste, Use) [Abacus of Violent Odds]
			{spellID = 33807, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Haste (Physical Haste, Proc) [Dragonspine Trophy]
			{spellID = 34775, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			--]]
			-- Heightened Reflexes (Agility, Use) [Badge of Tenacity]
			{spellID = 40729, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heroism (Attack Power, Use) [Terokkar Tablet of Precision]
			-- {spellID = 39200, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Insight of the Qiraji (Armor Penetration, Use) [Badge of the Swarmguard]
			{spellID = 26481, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jom Gabbar (Attack Power, Use) [Jom Gabbar]
			{spellID = 29604, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Kiss of the Spider (Physical Haste, Use) [Kiss of the Spider]
			{spellID = 28866, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lust for Battle (Attack Power, Use) [Bloodlust Brooch]
			{spellID = 35166, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nightseye Panther (Attack Power, Use) [Figurine - Nightseye Panther]
			{spellID = 31047, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rage of the Unraveller (Attack Power, Proc) [Hourglass of the Unraveller]
			{spellID = 33649, unitID = "player", caster = "player", filter = "BUFF"},
			-- Restless Strength (Special, Use) [Zandalarian Hero Medallion]
			{spellID = 24662, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadowsong Panther (Attack Power, Use) [Figurine - Shadowsong Panther]
			{spellID = 46784, unitID = "player", caster = "player", filter = "BUFF"},
			-- Slayer's Crest (Attack Power, Use) [Slayer's Crest]
			{spellID = 28777, unitID = "player", caster = "player", filter = "BUFF"},
			-- Valor (Attack Power, Use) [Crystalforged Trinket]
			{spellID = 40724, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- Damage [Magic]
			-- Arcane Energy (Healing Power, Use) [Ancient Draenei Arcane Relic / Vengeance of the Illidari]
			{spellID = 33662, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ascendance (Spell Power, Use) [Talisman of Ascendance]
			{spellID = 28204, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Blessing of the Silver Crescent (Spell Power, Use) [Icon of the Silver Crescent]
			{spellID = 35163, unitID = "player", caster = "player", filter = "BUFF"},
			-- Call of the Nexus (Spell Power, Proc) [Shiffar's Nexus-Horn]
			{spellID = 34321, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combat Gallantry (Spell Power, Proc) [Airman's Ribbon of Gallantry]
			{spellID = 41263, unitID = "player", caster = "player", filter = "BUFF"},
			-- Consume Essence (Special, Use) [Oculus of the Hidden Eye]
			{spellID = 33013, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Crimson Serpent (Spell Power, Use) [Figurine - Crimson Serpent]
			{spellID = 46783, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dark Iron Pipeweed (Spell Power, Use) [Dark Iron Smoking Pipe]
			{spellID = 51953, unitID = "player", caster = "player", filter = "BUFF"},
			-- Electrical Charge (Special, Proc) [The Lightning Capacitor]
			{spellID = 37658, unitID = "player", caster = "player", filter = "BUFF"},
			-- Enlightenment (Mana Regeneration, Use) [Pendant of the Violet Eye]
			{spellID = 35095, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Ephemeral Power (Spell Power, Use) [Talisman of Ephemeral Power]
			{spellID = 23271, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of Sapphiron (Spell Power, Use) [The Restrained Essence of Sapphiron]
			{spellID = 28779, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fel Infusion (Spell Haste, Use) [The Skull of Gul'dan]
			{spellID = 40396, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Focused Power (Spell Power, Use) [Ancient Crystal Talisman / Glowing Crystal Insignia]
			{spellID = 32355, unitID = "player", caster = "player", filter = "BUFF"},
			-- Living Ruby Serpent (Spell Power, Use) [Figurine - Living Ruby Serpent]
			{spellID = 31040, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mojo Madness (Spell Power, Use) [Hex Shrunken Head]
			{spellID = 43712, unitID = "player", caster = "player", filter = "BUFF"},
			-- Obsidian Insight (Spell Power, Special, Use) [Eye of Moam]
			{spellID = 26166, unitID = "player", caster = "player", filter = "BUFF"},
			-- Pagle's Broken Reel (Spell Hit, Use) [Nat Pagle's Broken Reel]
			{spellID = 24610, unitID = "player", caster = "player", filter = "BUFF"},
			-- Power Circle (Spell Power, Use) [Shifting Naaru Sliver]
			{spellID = 45043, unitID = "player", caster = "player", filter = "BUFF"},
			-- Recurring Power (Spell Power, Proc) [Eye of Magtheridon]
			{spellID = 34747, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spell Haste (Spell Haste, Proc) [Quagmirran's Eye]
			{spellID = 33370, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Spell Power (Spell Power, Use) [Scryer's Bloodgem / Xi'ri's Gift]
			{spellID = 35337, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			--[[
			-- Spell Power (Spell Power, Use) [Starkiller's Bauble]
			{spellID = 36432, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Spell Power (Spell Power, Use) [Terokkar Tablet of Vim]
			{spellID = 39201, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			--]]
			-- The Arcanist's Stone (Spell Power, Use) [Arcanist's Stone]
			{spellID = 34000, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Eye of Diminution (Special, Use) [Eye of Diminution]
			{spellID = 28862, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unstable Currents (Spell Power, Proc) [Sextant of Unstable Currents]
			{spellID = 38348, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unstable Power (Spell Power, Use) [Zandalarian Hero Charm]
			{spellID = 24659, unitID = "player", caster = "player", filter = "BUFF"},

			-- Healing
			-- Accelerated Mending (Healing Power, Use) [Warp-Scarab Brooch]
			{spellID = 33400, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blessing of Faith (Special, Use) [Lower City Prayerbook]
			{spellID = 37877, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blessing of Life (Special, Use) [Ribbon of Sacrifice]
			{spellID = 38332, unitID = "target", caster = "player", filter = "BUFF"},
			-- Chromatic Infusion (Healing Power, Use) [Draconic Infused Emblem]
			{spellID = 27675, unitID = "player", caster = "player", filter = "BUFF"},
			-- Deep Meditation (Spirit, Use) [Earring of Soulful Meditation]
			{spellID = 40402, unitID = "player", caster = "player", filter = "BUFF"},
			-- Diabolic Remedy (Healing Power, Use) [Tome of Diabolic Remedy]
			{spellID = 43710, unitID = "player", caster = "player", filter = "BUFF"},
			-- Endless Blessings (Spirit, Use) [Bangle of Endless Blessings]
			{spellID = 34210, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of the Martyr (Healing Power, Use) [Essence of the Martyr]
			{spellID = 35165, unitID = "player", caster = "player", filter = "BUFF"},
			-- Evocation (Mana Regeneration, Use) [Glimmering Naaru Sliver]
			{spellID = 45052, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Focused Mind (Special, Use) [Auslese's Light Channeler]
			{spellID = 31794, unitID = "player", caster = "player", filter = "BUFF"},
			-- Healing of the Ages (Healing Power, Use) [Hibernation Crystal]
			{spellID = 24998, unitID = "player", caster = "player", filter = "BUFF"},
			-- Healing Power (Healing Power, Use) [Heavenly Inspiration]
			{spellID = 36347, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Holy Energy (Special, Use) [Vial of the Sunwell]
			{spellID = 45062, unitID = "player", caster = "player", filter = "BUFF"},
			-- Hopped Up (Healing Power, Use) [Direbrew Hops]
			{spellID = 51954, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mar'li's Brain Boost (Mp5, Use) [Mar'li's Eye]
			{spellID = 24268, unitID = "player", caster = "player", filter = "BUFF"},
			-- Meditation (Special, Proc) [Bangle of Endless Blessings]
			{spellID = 38346, unitID = "player", caster = "player", filter = "BUFF"},
			-- Persistent Shield (Absorb, Use) [Scarab Brooch]
			{spellID = 26467, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Power of Prayer (Healing Power, Use) [Oshu'gun Relic]
			{spellID = 32367, unitID = "player", caster = "player", filter = "BUFF"},
			-- Seaspray Albatross (Mana Regeneration, Use) [Figurine - Seaspray Albatross]
			{spellID = 46785, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spell Haste (Spell Haste, Proc) [Scarab of the Infinite Cycle]
			-- {spellID = 33370, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Talasite Owl (Mana Regeneration, Use) [Figurine - Talasite Owl]
			{spellID = 31045, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Eye of the Dead (Special, Use) [Eye of the Dead]
			{spellID = 28780, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wisdom (Mana Regeneration, Proc) [Memento of Tyrande]
			{spellID = 37656, unitID = "player", caster = "player", filter = "BUFF"},

			-- Helms
			-- Arcane Might (Spell Power, Proc) [Circlet of Arcane Might]
			{spellID = 31037, unitID = "player", caster = "player", filter = "BUFF"},

			-- Necks
			-- Arcane Insight (Expertise, Proc) [Shattered Sun Pendant of Resolve - Scryer]
			{spellID = 45431, unitID = "player", caster = "player", filter = "BUFF"},
			-- Light's Salvation (Healing Power, Proc) [Shattered Sun Pendant of Restoration - Aldor]
			{spellID = 45478, unitID = "player", caster = "player", filter = "BUFF"},
			-- Light's Strength (Attack Power, Proc) [Shattered Sun Pendant of Might - Aldor]
			{spellID = 45480, unitID = "player", caster = "player", filter = "BUFF"},
			-- Light's Ward (Dodge, Proc) [Shattered Sun Pendant of Resolve - Aldor]
			{spellID = 45432, unitID = "player", caster = "player", filter = "BUFF"},
			-- Light's Wrath (Spell Power, Proc) [Shattered Sun Pendant of Acumen - Aldor]
			{spellID = 45479, unitID = "player", caster = "player", filter = "BUFF"},

			-- Rings
			-- Band of the Eternal Champion (Attack Power, Proc) [Band of the Eternal Champion]
			{spellID = 35081, unitID = "player", caster = "player", filter = "BUFF"},
			-- Band of the Eternal Defender (Armor, Proc) [Band of the Eternal Defender]
			{spellID = 35078, unitID = "player", caster = "player", filter = "BUFF"},
			-- Band of the Eternal Restorer (Healing Power, Proc) [Band of the Eternal Restorer]
			{spellID = 35087, unitID = "player", caster = "player", filter = "BUFF"},
			-- Band of the Eternal Sage (Spell Power, Proc) [Band of the Eternal Sage]
			{spellID = 35084, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spell Blasting (Spell Power, Proc) [Wrath of Cenarius]
			{spellID = 25906, unitID = "player", caster = "player", filter = "BUFF"},

			-- Weapons
			-- Mental Protection Field (Immunity, Use) [Staff of Disintegration]
			{spellID = 36480, unitID = "player", caster = "all", filter = "BUFF"},

			-- Meta Gems
			-- Focus (Spell Haste, Proc) [Mystical Skyfire Diamond]
			{spellID = 18803, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Skyfire Swiftness (Physical Haste, Proc) [Thundering Skyfire Diamond]
			{spellID = 39959, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Executioner [Enchant Weapon - Executioner]
			{spellID = 42976, unitID = "player", caster = "player", filter = "BUFF"},
			-- Holy Strength (Strength) [Enchant Weapon - Crusader]
			{spellID = 20007, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lightning Speed (Agility and Physical Attack Speed) [Enchant Weapon - Mongoose]
			{spellID = 28093, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spellsurge (Mana Regeneration to Party) [Enchant Weapon - Spellsurge]
			{spellID = 27996, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = C.filger.buffs_space,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Bash r1
			{spellID = 5211, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Bash r2
			{spellID = 6798, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Bash r3
			{spellID = 8983, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Celestial Focus (Starfire Stun)
			{spellID = 16922, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Challenging Roar
			{spellID = 5209, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Demoralizing Roar
			{spellID = 99, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Faerie Fire
			{spellID = 770, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Faerie Fire (Feral)
			{spellID = 16857, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Feral Charge Effect
			{spellID = 45334, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Hurricane
			-- {spellID = 16914, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Insect Swarm
			{spellID = 5570, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Lacerate
			{spellID = 33745, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Maim
			{spellID = 22570, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Mangle (Bear)
			{spellID = 33878, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Mangle (Cat)
			{spellID = 33876, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Moonfire
			{spellID = 8921, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Pounce r1
			{spellID = 9005, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Pounce r2
			{spellID = 9823, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Pounce r3
			{spellID = 9827, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Pounce r4
			{spellID = 27006, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Pounce Bleed
			{spellID = 9007, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Rake
			{spellID = 1822, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Rip
			{spellID = 1079, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Soothe Animal
			{spellID = 2908, unitID = "target", caster = "player", filter = "DEBUFF"},

			-- Trinket Effects

			-- Enchants
			-- Deathfrost [Enchant Weapon - Deathfrost]
			{spellID = 46629, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {"LEFT", T_DE_BUFF_BAR_Anchor},

			-- Abolish Poison
			{spellID = 2893, unitID = "target", caster = "player", filter = "BUFF"},
			-- Lifebloom
			{spellID = 33763, unitID = "target", caster = "player", filter = "BUFF"},
			-- Regrowth
			{spellID = 8936, unitID = "target", caster = "player", filter = "BUFF"},
			-- Rejuvenation
			{spellID = 774, unitID = "target", caster = "player", filter = "BUFF"},

			-- Trinket Effects
			-- Fecundity (Special, Use) [Ribbon of Sacrifice]
			{spellID = 38333, unitID = "target", caster = "player", filter = "BUFF"},
			-- Persistent Shield (Absorb, Use) [Scarab Brooch]
			{spellID = 26470, unitID = "target", caster = "player", filter = "BUFF", absID = true},
			-- Regeneration (HoT, Proc) [Fel Reaver's Piston]
			{spellID = 38324, unitID = "target", caster = "player", filter = "BUFF", absID = true},
		},
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {"LEFT", PVE_PVP_CC_Anchor},

			-- Cyclone
			{spellID = 33786, unitID = "focus", caster = "all", filter = "DEBUFF", absID = true},
			-- Entangling Roots r1
			{spellID = 339, unitID = "focus", caster = "all", filter = "DEBUFF", absID = true},
			-- Entangling Roots r2
			{spellID = 1062, unitID = "focus", caster = "all", filter = "DEBUFF", absID = true},
			-- Entangling Roots r3
			{spellID = 5195, unitID = "focus", caster = "all", filter = "DEBUFF", absID = true},
			-- Entangling Roots r4
			{spellID = 5196, unitID = "focus", caster = "all", filter = "DEBUFF", absID = true},
			-- Entangling Roots r5
			{spellID = 9852, unitID = "focus", caster = "all", filter = "DEBUFF", absID = true},
			-- Entangling Roots r6
			{spellID = 9853, unitID = "focus", caster = "all", filter = "DEBUFF", absID = true},
			-- Entangling Roots r7
			{spellID = 26989, unitID = "focus", caster = "all", filter = "DEBUFF", absID = true},
			-- Entangling Roots r1 (Nature's Grasp)
			{spellID = 19975, unitID = "focus", caster = "all", filter = "DEBUFF", absID = true},
			-- Entangling Roots r2 (Nature's Grasp)
			{spellID = 19974, unitID = "focus", caster = "all", filter = "DEBUFF", absID = true},
			-- Entangling Roots r3 (Nature's Grasp)
			{spellID = 19973, unitID = "focus", caster = "all", filter = "DEBUFF", absID = true},
			-- Entangling Roots r4 (Nature's Grasp)
			{spellID = 19972, unitID = "focus", caster = "all", filter = "DEBUFF", absID = true},
			-- Entangling Roots r5 (Nature's Grasp)
			{spellID = 19971, unitID = "focus", caster = "all", filter = "DEBUFF", absID = true},
			-- Entangling Roots r6 (Nature's Grasp)
			{spellID = 19970, unitID = "focus", caster = "all", filter = "DEBUFF", absID = true},
			-- Entangling Roots r7 (Nature's Grasp)
			{spellID = 27010, unitID = "focus", caster = "all", filter = "DEBUFF", absID = true},
			-- Hibernate
			{spellID = 2637, unitID = "focus", caster = "all", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = C.filger.cooldown_space,
			Alpha = 1,
			IconSize = C.filger.cooldown_size,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Self
			-- Barkskin
			{spellID = 22812, filter = "CD"},
			-- Bash
			{spellID = 5211, filter = "CD"},
			-- Challenging Roar
			{spellID = 5209, filter = "CD"},
			-- Cower
			{spellID = 8998, filter = "CD"},
			-- Dash
			{spellID = 1850, filter = "CD"},
			-- Enrage
			{spellID = 5229, filter = "CD", absID = true},
			-- Faerie Fire (Feral)
			{spellID = 16857, filter = "CD"},
			-- Feral Charge
			{spellID = 16979, filter = "CD"},
			-- Force of Nature
			{spellID = 33831, filter = "CD"},
			-- Frenzied Regeneration
			{spellID = 22842, filter = "CD"},
			-- Growl
			{spellID = 6795, filter = "CD"},
			-- Hurricane
			{spellID = 16914, filter = "CD"},
			-- Innervate
			{spellID = 29166, filter = "CD"},
			-- Maim
			{spellID = 22570, filter = "CD"},
			-- Mangle (Bear)
			{spellID = 33878, filter = "CD"},
			-- Nature's Grasp
			{spellID = 16689, filter = "CD"},
			-- Nature's Swiftness
			{spellID = 17116, filter = "CD"},
			-- Prowl
			{spellID = 5215, filter = "CD"},
			-- Rebirth
			{spellID = 20484, filter = "CD"},
			-- Swiftmend
			{spellID = 18562, filter = "CD"},
			-- Tiger's Fury
			{spellID = 5217, filter = "CD"},
			-- Tranquility
			{spellID = 740, filter = "CD"},

			-- Racial
			-- Shadowmeld (Night Elf)
			{spellID = 20580, filter = "CD"},
			-- War Stomp (Tauren)
			{spellID = 20549, filter = "CD", absID = true},

			-- Items
			-- Back
			{slotID = 15, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Neck
			{slotID = 2, filter = "CD"},
			-- Rings
			{slotID = 11, filter = "CD"},
			{slotID = 12, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},
		},
	},
	["HUNTER"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = C.filger.buffs_space,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Aspect of the Beast
			-- {spellID = 13161, unitID = "player", caster = "player", filter = "BUFF"},
			-- Aspect of the Cheetah
			{spellID = 5118, unitID = "player", caster = "player", filter = "BUFF"},
			-- Aspect of the Hawk
			-- {spellID = 13165, unitID = "player", caster = "player", filter = "BUFF"},
			-- Aspect of the Monkey
			-- {spellID = 13163, unitID = "player", caster = "player", filter = "BUFF"},
			-- Aspect of the Pack
			{spellID = 13159, unitID = "player", caster = "player", filter = "BUFF"},
			-- Aspect of the Viper
			{spellID = 34074, unitID = "player", caster = "player", filter = "BUFF"},
			-- Aspect of the Wild
			-- {spellID = 20043, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bestial Wrath
			{spellID = 19574, unitID = "pet", caster = "player", filter = "BUFF"},
			-- Cobra Reflexes
			{spellID = 25077, unitID = "pet", caster = "all", filter = "BUFF"},
			-- Dash (Boar / Cat / Hyena / Raptor / Tallstrider / Wolf)
			-- {spellID = 23099, unitID = "pet", caster = "all", filter = "BUFF"},
			-- Deterrence
			{spellID = 19263, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dive (Bat / Bird of Prey / Carrion Bird / Dragonhawk / Nether Ray / Wind Serpent)
			-- {spellID = 23145, unitID = "pet", caster = "all", filter = "BUFF"},
			-- Eagle Eye
			-- {spellID = 6197, unitID = "player", caster = "player", filter = "BUFF"},
			-- Eyes of the Beast
			-- {spellID = 1002, unitID = "player", caster = "player", filter = "BUFF"},
			-- Feed Pet Effect
			-- {spellID = 1539, unitID = "pet", caster = "player", filter = "BUFF"},
			-- Feign Death
			{spellID = 5384, unitID = "player", caster = "player", filter = "BUFF"},
			-- Frenzy Effect
			{spellID = 19615, unitID = "pet", caster = "all", filter = "BUFF"},
			-- Furious Howl (Wolf)
			{spellID = 24604, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mend Pet
			{spellID = 136, unitID = "pet", caster = "player", filter = "BUFF"},
			-- Misdirection
			{spellID = 34477, unitID = "player", caster = "player", filter = "BUFF"},
			-- Prowl (Cat)
			-- {spellID = 24450, unitID = "pet", caster = "all", filter = "BUFF"}
			-- Rapid Fire
			{spellID = 3045, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rapid Killing
			{spellID = 35098, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shell Shield (Turtle)
			{spellID = 26064, unitID = "pet", caster = "all", filter = "BUFF"},
			-- Spirit Bond
			-- {spellID = 19579, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tame Beast
			-- {spellID = 1515, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Beast Within
			{spellID = 34471, unitID = "player", caster = "player", filter = "BUFF"},
			-- Trueshot Aura
			{spellID = 20905, unitID = "pet", caster = "player", filter = "BUFF"},
			-- Warp (Warp Stalker)
			-- {spellID = 35346, unitID = "pet", caster = "all", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = C.filger.buffs_space,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Buffs
			-- Ferocious Inspiration
			{spellID = 34456, unitID = "player", caster = "all", filter = "BUFF"},
			-- Master Tactician
			{spellID = 34833, unitID = "player", caster = "player", filter = "BUFF"},
			-- Quick Shots
			{spellID = 6150, unitID = "player", caster = "player", filter = "BUFF"},

			-- Item Sets
			-- Exploited Weakness (Armor Penetration, Proc) [Beast Lord Armor]
			{spellID = 37482, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heroic Resolution (Attack Power, Proc) [Desolation Battlegear / Doomplate Battlegear / Wastewalker Armor]
			{spellID = 37612, unitID = "player", caster = "player", filter = "BUFF"},

			-- Ranged
			-- Santos' Blessing (Attack Power, Proc) [Don Santos' Famous Hunting Rifle]
			{spellID = 38293, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- Class
			-- Arcane Infused (Special, Use) [Arcane Infused Gem]
			{spellID = 23721, unitID = "player", caster = "player", filter = "BUFF"},
			-- Deadly Aim (Attack Power, Proc) [Ashtongue Talisman of Swiftness]
			{spellID = 40487, unitID = "player", caster = "player", filter = "BUFF"},
			-- Devilsaur Fury (Attack Power, Use) [Devilsaur Eye]
			{spellID = 24352, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shot Power (Special, Proc) [Talon of Al'ar]
			{spellID = 37508, unitID = "player", caster = "player", filter = "BUFF"},

			-- Darkmoon Cards
			-- Aura of the Blue Dragon (Special, Proc) [Darkmoon Card: Blue Dragon]
			{spellID = 23684, unitID = "player", caster = "player", filter = "BUFF"},
			-- Aura of the Crusader (Attack Power, Proc) [Darkmoon Card: Crusade]
			{spellID = 39439, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Aura of Wrath (Critical Strike, Proc) [Darkmoon Card: Wrath]
			{spellID = 39443, unitID = "player", caster = "player", filter = "BUFF"},
			-- Delusional (Attack Power, Proc) [Darkmoon Card: Madness] - Rogue, Hunter, Paladin, Warrior, Druid, Shaman
			{spellID = 40997, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kleptomania (Agility, Proc) [Darkmoon Card: Madness] - Warrior, Rogue, Paladin, Hunter, Druid
			{spellID = 40998, unitID = "player", caster = "player", filter = "BUFF"},
			-- Martyr Complex (Stamina, Proc) [Darkmoon Card: Madness] - All classes
			{spellID = 41011, unitID = "player", caster = "player", filter = "BUFF"},
			-- Narcissism (Intellect, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin, Hunter
			{spellID = 41002, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- PvP Trinkets
			-- Aura of Protection (Absorb, Use) [Arena Grand Master]
			{spellID = 23506, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage Absorb (Absorb, Use) [Arathi Basin Trinket]
			{spellID = 25750, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tremendous Fortitude (Health, Use) [Battlemaster]
			{spellID = 44055, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shell of Deterrence (Absorb, Use) [Runed Fungalcap]
			{spellID = 31771, unitID = "player", caster = "player", filter = "BUFF"},

			-- Universal
			-- Arcane Shroud (Threat Reduction, Use) [Fetish of the Sand Reaver]
			{spellID = 26400, unitID = "player", caster = "player", filter = "BUFF"},
			-- Chitinous Spikes (Special, Use) [Fetish of Chitinous Spikes]
			{spellID = 26168, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of the Scale (Special, Use) [Heart of the Scale]
			{spellID = 17275, unitID = "player", caster = "player", filter = "BUFF"},
			-- Loatheb's Reflection (Magic Resistance, Use) [Loatheb's Reflection]
			{spellID = 28778, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mercurial Shield (Magic Resistance, Use) [Petrified Scarab]
			{spellID = 26464, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Burrower's Shell (Absorb, Use) [The Burrower's Shell]
			{spellID = 29506, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Lion Horn of Stormwind (Special, Proc) [The Lion Horn of Stormwind]
			{spellID = 18946, unitID = "player", caster = "player", filter = "BUFF"},

			-- Damage [Physical]
			-- Ancient Power (Attack Power, Use) [Core of Ar'kelos]
			{spellID = 35733, unitID = "player", caster = "player", filter = "BUFF"},
			-- Armor Penetration (Armor Penetration, Use) [Icon of Unyielding Courage]
			{spellID = 34106, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Battle Trance (Attack Power, Proc) [Blackened Naaru Sliver]
			{spellID = 45040, unitID = "player", caster = "player", filter = "BUFF"},
			-- Burning Hatred (Attack Power, Use) [Ogre Mauler's Badge / Uniting Charm]
			{spellID = 32362, unitID = "player", caster = "player", filter = "BUFF"},
			-- Call of the Berserker (Attack Power, Use) [Berserker's Call]
			{spellID = 43716, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combat Insight (Attack Power, Proc) [Blackened Naaru Sliver]
			{spellID = 45041, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combat Valor (Attack Power, Proc) [Skyguard Silver Cross]
			{spellID = 41261, unitID = "player", caster = "player", filter = "BUFF"},
			-- Consume Life (Special, Use) [Fetish of the Fallen]
			{spellID = 33015, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Dire Drunkard (Attack Power, Use) [Empty Mug of Direbrew]
			{spellID = 51955, unitID = "player", caster = "player", filter = "BUFF"},
			-- Disdain (Attack Power, Proc) [Shard of Contempt]
			{spellID = 45053, unitID = "player", caster = "player", filter = "BUFF"},
			-- Earthstrike (Attack Power, Use) [Earthstrike]
			{spellID = 25891, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ferocity (Attack Power, Use) [Ancient Draenei War Talisman / Bladefist's Breadth]
			{spellID = 33667, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Forceful Strike (Armor Penetration, Proc) [Madness of the Betrayer]
			{spellID = 40477, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fury of the Crashing Waves (Attack Power, Proc) [Tsunami Talisman]
			{spellID = 42084, unitID = "player", caster = "player", filter = "BUFF"},
			--[[
			-- Haste (Physical Haste, Use) [Abacus of Violent Odds]
			{spellID = 33807, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Haste (Physical Haste, Proc) [Dragonspine Trophy]
			{spellID = 34775, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			--]]
			-- Heightened Reflexes (Agility, Use) [Badge of Tenacity]
			{spellID = 40729, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heroism (Attack Power, Use) [Terokkar Tablet of Precision]
			-- {spellID = 39200, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Insight of the Qiraji (Armor Penetration, Use) [Badge of the Swarmguard]
			{spellID = 26481, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jom Gabbar (Attack Power, Use) [Jom Gabbar]
			{spellID = 29604, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Kiss of the Spider (Physical Haste, Use) [Kiss of the Spider]
			{spellID = 28866, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lust for Battle (Attack Power, Use) [Bloodlust Brooch]
			{spellID = 35166, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nightseye Panther (Attack Power, Use) [Figurine - Nightseye Panther]
			{spellID = 31047, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rage of the Unraveller (Attack Power, Proc) [Hourglass of the Unraveller]
			{spellID = 33649, unitID = "player", caster = "player", filter = "BUFF"},
			-- Restless Strength (Special, Use) [Zandalarian Hero Medallion]
			{spellID = 24662, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadowsong Panther (Attack Power, Use) [Figurine - Shadowsong Panther]
			{spellID = 46784, unitID = "player", caster = "player", filter = "BUFF"},
			-- Slayer's Crest (Attack Power, Use) [Slayer's Crest]
			{spellID = 28777, unitID = "player", caster = "player", filter = "BUFF"},
			-- Valor (Attack Power, Use) [Crystalforged Trinket]
			{spellID = 40724, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- Necks
			-- Light's Strength (Attack Power, Proc) [Shattered Sun Pendant of Might - Aldor]
			{spellID = 45480, unitID = "player", caster = "player", filter = "BUFF"},

			-- Rings
			-- Band of the Eternal Champion (Attack Power, Proc) [Band of the Eternal Champion]
			{spellID = 35081, unitID = "player", caster = "player", filter = "BUFF"},

			-- Weapons
			-- Mental Protection Field (Immunity, Use) [Staff of Disintegration]
			{spellID = 36480, unitID = "player", caster = "all", filter = "BUFF"},
			-- Speed Infusion (Movement Speed, Physical Attack Speed, Proc) [Devastation / Warp Slicer]
			{spellID = 36479, unitID = "player", caster = "player", filter = "BUFF"},

			-- Meta Gems
			-- Skyfire Swiftness (Physical Haste, Proc) [Thundering Skyfire Diamond]
			{spellID = 39959, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = C.filger.buffs_space,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Aimed Shot
			{spellID = 19434, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Beast Lore
			-- {spellID = 1462, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Black Arrow
			{spellID = 3674, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Charge (Boar)
			{spellID = 25999, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Concussive Barrage
			{spellID = 35101, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Concussive Shot
			{spellID = 5116, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Counterattack
			{spellID = 19306, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Entrapment
			{spellID = 19185, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Explosive Trap Effect
			-- {spellID = 13812, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Expose Weakness
			{spellID = 34501, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Fire Breath (Dragonhawk)
			{spellID = 34889, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Flare
			-- {spellID = 1543, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frost Trap Aura
			{spellID = 13810, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Hunter's Mark
			{spellID = 1130, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Immolation Trap Effect
			-- {spellID = 13797, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Improved Concussive Shot
			{spellID = 19410, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Improved Wing Clip
			{spellID = 19229, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Intimidation
			{spellID = 24394, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Poison Spit (Serpent)
			{spellID = 35387, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Scatter Shot
			{spellID = 19503, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Scorpid Poison r1 (Scorpid)
			{spellID = 24640, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Scorpid Poison r2 (Scorpid)
			{spellID = 24583, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Scorpid Poison r3 (Scorpid)
			{spellID = 24586, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Scorpid Poison r4 (Scorpid)
			{spellID = 24587, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Scorpid Poison r5 (Scorpid)
			{spellID = 27060, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Scorpid Sting
			{spellID = 3043, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Screech r1 (Bat / Bird of Prey / Carrion Bird)
			{spellID = 24423, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Screech r2 (Bat / Bird of Prey / Carrion Bird)
			{spellID = 24577, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Screech r3 (Bat / Bird of Prey / Carrion Bird)
			{spellID = 24578, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Screech r4 (Bat / Bird of Prey / Carrion Bird)
			{spellID = 24579, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Screech r5 (Bat / Bird of Prey / Carrion Bird)
			{spellID = 27051, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Serpent Sting
			{spellID = 1978, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Silencing Shot
			{spellID = 34490, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Viper Sting
			{spellID = 3034, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Wing Clip
			{spellID = 2974, unitID = "target", caster = "player", filter = "DEBUFF"},

			-- Item Sets
			-- Expose Weakness (Special, Proc) [Dragonstalker Armor]
			{spellID = 23577, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},

			-- Trinket Effects

			-- Enchants
			-- Deathfrost [Enchant Weapon - Deathfrost]
			{spellID = 46629, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
		--[[
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {"LEFT", T_DE_BUFF_BAR_Anchor},
		},
		--]]
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {"LEFT", PVE_PVP_CC_Anchor},

			-- Freezing Trap Effect
			{spellID = 3355, unitID = "focus", caster = "player", filter = "DEBUFF"},
			-- Scare Beast
			{spellID = 1513, unitID = "focus", caster = "player", filter = "DEBUFF"},
			-- Wyvern Sting
			{spellID = 19386, unitID = "focus", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = C.filger.cooldown_space,
			Alpha = 1,
			IconSize = C.filger.cooldown_size,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Self
			-- Arcane Shot
			{spellID = 3044, filter = "CD"},
			-- Aimed Shot
			{spellID = 19434, filter = "CD"},
			-- Bestial Wrath
			{spellID = 19574, filter = "CD"},
			-- Black Arrow
			{spellID = 3674, filter = "CD"},
			-- Concussive Shot
			{spellID = 5116, filter = "CD"},
			-- Counterattack
			{spellID = 19306, filter = "CD"},
			-- Deterrence
			{spellID = 19263, filter = "CD"},
			-- Disengage
			{spellID = 781, filter = "CD"},
			-- Distracting Shot
			{spellID = 20736, filter = "CD"},
			-- Explosive Trap
			{spellID = 13813, filter = "CD"},
			-- Feign Death
			{spellID = 5384, filter = "CD"},
			-- Flare
			{spellID = 1543, filter = "CD", absID = true},
			-- Freezing Trap
			{spellID = 1499, filter = "CD"},
			-- Frost Trap
			{spellID = 13809, filter = "CD"},
			-- Immolation Trap
			{spellID = 13795, filter = "CD"},
			-- Intimidation
			{spellID = 19577, filter = "CD", absID = true},
			-- Kill Command
			{spellID = 34026, filter = "CD"},
			-- Misdirection
			{spellID = 34477, filter = "CD"},
			-- Mongoose Bite
			{spellID = 1495, filter = "CD"},
			-- Multi-Shot
			{spellID = 2643, filter = "CD"},
			-- Rapid Fire
			{spellID = 3045, filter = "CD"},
			-- Raptor Strike
			{spellID = 2973, filter = "CD"},
			-- Readiness
			{spellID = 23989, filter = "CD"},
			-- Scare Beast
			{spellID = 1513, filter = "CD"},
			-- Scatter Shot
			{spellID = 19503, filter = "CD"},
			-- Silencing Shot
			{spellID = 34490, filter = "CD"},
			-- Snake Trap
			{spellID = 34600, filter = "CD"},
			-- Tranquilizing Shot
			{spellID = 19801, filter = "CD"},
			-- Viper Sting
			{spellID = 3034, filter = "CD"},
			-- Volley
			{spellID = 1510, filter = "CD"},
			-- Wyvern Sting
			{spellID = 19386, filter = "CD"},

			-- Pets
			-- Charge (Boar)
			{spellID = 7371, filter = "CD"},
			-- Dash (Boar / Cat / Hyena / Raptor / Ravager / Tallstrider / Wolf)
			{spellID = 23099, filter = "CD"},
			-- Dive (Bat / Bird of Prey / Carrion Bird / Dragonhawk / Nether Ray / Wind Serpent)
			{spellID = 23145, filter = "CD"},
			-- Shell Shield (Turtle)
			{spellID = 26064, filter = "CD"},
			-- Thunderstomp (Gorilla)
			{spellID = 26090, filter = "CD"},
			-- Warp (Warp Stalker)
			{spellID = 35346, filter = "CD"},

			-- Racial
			-- Arcane Torrent (Mana)
			{spellID = 28730, filter = "CD", absID = true},
			-- Berserking (Mana)
			{spellID = 20554, filter = "CD", absID = true},
			-- Blood Fury (Physical)
			{spellID = 20572, filter = "CD", absID = true},
			-- Blood Fury (Both)
			{spellID = 33697, filter = "CD", absID = true},
			-- Blood Fury (Spell)
			{spellID = 33702, filter = "CD", absID = true},
			-- Gift of the Naaru (Draenei)
			{spellID = 28880, filter = "CD"},
			-- Shadowmeld (Night Elf)
			{spellID = 20580, filter = "CD"},
			-- Stoneform (Dwarf)
			{spellID = 20594, filter = "CD"},
			-- War Stomp (Tauren)
			{spellID = 20549, filter = "CD", absID = true},

			-- Items
			-- Back
			{slotID = 15, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Neck
			{slotID = 2, filter = "CD"},
			-- Rings
			{slotID = 11, filter = "CD"},
			{slotID = 12, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},
		},
	},
	["MAGE"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = C.filger.buffs_space,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Arcane Power
			{spellID = 12042, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combustion
			{spellID = 28682, unitID = "player", caster = "player", filter = "BUFF"},
			-- Evocation
			{spellID = 12051, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Fire Ward r1
			{spellID = 543, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Fire Ward r2
			{spellID = 8457, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Fire Ward r3
			{spellID = 8458, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Fire Ward r4
			{spellID = 10223, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Fire Ward r5
			{spellID = 10225, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Fire Ward r6
			{spellID = 27128, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Frost Ward r1
			{spellID = 6143, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Frost Ward r2
			{spellID = 8461, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Frost Ward r3
			{spellID = 8462, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Frost Ward r4
			{spellID = 10177, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Frost Ward r5
			{spellID = 28609, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Frost Ward r6
			{spellID = 32796, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Ice Barrier
			{spellID = 11426, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Ice Block
			{spellID = 45438, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Icy Veins
			{spellID = 12472, unitID = "player", caster = "player", filter = "BUFF"},
			-- Improved Blink
			{spellID = 47000, unitID = "player", caster = "player", filter = "BUFF"},
			-- Invisibility
			-- {spellID = 32612, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Mana Shield r1
			{spellID = 1463, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Mana Shield r2
			{spellID = 8494, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Mana Shield r3
			{spellID = 8495, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Mana Shield r4
			{spellID = 10191, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Mana Shield r5
			{spellID = 10192, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Mana Shield r6
			{spellID = 10193, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Mana Shield r7
			{spellID = 27131, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Presence of Mind
			{spellID = 12043, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = C.filger.buffs_space,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Buffs
			-- Blazing Speed
			{spellID = 31643, unitID = "player", caster = "player", filter = "BUFF"},
			-- Clearcasting [Arcane Concentration]
			{spellID = 12536, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- Item Sets
			-- Arcane Madness (Spell Power, Proc) [Tirisfal Regalia]
			{spellID = 37444, unitID = "player", caster = "player", filter = "BUFF"},
			-- Arcane Surge (Spell Power, Proc) [Incanter's Regalia]
			{spellID = 37436, unitID = "player", caster = "player", filter = "BUFF"},
			-- Enigma's Answer (Spell Hit, Proc) [Enigma Vestments]
			{spellID = 26129, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fire Resistance (Fire Resistance, Proc) [Frostfire Regalia]
			{spellID = 28765, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Frost Resistance (Frost Resistance, Proc) [Frostfire Regalia]
			{spellID = 28766, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Nature Resistance (Nature Resistance, Proc) [Frostfire Regalia]
			{spellID = 28768, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Shadow Resistance (Shadow Resistance, Proc) [Frostfire Regalia]
			{spellID = 28769, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Arcane Resistance (Arcane Resistance, Proc) [Frostfire Regalia]
			{spellID = 28770, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Insight (Spell Power, Proc) [Mana-Etched Regalia]
			{spellID = 37620, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Lesser Spell Blasting (Spell Power, Proc) [Spellstrike Infusion]
			{spellID = 32108, unitID = "player", caster = "player", filter = "BUFF"},
			-- Netherwind Focus (Special, Proc) [Netherwind Regalia]
			{spellID = 22008, unitID = "player", caster = "player", filter = "BUFF"},
			-- Not There (Special, Proc) [Frostfire Regalia]
			{spellID = 28762, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- Class
			-- Arcane Potency (Spell Power, Use) [Hazza'rah's Charm of Magic]
			{spellID = 24544, unitID = "player", caster = "player", filter = "BUFF"},
			-- Insight of the Ashtongue (Spell Haste, Proc) [Ashtongue Talisman of Insight]
			{spellID = 40483, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mana Surge (Spell Power, Proc) [Serpent-Coil Braid]
			{spellID = 37445, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mind Quickening (Spell Haste, Use) [Mind Quickening Gem]
			{spellID = 23723, unitID = "player", caster = "player", filter = "BUFF"},

			-- Darkmoon Cards
			-- Aura of the Blue Dragon (Special, Proc) [Darkmoon Card: Blue Dragon]
			{spellID = 23684, unitID = "player", caster = "player", filter = "BUFF"},
			-- Aura of the Crusader (Spell Power, Proc) [Darkmoon Card: Crusade]
			{spellID = 39441, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Aura of Wrath (Critical Strike, Proc) [Darkmoon Card: Wrath]
			{spellID = 39443, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dementia (Special Power, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin
			{spellID = 41404, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Dementia +5% (Special Power, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin
			{spellID = 41406, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Dementia -5% (Special Power, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin
			{spellID = 41409, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Manic (Haste, Proc) [Darkmoon Card: Madness] - All classes except Hunter
			{spellID = 41005, unitID = "player", caster = "player", filter = "BUFF"},
			-- Martyr Complex (Stamina, Proc) [Darkmoon Card: Madness] - All classes
			{spellID = 41011, unitID = "player", caster = "player", filter = "BUFF"},
			-- Megalomania (Spell Power, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin
			{spellID = 40999, unitID = "player", caster = "player", filter = "BUFF"},
			-- Narcissism (Intellect, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin, Hunter
			{spellID = 41009, unitID = "player", caster = "player", filter = "BUFF"},
			-- Paranoia (Critical Strike, Proc) [Darkmoon Card: Madness] - All classes except Hunter
			{spellID = 41002, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- PvP Trinkets
			-- Aura of Protection (Absorb, Use) [Arena Grand Master]
			{spellID = 23506, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage Absorb (Absorb, Use) [Arathi Basin Trinket]
			{spellID = 25750, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tremendous Fortitude (Health, Use) [Battlemaster]
			{spellID = 44055, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shell of Deterrence (Absorb, Use) [Runed Fungalcap]
			{spellID = 31771, unitID = "player", caster = "player", filter = "BUFF"},

			-- Universal
			-- Arcane Shroud (Threat Reduction, Use) [Fetish of the Sand Reaver]
			{spellID = 26400, unitID = "player", caster = "player", filter = "BUFF"},
			-- Chitinous Spikes (Special, Use) [Fetish of Chitinous Spikes]
			{spellID = 26168, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of the Scale (Special, Use) [Heart of the Scale]
			{spellID = 17275, unitID = "player", caster = "player", filter = "BUFF"},
			-- Loatheb's Reflection (Magic Resistance, Use) [Loatheb's Reflection]
			{spellID = 28778, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mercurial Shield (Magic Resistance, Use) [Petrified Scarab]
			{spellID = 26464, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Burrower's Shell (Absorb, Use) [The Burrower's Shell]
			{spellID = 29506, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Lion Horn of Stormwind (Special, Proc) [The Lion Horn of Stormwind]
			{spellID = 18946, unitID = "player", caster = "player", filter = "BUFF"},

			-- Damage [Magic]
			-- Arcane Energy (Healing Power, Use) [Ancient Draenei Arcane Relic / Vengeance of the Illidari]
			{spellID = 33662, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ascendance (Spell Power, Use) [Talisman of Ascendance]
			{spellID = 28204, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Blessing of the Silver Crescent (Spell Power, Use) [Icon of the Silver Crescent]
			{spellID = 35163, unitID = "player", caster = "player", filter = "BUFF"},
			-- Call of the Nexus (Spell Power, Proc) [Shiffar's Nexus-Horn]
			{spellID = 34321, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combat Gallantry (Spell Power, Proc) [Airman's Ribbon of Gallantry]
			{spellID = 41263, unitID = "player", caster = "player", filter = "BUFF"},
			-- Consume Essence (Special, Use) [Oculus of the Hidden Eye]
			{spellID = 33013, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Crimson Serpent (Spell Power, Use) [Figurine - Crimson Serpent]
			{spellID = 46783, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dark Iron Pipeweed (Spell Power, Use) [Dark Iron Smoking Pipe]
			{spellID = 51953, unitID = "player", caster = "player", filter = "BUFF"},
			-- Electrical Charge (Special, Proc) [The Lightning Capacitor]
			{spellID = 37658, unitID = "player", caster = "player", filter = "BUFF"},
			-- Enlightenment (Mana Regeneration, Use) [Pendant of the Violet Eye]
			{spellID = 35095, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Ephemeral Power (Spell Power, Use) [Talisman of Ephemeral Power]
			{spellID = 23271, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of Sapphiron (Spell Power, Use) [The Restrained Essence of Sapphiron]
			{spellID = 28779, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fel Infusion (Spell Haste, Use) [The Skull of Gul'dan]
			{spellID = 40396, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Focused Power (Spell Power, Use) [Ancient Crystal Talisman / Glowing Crystal Insignia]
			{spellID = 32355, unitID = "player", caster = "player", filter = "BUFF"},
			-- Living Ruby Serpent (Spell Power, Use) [Figurine - Living Ruby Serpent]
			{spellID = 31040, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mojo Madness (Spell Power, Use) [Hex Shrunken Head]
			{spellID = 43712, unitID = "player", caster = "player", filter = "BUFF"},
			-- Obsidian Insight (Spell Power, Special, Use) [Eye of Moam]
			{spellID = 26166, unitID = "player", caster = "player", filter = "BUFF"},
			-- Pagle's Broken Reel (Spell Hit, Use) [Nat Pagle's Broken Reel]
			{spellID = 24610, unitID = "player", caster = "player", filter = "BUFF"},
			-- Power Circle (Spell Power, Use) [Shifting Naaru Sliver]
			{spellID = 45043, unitID = "player", caster = "player", filter = "BUFF"},
			-- Recurring Power (Spell Power, Proc) [Eye of Magtheridon]
			{spellID = 34747, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spell Haste (Spell Haste, Proc) [Quagmirran's Eye]
			{spellID = 33370, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Spell Power (Spell Power, Use) [Scryer's Bloodgem / Xi'ri's Gift]
			{spellID = 35337, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			--[[
			-- Spell Power (Spell Power, Use) [Starkiller's Bauble]
			{spellID = 36432, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Spell Power (Spell Power, Use) [Terokkar Tablet of Vim]
			{spellID = 39201, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			--]]
			-- The Arcanist's Stone (Spell Power, Use) [Arcanist's Stone]
			{spellID = 34000, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Eye of Diminution (Special, Use) [Eye of Diminution]
			{spellID = 28862, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unstable Currents (Spell Power, Proc) [Sextant of Unstable Currents]
			{spellID = 38348, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unstable Power (Spell Power, Use) [Zandalarian Hero Charm]
			{spellID = 24659, unitID = "player", caster = "player", filter = "BUFF"},

			-- Helms
			-- Arcane Might (Spell Power, Proc) [Circlet of Arcane Might]
			{spellID = 31037, unitID = "player", caster = "player", filter = "BUFF"},

			-- Necks
			-- Light's Wrath (Spell Power, Proc) [Shattered Sun Pendant of Acumen - Aldor]
			{spellID = 45479, unitID = "player", caster = "player", filter = "BUFF"},

			-- Rings
			-- Band of the Eternal Sage (Spell Power, Proc) [Band of the Eternal Sage]
			{spellID = 35084, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spell Blasting (Spell Power, Proc) [Wrath of Cenarius]
			{spellID = 25906, unitID = "player", caster = "player", filter = "BUFF"},

			-- Weapons
			-- Mental Protection Field (Immunity, Use) [Staff of Disintegration]
			{spellID = 36480, unitID = "player", caster = "all", filter = "BUFF"},

			-- Meta Gems
			-- Focus (Spell Haste, Proc) [Mystical Skyfire Diamond]
			{spellID = 18803, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- Enchants
			-- Spellsurge (Mana Regeneration to Party) [Enchant Weapon - Spellsurge]
			{spellID = 27996, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = C.filger.buffs_space,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Blast Wave r1
			{spellID = 11113, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Blast Wave r2
			{spellID = 13018, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Blast Wave r3
			{spellID = 13019, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Blast Wave r4
			{spellID = 13020, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Blast Wave r5
			{spellID = 13021, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Blast Wave r6
			{spellID = 27133, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Blast Wave r7
			{spellID = 33933, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Blizzard
			-- {spellID = 10, unitID = "target", caster = "player", filter = "DEBUFF"},
			--[[
			-- Chilled r1 (Blizzard)
			{spellID = 12484, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Chilled r2 (Blizzard)
			{spellID = 12485, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Chilled r3 (Blizzard)
			{spellID = 12486, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			--]]
			-- Chilled (Frost Armor)
			{spellID = 6136, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Chilled (Ice Armor)
			{spellID = 7321, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Cone of Cold r1
			{spellID = 120, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Cone of Cold r2
			{spellID = 8492, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Cone of Cold r3
			{spellID = 10159, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Cone of Cold r4
			{spellID = 10160, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Cone of Cold r5
			{spellID = 10161, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Cone of Cold r6
			{spellID = 27087, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Dragon's Breath
			{spellID = 31661, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Fireball r1
			{spellID = 133, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Fireball r2
			{spellID = 143, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Fireball r3
			{spellID = 145, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Fireball r4
			{spellID = 3140, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Fireball r5
			{spellID = 8400, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Fireball r6
			{spellID = 8401, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Fireball r7
			{spellID = 8402, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Fireball r8
			{spellID = 10148, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Fireball r9
			{spellID = 10149, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Fireball r10
			{spellID = 10150, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Fireball r11
			{spellID = 10151, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Fireball r12
			{spellID = 25306, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Fireball r13
			{spellID = 27070, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Fireball r14
			{spellID = 38692, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Fire Vulnerability (Improved Scorch)
			{spellID = 22959, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Flamestrike
			-- {spellID = 2120, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Frost Nova
			{spellID = 122, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Frostbite
			{spellID = 12494, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frostbolt r1
			{spellID = 116, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Frostbolt r2
			{spellID = 205, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Frostbolt r3
			{spellID = 837, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Frostbolt r4
			{spellID = 7322, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Frostbolt r5
			{spellID = 8406, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Frostbolt r6
			{spellID = 8407, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Frostbolt r7
			{spellID = 8408, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Frostbolt r8
			{spellID = 10179, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Frostbolt r9
			{spellID = 10180, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Frostbolt r10
			{spellID = 10181, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Frostbolt r11
			{spellID = 25304, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Frostbolt r12
			{spellID = 27071, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Frostbolt r13
			{spellID = 27072, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Frostbolt r14
			{spellID = 38697, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Ignite
			{spellID = 12654, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Impact
			{spellID = 12355, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Pyroblast
			{spellID = 11366, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Silenced - Improved Counterspell
			{spellID = 18469, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Slow
			{spellID = 31589, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Winter's Chill
			{spellID = 12579, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Item Sets
			-- Elemental Vulnerability (Special, Proc) [Frostfire Regalia]
			{spellID = 28772, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Freeze (Special, Proc) [Magister's Regalia / Sorcerer's Regalia]
			{spellID = 27868, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},

			-- Trinket Effects

			-- Enchants
			-- Deathfrost [Enchant Weapon - Deathfrost]
			{spellID = 46629, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
		--[[
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {"LEFT", T_DE_BUFF_BAR_Anchor},
		},
		--]]
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {"LEFT", PVE_PVP_CC_Anchor},

			-- Polymorph r1
			{spellID = 118, unitID = "focus", caster = "all", filter = "DEBUFF", absID = true},
			-- Polymorph r2
			{spellID = 12824, unitID = "focus", caster = "all", filter = "DEBUFF", absID = true},
			-- Polymorph r3
			{spellID = 12825, unitID = "focus", caster = "all", filter = "DEBUFF", absID = true},
			-- Polymorph r4
			{spellID = 12826, unitID = "focus", caster = "all", filter = "DEBUFF", absID = true},
			-- Polymorph: Pig
			{spellID = 28272, unitID = "focus", caster = "all", filter = "DEBUFF", absID = true},
			-- Polymorph: Turtle
			{spellID = 28271, unitID = "focus", caster = "all", filter = "DEBUFF", absID = true},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = C.filger.cooldown_space,
			Alpha = 1,
			IconSize = C.filger.cooldown_size,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Self
			-- Arcane Power
			{spellID = 12042, filter = "CD"},
			-- Blast Wave
			{spellID = 11113, filter = "CD"},
			-- Blink
			{spellID = 1953, filter = "CD"},
			-- Cold Snap
			{spellID = 11958, filter = "CD"},
			-- Combustion
			{spellID = 11129, filter = "CD"},
			-- Cone of Cold
			{spellID = 120, filter = "CD"},
			-- Counterspell
			{spellID = 2139, filter = "CD"},
			-- Dragon's Breath
			{spellID = 31661, filter = "CD"},
			-- Fire Blast
			{spellID = 2136, filter = "CD"},
			-- Fire Ward
			{spellID = 543, filter = "CD"},
			-- Freeze (Water Elemental)
			{spellID = 33395, filter = "CD", absID = true},
			-- Frost Nova
			{spellID = 122, filter = "CD"},
			-- Frost Ward
			{spellID = 6143, filter = "CD"},
			-- Ice Barrier
			{spellID = 11426, filter = "CD"},
			-- Ice Block
			{spellID = 45438, filter = "CD"},
			-- Icy Veins
			{spellID = 12472, filter = "CD"},
			-- Presence of Mind
			{spellID = 12043, filter = "CD"},
			-- Summon Water Elemental
			{spellID = 31687, filter = "CD"},

			-- Racial
			-- Arcane Torrent (Mana)
			{spellID = 28730, filter = "CD", absID = true},
			-- Berserking (Mana)
			{spellID = 20554, filter = "CD", absID = true},
			-- Cannibalize (Forsaken)
			{spellID = 20577, filter = "CD"},
			-- Escape Artist (Gnome)
			{spellID = 20589, filter = "CD"},
			-- Gift of the Naaru (Draenei)
			{spellID = 28880, filter = "CD"},
			-- Perception (Human)
			{spellID = 20600, filter = "CD"},
			-- Will of the Forsaken (Forsaken)
			{spellID = 7744, filter = "CD"},

			-- Items
			-- Back
			{slotID = 15, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Neck
			{slotID = 2, filter = "CD"},
			-- Rings
			{slotID = 11, filter = "CD"},
			{slotID = 12, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},
		},
	},
	["PALADIN"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = C.filger.buffs_space,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Avenging Wrath
			{spellID = 31884, unitID = "player", caster = "player", filter = "BUFF"},
			-- Concentration Aura
			-- {spellID = 19746, unitID = "player", caster = "player", filter = "BUFF"},
			-- Crusader Aura
			-- {spellID = 32223, unitID = "player", caster = "player", filter = "BUFF"},
			-- Devotion Aura
			-- {spellID = 465, unitID = "player", caster = "player", filter = "BUFF"},
			-- Divine Favor
			{spellID = 20216, unitID = "player", caster = "player", filter = "BUFF"},
			-- Divine Illumination
			{spellID = 31842, unitID = "player", caster = "player", filter = "BUFF"},
			-- Divine Protection r1
			{spellID = 498, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Divine Protection r2
			{spellID = 5573, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Divine Shield
			{spellID = 642, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fire Resistance Aura
			-- {spellID = 19891, unitID = "player", caster = "player", filter = "BUFF"},
			-- Forbearance
			{spellID = 25771, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- Frost Resistance Aura
			-- {spellID = 19888, unitID = "player", caster = "player", filter = "BUFF"},
			-- Holy Shield r1
			{spellID = 20925, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Holy Shield r2
			{spellID = 20927, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Holy Shield r3
			{spellID = 20928, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Holy Shield r4
			{spellID = 27179, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Light's Grace
			{spellID = 31834, unitID = "player", caster = "player", filter = "BUFF"},
			-- Retribution Aura
			-- {spellID = 7294, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sanctity Aura
			-- {spellID = 20218, unitID = "player", caster = "player", filter = "BUFF"},
			-- Seal of Blood
			{spellID = 31892, unitID = "player", caster = "player", filter = "BUFF"},
			-- Seal of Command
			{spellID = 20375, unitID = "player", caster = "player", filter = "BUFF"},
			-- Seal of Corruption
			{spellID = 348704, unitID = "player", caster = "player", filter = "BUFF"},
			-- Seal of Justice
			{spellID = 20164, unitID = "player", caster = "player", filter = "BUFF"},
			-- Seal of Light
			{spellID = 20165, unitID = "player", caster = "player", filter = "BUFF"},
			-- Seal of Righteousness
			{spellID = 21084, unitID = "player", caster = "player", filter = "BUFF"},
			-- Seal of Vengeance
			{spellID = 31801, unitID = "player", caster = "player", filter = "BUFF"},
			-- Seal of Wisdom
			{spellID = 20166, unitID = "player", caster = "player", filter = "BUFF"},
			-- Seal of the Crusader
			{spellID = 21082, unitID = "player", caster = "player", filter = "BUFF"},
			-- Seal of the Martyr
			{spellID = 348700, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadow Resistance Aura
			-- {spellID = 19876, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vengeance r1
			{spellID = 20050, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Vengeance r2
			{spellID = 20052, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Vengeance r3
			{spellID = 20053, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Vengeance r4
			{spellID = 20054, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Vengeance r5
			{spellID = 20055, unitID = "player", caster = "player", filter = "BUFF", absID = true},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = C.filger.buffs_space,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Buffs
			-- Reckoning
			{spellID = 20178, unitID = "player", caster = "player", filter = "BUFF"},
			-- Redoubt
			{spellID = 20128, unitID = "player", caster = "player", filter = "BUFF"},

			-- Item Sets
			-- Crusader's Wrath (Spell Power, Proc) [Lightforge Armor / Soulforge Armor]
			{spellID = 27499, unitID = "player", caster = "player", filter = "BUFF"},
			-- Enlightenment (Special, Proc) [Crystalforge Raiment]
			-- {spellID = 43837, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Heroic Resolution (Attack Power, Proc) [Desolation Battlegear / Doomplate Battlegear / Wastewalker Armor]
			{spellID = 37612, unitID = "player", caster = "player", filter = "BUFF"},
			-- Infused Shield (Special, Proc) [Crystalforge Armor]
			{spellID = 37193, unitID = "player", caster = "player", filter = "BUFF"},
			-- Insight (Spell Power, Proc) [Mana-Etched Regalia]
			{spellID = 37620, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Lesser Spell Blasting (Spell Power, Proc) [Spellstrike Infusion]
			{spellID = 32108, unitID = "player", caster = "player", filter = "BUFF"},

			-- Librams
			-- Bulwark of the Lightbringer (Block Value, Judgement) [Tome of the Lightbringer]
			{spellID = 41043, unitID = "player", caster = "player", filter = "BUFF"},
			-- Crusader's Command (Attack Power, Judgement of Command) [Libram of Divine Judgement]
			{spellID = 43747, unitID = "player", caster = "player", filter = "BUFF"},
			-- Grace of the Naaru (Mp5, Holy Light) [Libram of Mending]
			{spellID = 43742, unitID = "player", caster = "player", filter = "BUFF"},
			-- Justice (Critical Strike, JoC/JoR/JoB/JoV) [Libram of Avengement]
			{spellID = 34260, unitID = "player", caster = "player", filter = "BUFF"},
			-- Resilient (Resilience, Judgement/Holy Shield) [Libram of Fortitude / Libram of Vengeance]
			{spellID = 43839, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- Class
			-- Blessing of Righteousness (Spell Power, Proc) [Tome of Fiery Redemption]
			{spellID = 37198, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blinding Light (Haste, Use) [Tome of Fiery Redemption]
			{spellID = 23733, unitID = "player", caster = "player", filter = "BUFF"},
			-- Brilliant Light (Spell Critical Strike, Use) [Gri'lek's Charm of Valor]
			{spellID = 24498, unitID = "player", caster = "player", filter = "BUFF"},

			-- Darkmoon Cards
			-- Aura of the Blue Dragon (Special, Proc) [Darkmoon Card: Blue Dragon]
			{spellID = 23684, unitID = "player", caster = "player", filter = "BUFF"},
			-- Aura of the Crusader (Attack Power, Proc) [Darkmoon Card: Crusade]
			{spellID = 39439, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Aura of the Crusader (Spell Power, Proc) [Darkmoon Card: Crusade]
			{spellID = 39441, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Aura of Wrath (Critical Strike, Proc) [Darkmoon Card: Wrath]
			{spellID = 39443, unitID = "player", caster = "player", filter = "BUFF"},
			-- Delusional (Attack Power, Proc) [Darkmoon Card: Madness] - Rogue, Hunter, Paladin, Warrior, Druid, Shaman
			{spellID = 40997, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dementia (Special Power, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin
			{spellID = 41404, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Dementia +5% (Special Power, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin
			{spellID = 41406, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Dementia -5% (Special Power, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin
			{spellID = 41409, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Kleptomania (Agility, Proc) [Darkmoon Card: Madness] - Warrior, Rogue, Paladin, Hunter, Druid
			{spellID = 40998, unitID = "player", caster = "player", filter = "BUFF"},
			-- Manic (Haste, Proc) [Darkmoon Card: Madness] - All classes except Hunter
			{spellID = 41005, unitID = "player", caster = "player", filter = "BUFF"},
			-- Martyr Complex (Stamina, Proc) [Darkmoon Card: Madness] - All classes
			{spellID = 41011, unitID = "player", caster = "player", filter = "BUFF"},
			-- Megalomania (Spell Power, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin
			{spellID = 40999, unitID = "player", caster = "player", filter = "BUFF"},
			-- Narcissism (Intellect, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin, Hunter
			{spellID = 41009, unitID = "player", caster = "player", filter = "BUFF"},
			-- Paranoia (Critical Strike, Proc) [Darkmoon Card: Madness] - All classes except Hunter
			{spellID = 41002, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Sociopath (Strength, Proc) [Darkmoon Card: Madness] - Paladin, Rogue, Druid, Warrior
			{spellID = 39511, unitID = "player", caster = "player", filter = "BUFF"},

			-- PvP Trinkets
			-- Aura of Protection (Absorb, Use) [Arena Grand Master]
			{spellID = 23506, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage Absorb (Absorb, Use) [Arathi Basin Trinket]
			{spellID = 25750, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tremendous Fortitude (Health, Use) [Battlemaster]
			{spellID = 44055, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shell of Deterrence (Absorb, Use) [Runed Fungalcap]
			{spellID = 31771, unitID = "player", caster = "player", filter = "BUFF"},

			-- Universal
			-- Arcane Shroud (Threat Reduction, Use) [Fetish of the Sand Reaver]
			{spellID = 26400, unitID = "player", caster = "player", filter = "BUFF"},
			-- Chitinous Spikes (Special, Use) [Fetish of Chitinous Spikes]
			{spellID = 26168, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of the Scale (Special, Use) [Heart of the Scale]
			{spellID = 17275, unitID = "player", caster = "player", filter = "BUFF"},
			-- Loatheb's Reflection (Magic Resistance, Use) [Loatheb's Reflection]
			{spellID = 28778, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mercurial Shield (Magic Resistance, Use) [Petrified Scarab]
			{spellID = 26464, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Burrower's Shell (Absorb, Use) [The Burrower's Shell]
			{spellID = 29506, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Lion Horn of Stormwind (Special, Proc) [The Lion Horn of Stormwind]
			{spellID = 18946, unitID = "player", caster = "player", filter = "BUFF"},

			-- Tanking
			-- Adamantine Shell (Armor, Use) [Adamantine Figurine]
			{spellID = 33479, unitID = "player", caster = "player", filter = "BUFF"},
			-- Argussian Compass (Absorb, Use) [Argussian Compass]
			{spellID = 39228, unitID = "player", caster = "player", filter = "BUFF"},
			-- Avoidance (Dodge, Use) [Charm of Alacrity]
			{spellID = 32600, unitID = "player", caster = "player", filter = "BUFF"},
			-- Brittle Armor (Special, Use) [Zandalarian Hero Badge]
			{spellID = 24575, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dark Iron Luck (Block Value, Use) [Coren's Lucky Coin]
			{spellID = 51952, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dawnstone Crab (Dodge, Use) [Figurine - Dawnstone Crab]
			{spellID = 31039, unitID = "player", caster = "player", filter = "BUFF"},
			-- Displacement (Defense Rating, Use) [Scarab of Displacement]
			{spellID = 38351, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Empyrean Tortoise (Dodge, Use) [Figurine - Empyrean Tortoise]
			{spellID = 46780, unitID = "player", caster = "player", filter = "BUFF"},
			-- Evasive Maneuvers (Dodge, Proc) [Commendation of Kael'thas]
			{spellID = 45058, unitID = "player", caster = "player", filter = "BUFF"},
			-- Force of Will (Special, Proc) [Force of Will]
			{spellID = 15595, unitID = "player", caster = "player", filter = "BUFF"},
			-- Glyph of Deflection (Block Value, Use) [Glyph of Deflection]
			{spellID = 28773, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gnome Ingenuity (Block Value, Use) [Gnomeregan Auto-Blocker 600]
			{spellID = 35169, unitID = "player", caster = "player", filter = "BUFF"},
			-- Hardened Skin (Armor, Use) [Ancient Aqir Artifact]
			{spellID = 43713, unitID = "player", caster = "player", filter = "BUFF"},
			-- Phalanx (Block Rating, Use) [Dabiri's Enigma]
			{spellID = 36372, unitID = "player", caster = "player", filter = "BUFF"},
			-- Protector's Vigor (Health, Use) [Shadowmoon Insignia]
			{spellID = 40464, unitID = "player", caster = "player", filter = "BUFF"},
			-- Regeneration (HoT, Use) [Spyglass of the Hidden Fleet]
			-- {spellID = 38325, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Tenacity (Health, Use) [Brooch of the Immortal King]
			-- {spellID = 40538, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Tenacity (Health, Use) [Regal Protectorate]
			{spellID = 33668, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Tenacity (Health, Use) [Steely Naaru Sliver]
			-- {spellID = 45049, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Time's Favor (Dodge, Use) [Moroes' Lucky Pocket Watch]
			{spellID = 34519, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vigilance of the Colossus (Special, Use) [Figurine of the Colossus]
			{spellID = 33089, unitID = "player", caster = "player", filter = "BUFF"},

			-- Damage [Physical]
			-- Ancient Power (Attack Power, Use) [Core of Ar'kelos]
			{spellID = 35733, unitID = "player", caster = "player", filter = "BUFF"},
			-- Armor Penetration (Armor Penetration, Use) [Icon of Unyielding Courage]
			{spellID = 34106, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Battle Trance (Attack Power, Proc) [Blackened Naaru Sliver]
			{spellID = 45040, unitID = "player", caster = "player", filter = "BUFF"},
			-- Burning Hatred (Attack Power, Use) [Ogre Mauler's Badge / Uniting Charm]
			{spellID = 32362, unitID = "player", caster = "player", filter = "BUFF"},
			-- Call of the Berserker (Attack Power, Use) [Berserker's Call]
			{spellID = 43716, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combat Insight (Attack Power, Proc) [Blackened Naaru Sliver]
			{spellID = 45041, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combat Valor (Attack Power, Proc) [Skyguard Silver Cross]
			{spellID = 41261, unitID = "player", caster = "player", filter = "BUFF"},
			-- Consume Life (Special, Use) [Fetish of the Fallen]
			{spellID = 33015, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Dire Drunkard (Attack Power, Use) [Empty Mug of Direbrew]
			{spellID = 51955, unitID = "player", caster = "player", filter = "BUFF"},
			-- Disdain (Attack Power, Proc) [Shard of Contempt]
			{spellID = 45053, unitID = "player", caster = "player", filter = "BUFF"},
			-- Earthstrike (Attack Power, Use) [Earthstrike]
			{spellID = 25891, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ferocity (Attack Power, Use) [Ancient Draenei War Talisman / Bladefist's Breadth]
			{spellID = 33667, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Forceful Strike (Armor Penetration, Proc) [Madness of the Betrayer]
			{spellID = 40477, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fury of the Crashing Waves (Attack Power, Proc) [Tsunami Talisman]
			{spellID = 42084, unitID = "player", caster = "player", filter = "BUFF"},
			--[[
			-- Haste (Physical Haste, Use) [Abacus of Violent Odds]
			{spellID = 33807, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Haste (Physical Haste, Proc) [Dragonspine Trophy]
			{spellID = 34775, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			--]]
			-- Heightened Reflexes (Agility, Use) [Badge of Tenacity]
			{spellID = 40729, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heroism (Attack Power, Use) [Terokkar Tablet of Precision]
			-- {spellID = 39200, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Insight of the Qiraji (Armor Penetration, Use) [Badge of the Swarmguard]
			{spellID = 26481, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jom Gabbar (Attack Power, Use) [Jom Gabbar]
			{spellID = 29604, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Kiss of the Spider (Physical Haste, Use) [Kiss of the Spider]
			{spellID = 28866, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lust for Battle (Attack Power, Use) [Bloodlust Brooch]
			{spellID = 35166, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nightseye Panther (Attack Power, Use) [Figurine - Nightseye Panther]
			{spellID = 31047, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rage of the Unraveller (Attack Power, Proc) [Hourglass of the Unraveller]
			{spellID = 33649, unitID = "player", caster = "player", filter = "BUFF"},
			-- Restless Strength (Special, Use) [Zandalarian Hero Medallion]
			{spellID = 24662, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadowsong Panther (Attack Power, Use) [Figurine - Shadowsong Panther]
			{spellID = 46784, unitID = "player", caster = "player", filter = "BUFF"},
			-- Slayer's Crest (Attack Power, Use) [Slayer's Crest]
			{spellID = 28777, unitID = "player", caster = "player", filter = "BUFF"},
			-- Valor (Attack Power, Use) [Crystalforged Trinket]
			{spellID = 40724, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- Damage [Magic]
			-- Arcane Energy (Healing Power, Use) [Ancient Draenei Arcane Relic / Vengeance of the Illidari]
			{spellID = 33662, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ascendance (Spell Power, Use) [Talisman of Ascendance]
			{spellID = 28204, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Blessing of the Silver Crescent (Spell Power, Use) [Icon of the Silver Crescent]
			{spellID = 35163, unitID = "player", caster = "player", filter = "BUFF"},
			-- Call of the Nexus (Spell Power, Proc) [Shiffar's Nexus-Horn]
			{spellID = 34321, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combat Gallantry (Spell Power, Proc) [Airman's Ribbon of Gallantry]
			{spellID = 41263, unitID = "player", caster = "player", filter = "BUFF"},
			-- Consume Essence (Special, Use) [Oculus of the Hidden Eye]
			{spellID = 33013, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Crimson Serpent (Spell Power, Use) [Figurine - Crimson Serpent]
			{spellID = 46783, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dark Iron Pipeweed (Spell Power, Use) [Dark Iron Smoking Pipe]
			{spellID = 51953, unitID = "player", caster = "player", filter = "BUFF"},
			-- Electrical Charge (Special, Proc) [The Lightning Capacitor]
			{spellID = 37658, unitID = "player", caster = "player", filter = "BUFF"},
			-- Enlightenment (Mana Regeneration, Use) [Pendant of the Violet Eye]
			{spellID = 35095, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Ephemeral Power (Spell Power, Use) [Talisman of Ephemeral Power]
			{spellID = 23271, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of Sapphiron (Spell Power, Use) [The Restrained Essence of Sapphiron]
			{spellID = 28779, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fel Infusion (Spell Haste, Use) [The Skull of Gul'dan]
			{spellID = 40396, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Focused Power (Spell Power, Use) [Ancient Crystal Talisman / Glowing Crystal Insignia]
			{spellID = 32355, unitID = "player", caster = "player", filter = "BUFF"},
			-- Living Ruby Serpent (Spell Power, Use) [Figurine - Living Ruby Serpent]
			{spellID = 31040, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mojo Madness (Spell Power, Use) [Hex Shrunken Head]
			{spellID = 43712, unitID = "player", caster = "player", filter = "BUFF"},
			-- Obsidian Insight (Spell Power, Special, Use) [Eye of Moam]
			{spellID = 26166, unitID = "player", caster = "player", filter = "BUFF"},
			-- Pagle's Broken Reel (Spell Hit, Use) [Nat Pagle's Broken Reel]
			{spellID = 24610, unitID = "player", caster = "player", filter = "BUFF"},
			-- Power Circle (Spell Power, Use) [Shifting Naaru Sliver]
			{spellID = 45043, unitID = "player", caster = "player", filter = "BUFF"},
			-- Recurring Power (Spell Power, Proc) [Eye of Magtheridon]
			{spellID = 34747, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spell Haste (Spell Haste, Proc) [Quagmirran's Eye]
			{spellID = 33370, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Spell Power (Spell Power, Use) [Scryer's Bloodgem / Xi'ri's Gift]
			{spellID = 35337, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			--[[
			-- Spell Power (Spell Power, Use) [Starkiller's Bauble]
			{spellID = 36432, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Spell Power (Spell Power, Use) [Terokkar Tablet of Vim]
			{spellID = 39201, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			--]]
			-- The Arcanist's Stone (Spell Power, Use) [Arcanist's Stone]
			{spellID = 34000, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Eye of Diminution (Special, Use) [Eye of Diminution]
			{spellID = 28862, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unstable Currents (Spell Power, Proc) [Sextant of Unstable Currents]
			{spellID = 38348, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unstable Power (Spell Power, Use) [Zandalarian Hero Charm]
			{spellID = 24659, unitID = "player", caster = "player", filter = "BUFF"},

			-- Healing
			-- Accelerated Mending (Healing Power, Use) [Warp-Scarab Brooch]
			{spellID = 33400, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blessing of Faith (Special, Use) [Lower City Prayerbook]
			{spellID = 37877, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blessing of Life (Special, Use) [Ribbon of Sacrifice]
			{spellID = 38332, unitID = "target", caster = "player", filter = "BUFF"},
			-- Chromatic Infusion (Healing Power, Use) [Draconic Infused Emblem]
			{spellID = 27675, unitID = "player", caster = "player", filter = "BUFF"},
			-- Deep Meditation (Spirit, Use) [Earring of Soulful Meditation]
			{spellID = 40402, unitID = "player", caster = "player", filter = "BUFF"},
			-- Diabolic Remedy (Healing Power, Use) [Tome of Diabolic Remedy]
			{spellID = 43710, unitID = "player", caster = "player", filter = "BUFF"},
			-- Endless Blessings (Spirit, Use) [Bangle of Endless Blessings]
			{spellID = 34210, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of the Martyr (Healing Power, Use) [Essence of the Martyr]
			{spellID = 35165, unitID = "player", caster = "player", filter = "BUFF"},
			-- Evocation (Mana Regeneration, Use) [Glimmering Naaru Sliver]
			{spellID = 45052, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Focused Mind (Special, Use) [Auslese's Light Channeler]
			{spellID = 31794, unitID = "player", caster = "player", filter = "BUFF"},
			-- Healing of the Ages (Healing Power, Use) [Hibernation Crystal]
			{spellID = 24998, unitID = "player", caster = "player", filter = "BUFF"},
			-- Healing Power (Healing Power, Use) [Heavenly Inspiration]
			{spellID = 36347, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Holy Energy (Special, Use) [Vial of the Sunwell]
			{spellID = 45062, unitID = "player", caster = "player", filter = "BUFF"},
			-- Hopped Up (Healing Power, Use) [Direbrew Hops]
			{spellID = 51954, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mar'li's Brain Boost (Mp5, Use) [Mar'li's Eye]
			{spellID = 24268, unitID = "player", caster = "player", filter = "BUFF"},
			-- Meditation (Special, Proc) [Bangle of Endless Blessings]
			{spellID = 38346, unitID = "player", caster = "player", filter = "BUFF"},
			-- Persistent Shield (Absorb, Use) [Scarab Brooch]
			{spellID = 26467, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Power of Prayer (Healing Power, Use) [Oshu'gun Relic]
			{spellID = 32367, unitID = "player", caster = "player", filter = "BUFF"},
			-- Seaspray Albatross (Mana Regeneration, Use) [Figurine - Seaspray Albatross]
			{spellID = 46785, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spell Haste (Spell Haste, Proc) [Scarab of the Infinite Cycle]
			-- {spellID = 33370, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Talasite Owl (Mana Regeneration, Use) [Figurine - Talasite Owl]
			{spellID = 31045, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Eye of the Dead (Special, Use) [Eye of the Dead]
			{spellID = 28780, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wisdom (Mana Regeneration, Proc) [Memento of Tyrande]
			{spellID = 37656, unitID = "player", caster = "player", filter = "BUFF"},

			-- Helms
			-- Arcane Might (Spell Power, Proc) [Circlet of Arcane Might]
			{spellID = 31037, unitID = "player", caster = "player", filter = "BUFF"},

			-- Necks
			-- Arcane Insight (Expertise, Proc) [Shattered Sun Pendant of Resolve - Scryer]
			{spellID = 45431, unitID = "player", caster = "player", filter = "BUFF"},
			-- Light's Salvation (Healing Power, Proc) [Shattered Sun Pendant of Restoration - Aldor]
			{spellID = 45478, unitID = "player", caster = "player", filter = "BUFF"},
			-- Light's Strength (Attack Power, Proc) [Shattered Sun Pendant of Might - Aldor]
			{spellID = 45480, unitID = "player", caster = "player", filter = "BUFF"},
			-- Light's Ward (Dodge, Proc) [Shattered Sun Pendant of Resolve - Aldor]
			{spellID = 45432, unitID = "player", caster = "player", filter = "BUFF"},
			-- Light's Wrath (Spell Power, Proc) [Shattered Sun Pendant of Acumen - Aldor]
			{spellID = 45479, unitID = "player", caster = "player", filter = "BUFF"},

			-- Chest
			-- Valor (Health, Strength, Use) [Bulwark of Kings / Bulwark of the Ancient Kings]
			-- {spellID = 34511, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- Rings
			-- Band of the Eternal Champion (Attack Power, Proc) [Band of the Eternal Champion]
			{spellID = 35081, unitID = "player", caster = "player", filter = "BUFF"},
			-- Band of the Eternal Defender (Armor, Proc) [Band of the Eternal Defender]
			{spellID = 35078, unitID = "player", caster = "player", filter = "BUFF"},
			-- Band of the Eternal Restorer (Healing Power, Proc) [Band of the Eternal Restorer]
			{spellID = 35087, unitID = "player", caster = "player", filter = "BUFF"},
			-- Band of the Eternal Sage (Spell Power, Proc) [Band of the Eternal Sage]
			{spellID = 35084, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spell Blasting (Spell Power, Proc) [Wrath of Cenarius]
			{spellID = 25906, unitID = "player", caster = "player", filter = "BUFF"},

			-- Weapons
			-- Armor Buff (Armor, Proc) [Greatsword of Forlorn Visions]
			{spellID = 34199, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blinding Speed (Physical Haste, Proc) [Blackout Truncheon]
			{spellID = 33489, unitID = "player", caster = "player", filter = "BUFF"},
			-- Haste (Physical Haste, Proc) [Manual Crowd Pummeler]
			{spellID = 13494, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Haste (Physical Haste, Proc) [Empyrean Demolisher / Drakefist Hammer / Dragonmaw / Dragonstrike]
			{spellID = 21165, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Speed Infusion (Movement Speed, Physical Attack Speed, Proc) [Devastation / Warp Slicer]
			{spellID = 36479, unitID = "player", caster = "player", filter = "BUFF"},
			-- Strength of the Champion (Strength, Proc) [Arcanite Champion / Khorium Champion]
			{spellID = 16916, unitID = "player", caster = "player", filter = "BUFF"},
			-- World Breaker (Physical Critical Strike, Proc) [World Breaker]
			{spellID = 36111, unitID = "player", caster = "player", filter = "BUFF"},

			-- Meta Gems
			-- Focus (Spell Haste, Proc) [Mystical Skyfire Diamond]
			{spellID = 18803, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Skyfire Swiftness (Physical Haste, Proc) [Thundering Skyfire Diamond]
			{spellID = 39959, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Executioner [Enchant Weapon - Executioner]
			{spellID = 42976, unitID = "player", caster = "player", filter = "BUFF"},
			-- Holy Strength (Strength) [Enchant Weapon - Crusader]
			{spellID = 20007, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lightning Speed (Agility and Physical Attack Speed) [Enchant Weapon - Mongoose]
			{spellID = 28093, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spellsurge (Mana Regeneration to Party) [Enchant Weapon - Spellsurge]
			{spellID = 27996, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = C.filger.buffs_space,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Avenger's Shield
			{spellID = 31935, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Blood Corruption
			{spellID = 356110, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Consecration
			{spellID = 26573, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Hammer of Justice
			{spellID = 853, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Holy Vengeance
			{spellID = 31803, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Judgement of Justice
			{spellID = 20184, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Judgement of Light
			{spellID = 20185, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Judgement of Wisdom
			{spellID = 20186, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Judgement of the Crusader
			{spellID = 21183, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Repentance
			{spellID = 20066, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Seal of Justice (Stun)
			{spellID = 20170, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Vindication
			{spellID = 67, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Trinket Effects
			-- Enduring Judgement (DoT, Proc) [Ashtongue Talisman of Zeal]
			{spellID = 40471, unitID = "target", caster = "player", filter = "DEBUFF"},

			-- Enchants
			-- Chilled [Enchant Weapon - Icy Chill]
			{spellID = 20005, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Deathfrost [Enchant Weapon - Deathfrost]
			{spellID = 46629, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Smite Demon [Enchant Weapon - Demonslaying]
			{spellID = 13907, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Unholy Curse [Enchant Weapon - Unholy Weapon]
			{spellID = 20006, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Venomhide Poison
			{spellID = 14795, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {"LEFT", T_DE_BUFF_BAR_Anchor},

			-- Enduring Light (HoT, Proc) [Ashtongue Talisman of Zeal]
			{spellID = 40471, unitID = "target", caster = "player", filter = "BUFF"},
			-- Holy Power (Armor, Proc) [Redemption Armor]
			{spellID = 28790, unitID = "target", caster = "player", filter = "BUFF", absID = true},
			-- Holy Power (Attack Power, Proc) [Redemption Armor]
			{spellID = 28791, unitID = "target", caster = "player", filter = "BUFF", absID = true},
			-- Holy Power (Mp5, Proc) [Redemption Armor]
			{spellID = 28795, unitID = "target", caster = "player", filter = "BUFF", absID = true},
			-- Holy Power (Spell Power, Proc) [Redemption Armor]
			{spellID = 28793, unitID = "target", caster = "player", filter = "BUFF", absID = true},
			-- Libram of Justice
			{spellID = 34135, unitID = "target", caster = "player", filter = "BUFF"},
			-- Merciless Libram of Justice
			{spellID = 42369, unitID = "target", caster = "player", filter = "BUFF"},
			-- Vengeful Libram of Justice
			{spellID = 43727, unitID = "target", caster = "player", filter = "BUFF"},
			-- Brutal Libram of Justice
			{spellID = 46093, unitID = "target", caster = "player", filter = "BUFF"},

			-- Trinket Effects
			-- Fecundity (Special, Use) [Ribbon of Sacrifice]
			{spellID = 38333, unitID = "target", caster = "player", filter = "BUFF"},
			-- Persistent Shield (Absorb, Use) [Scarab Brooch]
			{spellID = 26470, unitID = "target", caster = "player", filter = "BUFF", absID = true},
			-- Regeneration (HoT, Proc) [Fel Reaver's Piston]
			{spellID = 38324, unitID = "target", caster = "player", filter = "BUFF", absID = true},
		},
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {"LEFT", PVE_PVP_CC_Anchor},

			-- Turn Evil
			{spellID = 10326, unitID = "focus", caster = "all", filter = "DEBUFF"},
			-- Turn Undead r1
			{spellID = 2878, unitID = "focus", caster = "all", filter = "DEBUFF", absID = true},
			-- Turn Undead r2
			{spellID = 5627, unitID = "focus", caster = "all", filter = "DEBUFF", absID = true},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = C.filger.cooldown_space,
			Alpha = 1,
			IconSize = C.filger.cooldown_size,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Self
			-- Avenger's Shield
			{spellID = 31935, filter = "CD"},
			-- Avenging Wrath
			{spellID = 31884, filter = "CD"},
			-- Blessing of Freedom
			{spellID = 1044, filter = "CD"},
			-- Blessing of Protection
			{spellID = 1022, filter = "CD"},
			-- Blessing of Sacrifice
			{spellID = 6940, filter = "CD"},
			-- Consecration
			{spellID = 26573, filter = "CD"},
			-- Crusader Strike
			{spellID = 35395, filter = "CD"},
			-- Divine Favor
			{spellID = 20216, filter = "CD"},
			-- Divine Illumination
			{spellID = 31842, filter = "CD"},
			-- Divine Intervention
			{spellID = 19752, filter = "CD"},
			-- Divine Protection
			{spellID = 498, filter = "CD", absID = true},
			-- Divine Shield
			{spellID = 642, filter = "CD"},
			-- Exorcism
			{spellID = 879, filter = "CD"},
			-- Hammer of Justice
			{spellID = 853, filter = "CD"},
			-- Hammer of Wrath
			{spellID = 24275, filter = "CD"},
			-- Holy Shield
			{spellID = 20925, filter = "CD", absID = true},
			-- Holy Shock
			{spellID = 20473, filter = "CD"},
			-- Holy Wrath
			{spellID = 2812, filter = "CD"},
			-- Judgement
			{spellID = 20271, filter = "CD", absID = true},
			-- Lay on Hands
			{spellID = 633, filter = "CD"},
			-- Repentance
			{spellID = 20066, filter = "CD"},
			-- Righteous Defense
			{spellID = 31789, filter = "CD"},
			-- Turn Evil
			{spellID = 10326, filter = "CD"},
			-- Turn Undead
			{spellID = 2878, filter = "CD"},

			-- Racial
			-- Arcane Torrent (Mana)
			{spellID = 28730, filter = "CD", absID = true},
			-- Gift of the Naaru (Draenei)
			{spellID = 28880, filter = "CD"},
			-- Perception (Human)
			{spellID = 20600, filter = "CD"},
			-- Stoneform (Dwarf)
			{spellID = 20594, filter = "CD"},

			-- Items
			-- Back
			{slotID = 15, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Neck
			{slotID = 2, filter = "CD"},
			-- Rings
			{slotID = 11, filter = "CD"},
			{slotID = 12, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},
		},
	},
	["PRIEST"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = C.filger.buffs_space,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Elune's Grace
			{spellID = 2651, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fade r1
			{spellID = 586, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Fade r2
			{spellID = 9578, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Fade r3
			{spellID = 9579, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Fade r4
			{spellID = 9592, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Fade r5
			{spellID = 10941, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Fade r6
			{spellID = 10942, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Fade r7
			{spellID = 25429, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Feedback
			{spellID = 13896, unitID = "player", caster = "player", filter = "BUFF"},
			-- Inner Fire
			{spellID = 588, unitID = "player", caster = "player", filter = "BUFF"},
			-- Inner Focus
			{spellID = 14751, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadowform
			{spellID = 15473, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadowguard
			{spellID = 18137, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spirit of Redemption
			{spellID = 27827, unitID = "player", caster = "player", filter = "BUFF"},
			-- Touch of Weakness
			{spellID = 2652, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vampiric Embrace
			-- {spellID = 15290, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vampiric Touch
			-- {spellID = 34919, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = C.filger.buffs_space,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Buffs
			-- Blessed Recovery
			{spellID = 27813, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blessed Resilience
			{spellID = 33143, unitID = "player", caster = "player", filter = "BUFF"},
			-- Focused Will
			{spellID = 45237, unitID = "player", caster = "player", filter = "BUFF"},
			-- Clearcasting [Holy Concentration]
			{spellID = 34754, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Focused Casting [Martyrdom]
			{spellID = 14743, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spirit Tap
			{spellID = 15271, unitID = "player", caster = "player", filter = "BUFF"},
			-- Surge of Light
			{spellID = 33151, unitID = "player", caster = "player", filter = "BUFF"},

			-- Item Sets
			-- Divine Protection (Absorb, Proc) [Vestments of the Devout / Vestments of the Virtuous]
			{spellID = 27779, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Epiphany (Mp5, Proc) [Vestments of Faith]
			{spellID = 28804, unitID = "player", caster = "player", filter = "BUFF"},
			-- Flexibility (Special, Proc) [Incarnate Raiment]
			{spellID = 37565, unitID = "player", caster = "player", filter = "BUFF"},
			-- Insight (Spell Power, Proc) [Mana-Etched Regalia]
			{spellID = 37620, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Lesser Spell Blasting (Spell Power, Proc) [Spellstrike Infusion]
			{spellID = 32108, unitID = "player", caster = "player", filter = "BUFF"},
			-- Reactive Fade (Special, Proc) [Vestments of Transcendence]
			{spellID = 21976, unitID = "player", caster = "player", filter = "BUFF"},
			-- Relentlessness (Special, Proc) [Avatar Regalia]
			{spellID = 37601, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sadist (Spell Power, Proc) [Avatar Regalia]
			{spellID = 37604, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- Class
			-- Aegis of Preservation (Special, Use) [Aegis of Preservation]
			{spellID = 23780, unitID = "player", caster = "player", filter = "BUFF"},
			-- Deep Meditation (Spirit, Use) [Earring of Soulful Meditation]
			{spellID = 40402, unitID = "player", caster = "player", filter = "BUFF"},
			-- Divine Blessing (Healing Power, Proc) [Ashtongue Talisman of Acumen]
			{spellID = 40440, unitID = "player", caster = "player", filter = "BUFF"},
			-- Divine Wrath (Healing Power, Proc) [Ashtongue Talisman of Acumen]
			{spellID = 40441, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rapid Healing (Special, Use) [Hazza'rah's Charm of Healing]
			{spellID = 24546, unitID = "player", caster = "player", filter = "BUFF"},

			-- Darkmoon Cards
			-- Aura of the Blue Dragon (Special, Proc) [Darkmoon Card: Blue Dragon]
			{spellID = 23684, unitID = "player", caster = "player", filter = "BUFF"},
			-- Aura of the Crusader (Spell Power, Proc) [Darkmoon Card: Crusade]
			{spellID = 39441, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Aura of Wrath (Critical Strike, Proc) [Darkmoon Card: Wrath]
			{spellID = 39443, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dementia (Special Power, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin
			{spellID = 41404, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Dementia +5% (Special Power, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin
			{spellID = 41406, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Dementia -5% (Special Power, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin
			{spellID = 41409, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Manic (Haste, Proc) [Darkmoon Card: Madness] - All classes except Hunter
			{spellID = 41005, unitID = "player", caster = "player", filter = "BUFF"},
			-- Martyr Complex (Stamina, Proc) [Darkmoon Card: Madness] - All classes
			{spellID = 41011, unitID = "player", caster = "player", filter = "BUFF"},
			-- Megalomania (Spell Power, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin
			{spellID = 40999, unitID = "player", caster = "player", filter = "BUFF"},
			-- Narcissism (Intellect, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin, Hunter
			{spellID = 41009, unitID = "player", caster = "player", filter = "BUFF"},
			-- Paranoia (Critical Strike, Proc) [Darkmoon Card: Madness] - All classes except Hunter
			{spellID = 41002, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- PvP Trinkets
			-- Aura of Protection (Absorb, Use) [Arena Grand Master]
			{spellID = 23506, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage Absorb (Absorb, Use) [Arathi Basin Trinket]
			{spellID = 25750, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tremendous Fortitude (Health, Use) [Battlemaster]
			{spellID = 44055, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shell of Deterrence (Absorb, Use) [Runed Fungalcap]
			{spellID = 31771, unitID = "player", caster = "player", filter = "BUFF"},

			-- Universal
			-- Arcane Shroud (Threat Reduction, Use) [Fetish of the Sand Reaver]
			{spellID = 26400, unitID = "player", caster = "player", filter = "BUFF"},
			-- Chitinous Spikes (Special, Use) [Fetish of Chitinous Spikes]
			{spellID = 26168, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of the Scale (Special, Use) [Heart of the Scale]
			{spellID = 17275, unitID = "player", caster = "player", filter = "BUFF"},
			-- Loatheb's Reflection (Magic Resistance, Use) [Loatheb's Reflection]
			{spellID = 28778, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mercurial Shield (Magic Resistance, Use) [Petrified Scarab]
			{spellID = 26464, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Burrower's Shell (Absorb, Use) [The Burrower's Shell]
			{spellID = 29506, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Lion Horn of Stormwind (Special, Proc) [The Lion Horn of Stormwind]
			{spellID = 18946, unitID = "player", caster = "player", filter = "BUFF"},

			-- Damage [Magic]
			-- Arcane Energy (Healing Power, Use) [Ancient Draenei Arcane Relic / Vengeance of the Illidari]
			{spellID = 33662, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ascendance (Spell Power, Use) [Talisman of Ascendance]
			{spellID = 28204, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Blessing of the Silver Crescent (Spell Power, Use) [Icon of the Silver Crescent]
			{spellID = 35163, unitID = "player", caster = "player", filter = "BUFF"},
			-- Call of the Nexus (Spell Power, Proc) [Shiffar's Nexus-Horn]
			{spellID = 34321, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combat Gallantry (Spell Power, Proc) [Airman's Ribbon of Gallantry]
			{spellID = 41263, unitID = "player", caster = "player", filter = "BUFF"},
			-- Consume Essence (Special, Use) [Oculus of the Hidden Eye]
			{spellID = 33013, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Crimson Serpent (Spell Power, Use) [Figurine - Crimson Serpent]
			{spellID = 46783, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dark Iron Pipeweed (Spell Power, Use) [Dark Iron Smoking Pipe]
			{spellID = 51953, unitID = "player", caster = "player", filter = "BUFF"},
			-- Electrical Charge (Special, Proc) [The Lightning Capacitor]
			{spellID = 37658, unitID = "player", caster = "player", filter = "BUFF"},
			-- Enlightenment (Mana Regeneration, Use) [Pendant of the Violet Eye]
			{spellID = 35095, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Ephemeral Power (Spell Power, Use) [Talisman of Ephemeral Power]
			{spellID = 23271, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of Sapphiron (Spell Power, Use) [The Restrained Essence of Sapphiron]
			{spellID = 28779, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fel Infusion (Spell Haste, Use) [The Skull of Gul'dan]
			{spellID = 40396, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Focused Power (Spell Power, Use) [Ancient Crystal Talisman / Glowing Crystal Insignia]
			{spellID = 32355, unitID = "player", caster = "player", filter = "BUFF"},
			-- Living Ruby Serpent (Spell Power, Use) [Figurine - Living Ruby Serpent]
			{spellID = 31040, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mojo Madness (Spell Power, Use) [Hex Shrunken Head]
			{spellID = 43712, unitID = "player", caster = "player", filter = "BUFF"},
			-- Obsidian Insight (Spell Power, Special, Use) [Eye of Moam]
			{spellID = 26166, unitID = "player", caster = "player", filter = "BUFF"},
			-- Pagle's Broken Reel (Spell Hit, Use) [Nat Pagle's Broken Reel]
			{spellID = 24610, unitID = "player", caster = "player", filter = "BUFF"},
			-- Power Circle (Spell Power, Use) [Shifting Naaru Sliver]
			{spellID = 45043, unitID = "player", caster = "player", filter = "BUFF"},
			-- Recurring Power (Spell Power, Proc) [Eye of Magtheridon]
			{spellID = 34747, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spell Haste (Spell Haste, Proc) [Quagmirran's Eye]
			{spellID = 33370, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Spell Power (Spell Power, Use) [Scryer's Bloodgem / Xi'ri's Gift]
			{spellID = 35337, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			--[[
			-- Spell Power (Spell Power, Use) [Starkiller's Bauble]
			{spellID = 36432, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Spell Power (Spell Power, Use) [Terokkar Tablet of Vim]
			{spellID = 39201, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			--]]
			-- The Arcanist's Stone (Spell Power, Use) [Arcanist's Stone]
			{spellID = 34000, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Eye of Diminution (Special, Use) [Eye of Diminution]
			{spellID = 28862, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unstable Currents (Spell Power, Proc) [Sextant of Unstable Currents]
			{spellID = 38348, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unstable Power (Spell Power, Use) [Zandalarian Hero Charm]
			{spellID = 24659, unitID = "player", caster = "player", filter = "BUFF"},

			-- Healing
			-- Accelerated Mending (Healing Power, Use) [Warp-Scarab Brooch]
			{spellID = 33400, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blessing of Faith (Special, Use) [Lower City Prayerbook]
			{spellID = 37877, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blessing of Life (Special, Use) [Ribbon of Sacrifice]
			{spellID = 38332, unitID = "target", caster = "player", filter = "BUFF"},
			-- Chromatic Infusion (Healing Power, Use) [Draconic Infused Emblem]
			{spellID = 27675, unitID = "player", caster = "player", filter = "BUFF"},
			-- Deep Meditation (Spirit, Use) [Earring of Soulful Meditation]
			{spellID = 40402, unitID = "player", caster = "player", filter = "BUFF"},
			-- Diabolic Remedy (Healing Power, Use) [Tome of Diabolic Remedy]
			{spellID = 43710, unitID = "player", caster = "player", filter = "BUFF"},
			-- Endless Blessings (Spirit, Use) [Bangle of Endless Blessings]
			{spellID = 34210, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of the Martyr (Healing Power, Use) [Essence of the Martyr]
			{spellID = 35165, unitID = "player", caster = "player", filter = "BUFF"},
			-- Evocation (Mana Regeneration, Use) [Glimmering Naaru Sliver]
			{spellID = 45052, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Focused Mind (Special, Use) [Auslese's Light Channeler]
			{spellID = 31794, unitID = "player", caster = "player", filter = "BUFF"},
			-- Healing of the Ages (Healing Power, Use) [Hibernation Crystal]
			{spellID = 24998, unitID = "player", caster = "player", filter = "BUFF"},
			-- Healing Power (Healing Power, Use) [Heavenly Inspiration]
			{spellID = 36347, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Holy Energy (Special, Use) [Vial of the Sunwell]
			{spellID = 45062, unitID = "player", caster = "player", filter = "BUFF"},
			-- Hopped Up (Healing Power, Use) [Direbrew Hops]
			{spellID = 51954, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mar'li's Brain Boost (Mp5, Use) [Mar'li's Eye]
			{spellID = 24268, unitID = "player", caster = "player", filter = "BUFF"},
			-- Meditation (Special, Proc) [Bangle of Endless Blessings]
			{spellID = 38346, unitID = "player", caster = "player", filter = "BUFF"},
			-- Persistent Shield (Absorb, Use) [Scarab Brooch]
			{spellID = 26467, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Power of Prayer (Healing Power, Use) [Oshu'gun Relic]
			{spellID = 32367, unitID = "player", caster = "player", filter = "BUFF"},
			-- Seaspray Albatross (Mana Regeneration, Use) [Figurine - Seaspray Albatross]
			{spellID = 46785, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spell Haste (Spell Haste, Proc) [Scarab of the Infinite Cycle]
			-- {spellID = 33370, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Talasite Owl (Mana Regeneration, Use) [Figurine - Talasite Owl]
			{spellID = 31045, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Eye of the Dead (Special, Use) [Eye of the Dead]
			{spellID = 28780, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wisdom (Mana Regeneration, Proc) [Memento of Tyrande]
			{spellID = 37656, unitID = "player", caster = "player", filter = "BUFF"},

			-- Helms
			-- Arcane Might (Spell Power, Proc) [Circlet of Arcane Might]
			{spellID = 31037, unitID = "player", caster = "player", filter = "BUFF"},

			-- Necks
			-- Light's Salvation (Healing Power, Proc) [Shattered Sun Pendant of Restoration - Aldor]
			{spellID = 45478, unitID = "player", caster = "player", filter = "BUFF"},
			-- Light's Wrath (Spell Power, Proc) [Shattered Sun Pendant of Acumen - Aldor]
			{spellID = 45479, unitID = "player", caster = "player", filter = "BUFF"},

			-- Rings
			-- Band of the Eternal Restorer (Healing Power, Proc) [Band of the Eternal Restorer]
			{spellID = 35087, unitID = "player", caster = "player", filter = "BUFF"},
			-- Band of the Eternal Sage (Spell Power, Proc) [Band of the Eternal Sage]
			{spellID = 35084, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spell Blasting (Spell Power, Proc) [Wrath of Cenarius]
			{spellID = 25906, unitID = "player", caster = "player", filter = "BUFF"},

			-- Weapons
			-- Mental Protection Field (Immunity, Use) [Staff of Disintegration]
			{spellID = 36480, unitID = "player", caster = "all", filter = "BUFF"},

			-- Meta Gems
			-- Focus (Spell Haste, Proc) [Mystical Skyfire Diamond]
			{spellID = 18803, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- Enchants
			-- Spellsurge (Mana Regeneration to Party) [Enchant Weapon - Spellsurge]
			{spellID = 27996, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = C.filger.buffs_space,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Blackout
			{spellID = 15269, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Chastise
			{spellID = 44041, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Devouring Plague
			{spellID = 2944, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Hex of Weakness
			{spellID = 9035, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Holy Fire
			{spellID = 14914, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Mind Control
			{spellID = 605, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Mind Flay r1
			{spellID = 15407, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Mind Flay r2
			{spellID = 17311, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Mind Flay r3
			{spellID = 17312, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Mind Flay r4
			{spellID = 17313, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Mind Flay r5
			{spellID = 17314, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Mind Flay r6
			{spellID = 18807, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Mind Flay r7
			{spellID = 25387, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Mind Soothe
			{spellID = 453, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Mind Vision
			{spellID = 2096, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Misery
			{spellID = 33196, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Psychic Scream
			{spellID = 8122, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Shadow Vulnerability (Shadow Weaving)
			{spellID = 15258, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Shadow Word: Pain
			{spellID = 589, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Silence
			{spellID = 15487, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Starshards
			{spellID = 10797, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Touch of Weakness
			{spellID = 2943, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Vampiric Embrace
			{spellID = 15286, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Vampiric Touch r1
			{spellID = 34914, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Vampiric Touch r2
			{spellID = 34916, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Vampiric Touch r3
			{spellID = 34917, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},

			-- Trinket Effects

			-- Enchants
			-- Deathfrost [Enchant Weapon - Deathfrost]
			{spellID = 46629, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {"LEFT", T_DE_BUFF_BAR_Anchor},

			-- Abolish Disease
			{spellID = 552, unitID = "target", caster = "player", filter = "BUFF"},
			-- Armor of Faith (Absorb, Proc) [Vestments of Faith]
			{spellID = 28810, unitID = "target", caster = "player", filter = "BUFF"},
			-- Greater Heal (HoT, Proc) [Vestments of Transcendence]
			{spellID = 22009, unitID = "target", caster = "player", filter = "BUFF"},
			-- Inspiration
			{spellID = 14893, unitID = "target", caster = "player", filter = "BUFF"},
			-- Lightwell Renew
			{spellID = 7001, unitID = "target", caster = "player", filter = "BUFF"},
			-- Power Word: Shield
			{spellID = 17, unitID = "target", caster = "player", filter = "BUFF"},
			-- Prayer of Mending
			{spellID = 41635, unitID = "target", caster = "player", filter = "BUFF"},
			-- Renew
			{spellID = 139, unitID = "target", caster = "player", filter = "BUFF"},
			-- Renewal (HoT, Proc) [Incarnate Raiment]
			{spellID = 37563, unitID = "target", caster = "player", filter = "BUFF"},
			-- Weakened Soul
			{spellID = 6788, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Trinket Effects
			-- Fecundity (Special, Use) [Ribbon of Sacrifice]
			{spellID = 38333, unitID = "target", caster = "player", filter = "BUFF"},
			-- Persistent Shield (Absorb, Use) [Scarab Brooch]
			{spellID = 26470, unitID = "target", caster = "player", filter = "BUFF", absID = true},
			-- Regeneration (HoT, Proc) [Fel Reaver's Piston]
			{spellID = 38324, unitID = "target", caster = "player", filter = "BUFF", absID = true},
		},
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {"LEFT", PVE_PVP_CC_Anchor},

			-- Shackle Undead
			{spellID = 9484, unitID = "focus", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = C.filger.cooldown_space,
			Alpha = 1,
			IconSize = C.filger.cooldown_size,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Self
			-- Chastise
			{spellID = 44041, filter = "CD"},
			-- Consume Magic
			{spellID = 32676, filter = "CD"},
			-- Desperate Prayer
			{spellID = 13908, filter = "CD"},
			-- Devouring Plague
			{spellID = 2944, filter = "CD"},
			-- Elune's Grace
			{spellID = 2651, filter = "CD"},
			-- Fade
			{spellID = 586, filter = "CD", absID = true},
			-- Fear Ward
			{spellID = 6346, filter = "CD"},
			-- Feedback
			{spellID = 13896, filter = "CD"},
			-- Inner Focus
			{spellID = 14751, filter = "CD"},
			-- Lightwell
			{spellID = 724, filter = "CD"},
			-- Mind Blast
			{spellID = 8092, filter = "CD"},
			-- Power Infusion
			{spellID = 10060, filter = "CD"},
			-- Power Word: Shield
			{spellID = 17, filter = "CD"},
			-- Prayer of Mending
			{spellID = 33076, filter = "CD"},
			-- Psychic Scream
			{spellID = 8122, filter = "CD"},
			-- Shadow Word: Death
			{spellID = 32379, filter = "CD"},
			-- Shadowfiend
			{spellID = 34433, filter = "CD"},
			-- Silence
			{spellID = 15487, filter = "CD", absID = true},
			-- Starshards
			{spellID = 10797, filter = "CD"},
			-- Symbol of Hope
			{spellID = 32548, filter = "CD"},
			-- Vampiric Embrace
			{spellID = 15286, filter = "CD"},

			-- Racial
			-- Arcane Torrent (Mana)
			{spellID = 28730, filter = "CD", absID = true},
			-- Berserking (Mana)
			{spellID = 20554, filter = "CD", absID = true},
			-- Cannibalize (Forsaken)
			{spellID = 20577, filter = "CD"},
			-- Gift of the Naaru (Draenei)
			{spellID = 28880, filter = "CD"},
			-- Perception (Human)
			{spellID = 20600, filter = "CD"},
			-- Shadowmeld (Night Elf)
			{spellID = 20580, filter = "CD"},
			-- Stoneform (Dwarf)
			{spellID = 20594, filter = "CD"},
			-- Will of the Forsaken (Forsaken)
			{spellID = 7744, filter = "CD"},

			-- Items
			-- Back
			{slotID = 15, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Neck
			{slotID = 2, filter = "CD"},
			-- Rings
			{slotID = 11, filter = "CD"},
			{slotID = 12, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},
		},
	},
	["ROGUE"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = C.filger.buffs_space,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Adrenaline Rush
			{spellID = 13750, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blade Flurry
			{spellID = 13877, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cloak of Shadows
			{spellID = 31224, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cold Blood
			{spellID = 14177, unitID = "player", caster = "player", filter = "BUFF"},
			-- Evasion
			{spellID = 5277, unitID = "player", caster = "player", filter = "BUFF"},
			-- Envenom
			{spellID = 32645, unitID = "player", caster = "player", filter = "BUFF"},
			-- Find Weakness
			{spellID = 31234, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ghostly Strike
			{spellID = 14278, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadowstep
			{spellID = 36563, unitID = "player", caster = "player", filter = "BUFF"},
			-- Slice and Dice
			{spellID = 5171, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sprint
			{spellID = 2983, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stealth
			-- {spellID = 1784, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Stealth (Vanish)
			-- {spellID = 31621, unitID = "player", caster = "player", filter = "BUFF", absID = true},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = C.filger.buffs_space,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Buffs
			-- Remorseless Attacks
			{spellID = 14143, unitID = "player", caster = "player", filter = "BUFF"},

			-- Item Sets
			-- Bloodfang (HoT, Proc) [Bloodfang Armor]
			{spellID = 23580, unitID = "player", caster = "player", filter = "BUFF"},
			-- Coup de Grace (Special, Proc) [Deathmantle]
			{spellID = 37171, unitID = "player", caster = "player", filter = "BUFF"},
			-- Haste (Physical Haste, Proc) [Assassination Armor]
			-- {spellID = 37163, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Heroic Resolution (Attack Power, Proc) [Desolation Battlegear / Doomplate Battlegear / Wastewalker Armor]
			{spellID = 37612, unitID = "player", caster = "player", filter = "BUFF"},
			-- Revealed Flaw (Special, Proc) [Bonescythe Armor]
			{spellID = 28815, unitID = "player", caster = "player", filter = "BUFF"},

			-- Ranged
			-- Santos' Blessing (Attack Power, Proc) [Don Santos' Famous Hunting Rifle]
			{spellID = 38293, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- Class
			-- Exploit Weakness (Critical Strike, Proc) [Ashtongue Talisman of Lethality]
			{spellID = 40461, unitID = "player", caster = "player", filter = "BUFF"},
			-- Perceived Weakness (Armor Penetration, Proc) [Warp-Spring Coil]
			{spellID = 37174, unitID = "player", caster = "player", filter = "BUFF"},
			-- Venomous Totem (Special, Use) [Venomous Totem]
			{spellID = 23726, unitID = "player", caster = "player", filter = "BUFF"},

			-- Darkmoon Cards
			-- Aura of the Blue Dragon (Special, Proc) [Darkmoon Card: Blue Dragon]
			{spellID = 23684, unitID = "player", caster = "player", filter = "BUFF"},
			-- Aura of the Crusader (Attack Power, Proc) [Darkmoon Card: Crusade]
			{spellID = 39439, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Aura of Wrath (Critical Strike, Proc) [Darkmoon Card: Wrath]
			{spellID = 39443, unitID = "player", caster = "player", filter = "BUFF"},
			-- Delusional (Attack Power, Proc) [Darkmoon Card: Madness] - Rogue, Hunter, Paladin, Warrior, Druid, Shaman
			{spellID = 40997, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kleptomania (Agility, Proc) [Darkmoon Card: Madness] - Warrior, Rogue, Paladin, Hunter, Druid
			{spellID = 40998, unitID = "player", caster = "player", filter = "BUFF"},
			-- Manic (Haste, Proc) [Darkmoon Card: Madness] - All classes except Hunter
			{spellID = 41005, unitID = "player", caster = "player", filter = "BUFF"},
			-- Martyr Complex (Stamina, Proc) [Darkmoon Card: Madness] - All classes
			{spellID = 41011, unitID = "player", caster = "player", filter = "BUFF"},
			-- Paranoia (Critical Strike, Proc) [Darkmoon Card: Madness] - All classes except Hunter
			{spellID = 41002, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Sociopath (Strength, Proc) [Darkmoon Card: Madness] - Paladin, Rogue, Druid, Warrior
			{spellID = 39511, unitID = "player", caster = "player", filter = "BUFF"},

			-- PvP Trinkets
			-- Aura of Protection (Absorb, Use) [Arena Grand Master]
			{spellID = 23506, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage Absorb (Absorb, Use) [Arathi Basin Trinket]
			{spellID = 25750, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tremendous Fortitude (Health, Use) [Battlemaster]
			{spellID = 44055, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shell of Deterrence (Absorb, Use) [Runed Fungalcap]
			{spellID = 31771, unitID = "player", caster = "player", filter = "BUFF"},

			-- Universal
			-- Arcane Shroud (Threat Reduction, Use) [Fetish of the Sand Reaver]
			{spellID = 26400, unitID = "player", caster = "player", filter = "BUFF"},
			-- Chitinous Spikes (Special, Use) [Fetish of Chitinous Spikes]
			{spellID = 26168, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of the Scale (Special, Use) [Heart of the Scale]
			{spellID = 17275, unitID = "player", caster = "player", filter = "BUFF"},
			-- Loatheb's Reflection (Magic Resistance, Use) [Loatheb's Reflection]
			{spellID = 28778, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mercurial Shield (Magic Resistance, Use) [Petrified Scarab]
			{spellID = 26464, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Burrower's Shell (Absorb, Use) [The Burrower's Shell]
			{spellID = 29506, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Lion Horn of Stormwind (Special, Proc) [The Lion Horn of Stormwind]
			{spellID = 18946, unitID = "player", caster = "player", filter = "BUFF"},

			-- Damage [Physical]
			-- Ancient Power (Attack Power, Use) [Core of Ar'kelos]
			{spellID = 35733, unitID = "player", caster = "player", filter = "BUFF"},
			-- Armor Penetration (Armor Penetration, Use) [Icon of Unyielding Courage]
			{spellID = 34106, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Battle Trance (Attack Power, Proc) [Blackened Naaru Sliver]
			{spellID = 45040, unitID = "player", caster = "player", filter = "BUFF"},
			-- Burning Hatred (Attack Power, Use) [Ogre Mauler's Badge / Uniting Charm]
			{spellID = 32362, unitID = "player", caster = "player", filter = "BUFF"},
			-- Call of the Berserker (Attack Power, Use) [Berserker's Call]
			{spellID = 43716, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combat Insight (Attack Power, Proc) [Blackened Naaru Sliver]
			{spellID = 45041, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combat Valor (Attack Power, Proc) [Skyguard Silver Cross]
			{spellID = 41261, unitID = "player", caster = "player", filter = "BUFF"},
			-- Consume Life (Special, Use) [Fetish of the Fallen]
			{spellID = 33015, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Dire Drunkard (Attack Power, Use) [Empty Mug of Direbrew]
			{spellID = 51955, unitID = "player", caster = "player", filter = "BUFF"},
			-- Disdain (Attack Power, Proc) [Shard of Contempt]
			{spellID = 45053, unitID = "player", caster = "player", filter = "BUFF"},
			-- Earthstrike (Attack Power, Use) [Earthstrike]
			{spellID = 25891, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ferocity (Attack Power, Use) [Ancient Draenei War Talisman / Bladefist's Breadth]
			{spellID = 33667, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Forceful Strike (Armor Penetration, Proc) [Madness of the Betrayer]
			{spellID = 40477, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fury of the Crashing Waves (Attack Power, Proc) [Tsunami Talisman]
			{spellID = 42084, unitID = "player", caster = "player", filter = "BUFF"},
			--[[
			-- Haste (Physical Haste, Use) [Abacus of Violent Odds]
			{spellID = 33807, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Haste (Physical Haste, Proc) [Dragonspine Trophy]
			{spellID = 34775, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			--]]
			-- Heightened Reflexes (Agility, Use) [Badge of Tenacity]
			{spellID = 40729, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heroism (Attack Power, Use) [Terokkar Tablet of Precision]
			-- {spellID = 39200, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Insight of the Qiraji (Armor Penetration, Use) [Badge of the Swarmguard]
			{spellID = 26481, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jom Gabbar (Attack Power, Use) [Jom Gabbar]
			{spellID = 29604, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Kiss of the Spider (Physical Haste, Use) [Kiss of the Spider]
			{spellID = 28866, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lust for Battle (Attack Power, Use) [Bloodlust Brooch]
			{spellID = 35166, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nightseye Panther (Attack Power, Use) [Figurine - Nightseye Panther]
			{spellID = 31047, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rage of the Unraveller (Attack Power, Proc) [Hourglass of the Unraveller]
			{spellID = 33649, unitID = "player", caster = "player", filter = "BUFF"},
			-- Restless Strength (Special, Use) [Zandalarian Hero Medallion]
			{spellID = 24662, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadowsong Panther (Attack Power, Use) [Figurine - Shadowsong Panther]
			{spellID = 46784, unitID = "player", caster = "player", filter = "BUFF"},
			-- Slayer's Crest (Attack Power, Use) [Slayer's Crest]
			{spellID = 28777, unitID = "player", caster = "player", filter = "BUFF"},
			-- Valor (Attack Power, Use) [Crystalforged Trinket]
			{spellID = 40724, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- Necks
			-- Arcane Insight (Expertise, Proc) [Shattered Sun Pendant of Resolve - Scryer]
			{spellID = 45431, unitID = "player", caster = "player", filter = "BUFF"},
			-- Light's Strength (Attack Power, Proc) [Shattered Sun Pendant of Might - Aldor]
			{spellID = 45480, unitID = "player", caster = "player", filter = "BUFF"},

			-- Rings
			-- Band of the Eternal Champion (Attack Power, Proc) [Band of the Eternal Champion]
			{spellID = 35081, unitID = "player", caster = "player", filter = "BUFF"},

			-- Weapons
			-- Bladestorm (Physical Haste, Proc) [The Bladefist]
			{spellID = 35131, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Blinding Speed (Physical Haste, Proc) [Blackout Truncheon]
			{spellID = 33489, unitID = "player", caster = "player", filter = "BUFF"},
			-- Haste (Physical Haste, Proc) [Manual Crowd Pummeler]
			{spellID = 13494, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Haste (Physical Haste, Proc) [Empyrean Demolisher / Drakefist Hammer / Dragonmaw / Dragonstrike]
			{spellID = 21165, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Heartrazor (Attack Power, Proc) [Heartrazor]
			{spellID = 36041, unitID = "player", caster = "player", filter = "BUFF"},
			-- Speed Infusion (Movement Speed, Physical Attack Speed, Proc) [Devastation / Warp Slicer]
			{spellID = 36479, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Twin Blades of Azzinoth (Physical Haste, Proc) [The Twin Blades of Azzinoth]
			{spellID = 41435, unitID = "player", caster = "player", filter = "BUFF"},

			-- Meta Gems
			-- Skyfire Swiftness (Physical Haste, Proc) [Thundering Skyfire Diamond]
			{spellID = 39959, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Executioner [Enchant Weapon - Executioner]
			{spellID = 42976, unitID = "player", caster = "player", filter = "BUFF"},
			-- Holy Strength (Strength) [Enchant Weapon - Crusader]
			{spellID = 20007, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lightning Speed (Agility and Physical Attack Speed) [Enchant Weapon - Mongoose]
			{spellID = 28093, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = C.filger.buffs_space,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Blade Twisting (Dazed)
			{spellID = 31125, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Cheap Shot
			{spellID = 1833, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Crippling Poison r1
			{spellID = 3409, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Crippling Poison r2
			{spellID = 11201, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Deadly Poison
			{spellID = 2818, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Deadly Throw
			{spellID = 26679, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Deadly Interrupt Effect
			{spellID = 32747, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Expose Armor
			{spellID = 8647, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Garrote
			{spellID = 703, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Garrote - Silence
			{spellID = 1330, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Gouge
			{spellID = 1776, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Hemorrhage
			{spellID = 16511, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Kick - Silenced
			{spellID = 18425, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Kidney Shot
			{spellID = 408, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Mind-numbing Poison
			{spellID = 5760, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Riposte
			{spellID = 14251, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Rupture
			{spellID = 1943, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Sap
			{spellID = 6770, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Wound Poison
			{spellID = 13218, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Mace Specialization
			-- Mace Stun Effect
			{spellID = 5530, unitID = "target", caster = "player", filter = "DEBUFF"},

			-- Trinket Effects

			-- Enchants
			-- Chilled [Enchant Weapon - Icy Chill]
			{spellID = 20005, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Deathfrost [Enchant Weapon - Deathfrost]
			{spellID = 46629, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Smite Demon [Enchant Weapon - Demonslaying]
			{spellID = 13907, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Unholy Curse [Enchant Weapon - Unholy Weapon]
			{spellID = 20006, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Venomhide Poison
			{spellID = 14795, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
		--[[
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {"LEFT", T_DE_BUFF_BAR_Anchor},
		},
		--]]
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {"LEFT", PVE_PVP_CC_Anchor},

			-- Blind
			{spellID = 2094, unitID = "focus", caster = "player", filter = "DEBUFF"},
			-- Sap
			{spellID = 6770, unitID = "focus", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = C.filger.cooldown_space,
			Alpha = 1,
			IconSize = C.filger.cooldown_size,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Self
			-- Adrenaline Rush
			{spellID = 13750, filter = "CD"},
			-- Blade Flurry
			{spellID = 13877, filter = "CD"},
			-- Blind
			{spellID = 2094, filter = "CD"},
			-- Cloak of Shadows
			{spellID = 31224, filter = "CD"},
			-- Cold Blood
			{spellID = 14177, filter = "CD"},
			-- Distract
			{spellID = 1725, filter = "CD"},
			-- Evasion
			{spellID = 5277, filter = "CD"},
			-- Feint
			{spellID = 1966, filter = "CD"},
			-- Ghostly Strike
			{spellID = 14278, filter = "CD"},
			-- Gouge
			{spellID = 1776, filter = "CD"},
			-- Kick
			{spellID = 1766, filter = "CD"},
			-- Kidney Shot
			{spellID = 408, filter = "CD"},
			-- Premeditation
			{spellID = 14183, filter = "CD"},
			-- Preparation
			{spellID = 14185, filter = "CD"},
			-- Riposte
			{spellID = 14251, filter = "CD"},
			-- Shadowstep
			{spellID = 36554, filter = "CD"},
			-- Sprint
			{spellID = 2983, filter = "CD"},
			-- Stealth
			{spellID = 1784, filter = "CD"},
			-- Vanish
			{spellID = 1856, filter = "CD"},

			-- Racial
			-- Arcane Torrent (Energy)
			{spellID = 25046, filter = "CD", absID = true},
			-- Berserking (Energy)
			{spellID = 26297, filter = "CD", absID = true},
			-- Blood Fury (Physical)
			{spellID = 20572, filter = "CD", absID = true},
			-- Blood Fury (Both)
			{spellID = 33697, filter = "CD", absID = true},
			-- Cannibalize (Forsaken)
			{spellID = 20577, filter = "CD"},
			-- Escape Artist (Gnome)
			{spellID = 20589, filter = "CD"},
			-- Perception (Human)
			{spellID = 20600, filter = "CD"},
			-- Shadowmeld (Night Elf)
			{spellID = 20580, filter = "CD"},
			-- Stoneform (Dwarf)
			{spellID = 20594, filter = "CD"},
			-- Will of the Forsaken (Forsaken)
			{spellID = 7744, filter = "CD"},

			-- Items
			-- Back
			{slotID = 15, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Neck
			{slotID = 2, filter = "CD"},
			-- Rings
			{slotID = 11, filter = "CD"},
			{slotID = 12, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},
		},
	},
	["SHAMAN"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = C.filger.buffs_space,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Elemental Devastation
			{spellID = 30165, unitID = "player", caster = "player", filter = "BUFF"},
			-- Elemental Mastery
			{spellID = 16166, unitID = "player", caster = "player", filter = "BUFF"},
			-- Far Sight
			-- {spellID = 6196, unitID = "player", caster = "player", filter = "BUFF"},
			--[[
			-- Fire Resistance Totem r1
			{spellID = 8185, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Fire Resistance Totem r2
			{spellID = 10534, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Fire Resistance Totem r3
			{spellID = 10535, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Fire Resistance Totem r4
			{spellID = 25563, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			--]]
			-- Flurry
			{spellID = 16257, unitID = "player", caster = "player", filter = "BUFF"},
			-- Focused (Shamanistic)
			-- {spellID = 43339, unitID = "player", caster = "player", filter = "BUFF"},
			--[[
			-- Frost Resistance Totem r1
			{spellID = 8182, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Frost Resistance Totem r2
			{spellID = 10476, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Frost Resistance Totem r3
			{spellID = 10477, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Frost Resistance Totem r4
			{spellID = 25560, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			--]]
			-- Ghost Wolf
			-- {spellID = 2645, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Grace of Air
			-- {spellID = 8836, unitID = "player", caster = "player", filter = "BUFF"},
			-- Grounding Totem Effect
			-- {spellID = 8178, unitID = "player", caster = "player", filter = "BUFF"},
			-- Healing Stream
			-- {spellID = 5672, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lightning Shield r1
			{spellID = 324, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Lightning Shield r2
			{spellID = 325, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Lightning Shield r3
			{spellID = 905, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Lightning Shield r4
			{spellID = 945, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Lightning Shield r5
			{spellID = 8134, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Lightning Shield r6
			{spellID = 10431, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Lightning Shield r7
			{spellID = 10432, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Lightning Shield r8
			{spellID = 25469, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Lightning Shield r9
			{spellID = 25472, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			--[[
			-- Mana Spring Totem r1
			{spellID = 5677, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Mana Spring Totem r2
			{spellID = 10491, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Mana Spring Totem r3
			{spellID = 10493, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Mana Spring Totem r4
			{spellID = 10494, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Mana Spring Totem r5
			{spellID = 25570, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			--]]
			-- Nature's Swiftness
			{spellID = 16188, unitID = "player", caster = "player", filter = "BUFF"},
			--[[
			-- Nature Resistance Totem r1
			{spellID = 10596, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Nature Resistance Totem r2
			{spellID = 10598, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Nature Resistance Totem r3
			{spellID = 10599, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Nature Resistance Totem r4
			{spellID = 25574, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			--]]
			-- Sentry Totem
			-- {spellID = 6495, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shamanistic Rage
			{spellID = 30823, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stoneskin Totem
			-- {spellID = 8072, unitID = "player", caster = "player", filter = "BUFF"},
			-- Strength of Earth
			-- {spellID = 8076, unitID = "player", caster = "player", filter = "BUFF"},
			-- Totem of Wrath
			-- {spellID = 30708, unitID = "player", caster = "player", filter = "BUFF"},
			-- Water Shield r1
			{spellID = 24398, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Water Shield r2
			{spellID = 33736, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Windwall Totem
			-- {spellID = 15108, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wrath of Air Totem
			-- {spellID = 2895, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = C.filger.buffs_space,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Buffs
			-- Clearcasting (Elemental Focus)
			{spellID = 16246, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Focused Casting (Eye of the Storm)
			{spellID = 29063, unitID = "player", caster = "player", filter = "BUFF"},

			-- Item Sets
			-- Charged (Special, Proc) [Cataclysm Regalia]
			{spellID = 37234, unitID = "player", caster = "player", filter = "BUFF"},
			-- Energized (Special, Proc) [Cyclone Regalia]
			{spellID = 37214, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Heroic Resolution (Attack Power, Proc) [Desolation Battlegear / Doomplate Battlegear / Wastewalker Armor]
			{spellID = 37612, unitID = "player", caster = "player", filter = "BUFF"},
			-- Insight (Spell Power, Proc) [Mana-Etched Regalia]
			{spellID = 37620, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Invigorated (Special, Proc) [Cataclysm Harness]
			{spellID = 37240, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lesser Spell Blasting (Spell Power, Proc) [Spellstrike Infusion]
			{spellID = 32108, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lightning Shield (Mp5, Proc) [The Earthshatterer]
			-- {spellID = 28820, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Stormcaller's Wrath (Spell Power, Proc) [Stormcaller's Garb]
			{spellID = 26121, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stormpower (Attack Power, Proc) [Skyshatter Harness]
			{spellID = 38430, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Furious Storm (Spell Power, Proc) [The Elements / The Five Thunders]
			{spellID = 27775, unitID = "player", caster = "player", filter = "BUFF"},
			-- Totemic Mastery (Special, Proc) [Skyshatter Regalia]
			{spellID = 38437, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wave Trance (Special, Proc) [Cataclysm Raiment]
			{spellID = 39950, unitID = "player", caster = "player", filter = "BUFF"},

			-- Totems
			-- Elemental Strength (Attack Power, Shocks) [Stonebreaker's Totem]
			{spellID = 43749, unitID = "player", caster = "player", filter = "BUFF"},
			-- Energized (Spell Haste, Lightning Bolt) [Skycall Totem]
			{spellID = 43751, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Resilient (Resilience, Stormstrike/Shocks) [Totem of Indomitability / Totem of Survival]
			{spellID = 43839, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- Class
			-- Energized Shield (Special, Use) [Wushoolay's Charm of Spirits]
			{spellID = 24499, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nature Aligned (Spell Power, Use) [Natural Alignment Crystal]
			{spellID = 23734, unitID = "player", caster = "player", filter = "BUFF"},
			-- Power Surge (Attack Power, Proc) [Ashtongue Talisman of Vision]
			{spellID = 40466, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- Darkmoon Cards
			-- Aura of the Blue Dragon (Special, Proc) [Darkmoon Card: Blue Dragon]
			{spellID = 23684, unitID = "player", caster = "player", filter = "BUFF"},
			-- Aura of the Crusader (Attack Power, Proc) [Darkmoon Card: Crusade]
			{spellID = 39439, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Aura of the Crusader (Spell Power, Proc) [Darkmoon Card: Crusade]
			{spellID = 39441, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Aura of Wrath (Critical Strike, Proc) [Darkmoon Card: Wrath]
			{spellID = 39443, unitID = "player", caster = "player", filter = "BUFF"},
			-- Delusional (Attack Power, Proc) [Darkmoon Card: Madness] - Rogue, Hunter, Paladin, Warrior, Druid, Shaman
			{spellID = 40997, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dementia (Special Power, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin
			{spellID = 41404, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Dementia +5% (Special Power, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin
			{spellID = 41406, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Dementia -5% (Special Power, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin
			{spellID = 41409, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Manic (Haste, Proc) [Darkmoon Card: Madness] - All classes except Hunter
			{spellID = 41005, unitID = "player", caster = "player", filter = "BUFF"},
			-- Martyr Complex (Stamina, Proc) [Darkmoon Card: Madness] - All classes
			{spellID = 41011, unitID = "player", caster = "player", filter = "BUFF"},
			-- Megalomania (Spell Power, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin
			{spellID = 40999, unitID = "player", caster = "player", filter = "BUFF"},
			-- Narcissism (Intellect, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin, Hunter
			{spellID = 41009, unitID = "player", caster = "player", filter = "BUFF"},
			-- Paranoia (Critical Strike, Proc) [Darkmoon Card: Madness] - All classes except Hunter
			{spellID = 41002, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- PvP Trinkets
			-- Aura of Protection (Absorb, Use) [Arena Grand Master]
			{spellID = 23506, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage Absorb (Absorb, Use) [Arathi Basin Trinket]
			{spellID = 25750, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tremendous Fortitude (Health, Use) [Battlemaster]
			{spellID = 44055, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shell of Deterrence (Absorb, Use) [Runed Fungalcap]
			{spellID = 31771, unitID = "player", caster = "player", filter = "BUFF"},

			-- Universal
			-- Arcane Shroud (Threat Reduction, Use) [Fetish of the Sand Reaver]
			{spellID = 26400, unitID = "player", caster = "player", filter = "BUFF"},
			-- Chitinous Spikes (Special, Use) [Fetish of Chitinous Spikes]
			{spellID = 26168, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of the Scale (Special, Use) [Heart of the Scale]
			{spellID = 17275, unitID = "player", caster = "player", filter = "BUFF"},
			-- Loatheb's Reflection (Magic Resistance, Use) [Loatheb's Reflection]
			{spellID = 28778, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mercurial Shield (Magic Resistance, Use) [Petrified Scarab]
			{spellID = 26464, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Burrower's Shell (Absorb, Use) [The Burrower's Shell]
			{spellID = 29506, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Lion Horn of Stormwind (Special, Proc) [The Lion Horn of Stormwind]
			{spellID = 18946, unitID = "player", caster = "player", filter = "BUFF"},

			-- Damage [Physical]
			-- Ancient Power (Attack Power, Use) [Core of Ar'kelos]
			{spellID = 35733, unitID = "player", caster = "player", filter = "BUFF"},
			-- Armor Penetration (Armor Penetration, Use) [Icon of Unyielding Courage]
			{spellID = 34106, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Battle Trance (Attack Power, Proc) [Blackened Naaru Sliver]
			{spellID = 45040, unitID = "player", caster = "player", filter = "BUFF"},
			-- Burning Hatred (Attack Power, Use) [Ogre Mauler's Badge / Uniting Charm]
			{spellID = 32362, unitID = "player", caster = "player", filter = "BUFF"},
			-- Call of the Berserker (Attack Power, Use) [Berserker's Call]
			{spellID = 43716, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combat Insight (Attack Power, Proc) [Blackened Naaru Sliver]
			{spellID = 45041, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combat Valor (Attack Power, Proc) [Skyguard Silver Cross]
			{spellID = 41261, unitID = "player", caster = "player", filter = "BUFF"},
			-- Consume Life (Special, Use) [Fetish of the Fallen]
			{spellID = 33015, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Dire Drunkard (Attack Power, Use) [Empty Mug of Direbrew]
			{spellID = 51955, unitID = "player", caster = "player", filter = "BUFF"},
			-- Disdain (Attack Power, Proc) [Shard of Contempt]
			{spellID = 45053, unitID = "player", caster = "player", filter = "BUFF"},
			-- Earthstrike (Attack Power, Use) [Earthstrike]
			{spellID = 25891, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ferocity (Attack Power, Use) [Ancient Draenei War Talisman / Bladefist's Breadth]
			{spellID = 33667, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Forceful Strike (Armor Penetration, Proc) [Madness of the Betrayer]
			{spellID = 40477, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fury of the Crashing Waves (Attack Power, Proc) [Tsunami Talisman]
			{spellID = 42084, unitID = "player", caster = "player", filter = "BUFF"},
			--[[
			-- Haste (Physical Haste, Use) [Abacus of Violent Odds]
			{spellID = 33807, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Haste (Physical Haste, Proc) [Dragonspine Trophy]
			{spellID = 34775, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			--]]
			-- Heightened Reflexes (Agility, Use) [Badge of Tenacity]
			{spellID = 40729, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heroism (Attack Power, Use) [Terokkar Tablet of Precision]
			-- {spellID = 39200, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Insight of the Qiraji (Armor Penetration, Use) [Badge of the Swarmguard]
			{spellID = 26481, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jom Gabbar (Attack Power, Use) [Jom Gabbar]
			{spellID = 29604, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Kiss of the Spider (Physical Haste, Use) [Kiss of the Spider]
			{spellID = 28866, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lust for Battle (Attack Power, Use) [Bloodlust Brooch]
			{spellID = 35166, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nightseye Panther (Attack Power, Use) [Figurine - Nightseye Panther]
			{spellID = 31047, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rage of the Unraveller (Attack Power, Proc) [Hourglass of the Unraveller]
			{spellID = 33649, unitID = "player", caster = "player", filter = "BUFF"},
			-- Restless Strength (Special, Use) [Zandalarian Hero Medallion]
			{spellID = 24662, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadowsong Panther (Attack Power, Use) [Figurine - Shadowsong Panther]
			{spellID = 46784, unitID = "player", caster = "player", filter = "BUFF"},
			-- Slayer's Crest (Attack Power, Use) [Slayer's Crest]
			{spellID = 28777, unitID = "player", caster = "player", filter = "BUFF"},
			-- Valor (Attack Power, Use) [Crystalforged Trinket]
			{spellID = 40724, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- Damage [Magic]
			-- Arcane Energy (Healing Power, Use) [Ancient Draenei Arcane Relic / Vengeance of the Illidari]
			{spellID = 33662, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ascendance (Spell Power, Use) [Talisman of Ascendance]
			{spellID = 28204, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Blessing of the Silver Crescent (Spell Power, Use) [Icon of the Silver Crescent]
			{spellID = 35163, unitID = "player", caster = "player", filter = "BUFF"},
			-- Call of the Nexus (Spell Power, Proc) [Shiffar's Nexus-Horn]
			{spellID = 34321, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combat Gallantry (Spell Power, Proc) [Airman's Ribbon of Gallantry]
			{spellID = 41263, unitID = "player", caster = "player", filter = "BUFF"},
			-- Consume Essence (Special, Use) [Oculus of the Hidden Eye]
			{spellID = 33013, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Crimson Serpent (Spell Power, Use) [Figurine - Crimson Serpent]
			{spellID = 46783, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dark Iron Pipeweed (Spell Power, Use) [Dark Iron Smoking Pipe]
			{spellID = 51953, unitID = "player", caster = "player", filter = "BUFF"},
			-- Electrical Charge (Special, Proc) [The Lightning Capacitor]
			{spellID = 37658, unitID = "player", caster = "player", filter = "BUFF"},
			-- Enlightenment (Mana Regeneration, Use) [Pendant of the Violet Eye]
			{spellID = 35095, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Ephemeral Power (Spell Power, Use) [Talisman of Ephemeral Power]
			{spellID = 23271, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of Sapphiron (Spell Power, Use) [The Restrained Essence of Sapphiron]
			{spellID = 28779, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fel Infusion (Spell Haste, Use) [The Skull of Gul'dan]
			{spellID = 40396, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Focused Power (Spell Power, Use) [Ancient Crystal Talisman / Glowing Crystal Insignia]
			{spellID = 32355, unitID = "player", caster = "player", filter = "BUFF"},
			-- Living Ruby Serpent (Spell Power, Use) [Figurine - Living Ruby Serpent]
			{spellID = 31040, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mojo Madness (Spell Power, Use) [Hex Shrunken Head]
			{spellID = 43712, unitID = "player", caster = "player", filter = "BUFF"},
			-- Obsidian Insight (Spell Power, Special, Use) [Eye of Moam]
			{spellID = 26166, unitID = "player", caster = "player", filter = "BUFF"},
			-- Pagle's Broken Reel (Spell Hit, Use) [Nat Pagle's Broken Reel]
			{spellID = 24610, unitID = "player", caster = "player", filter = "BUFF"},
			-- Power Circle (Spell Power, Use) [Shifting Naaru Sliver]
			{spellID = 45043, unitID = "player", caster = "player", filter = "BUFF"},
			-- Recurring Power (Spell Power, Proc) [Eye of Magtheridon]
			{spellID = 34747, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spell Haste (Spell Haste, Proc) [Quagmirran's Eye]
			{spellID = 33370, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Spell Power (Spell Power, Use) [Scryer's Bloodgem / Xi'ri's Gift]
			{spellID = 35337, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			--[[
			-- Spell Power (Spell Power, Use) [Starkiller's Bauble]
			{spellID = 36432, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Spell Power (Spell Power, Use) [Terokkar Tablet of Vim]
			{spellID = 39201, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			--]]
			-- The Arcanist's Stone (Spell Power, Use) [Arcanist's Stone]
			{spellID = 34000, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Eye of Diminution (Special, Use) [Eye of Diminution]
			{spellID = 28862, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unstable Currents (Spell Power, Proc) [Sextant of Unstable Currents]
			{spellID = 38348, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unstable Power (Spell Power, Use) [Zandalarian Hero Charm]
			{spellID = 24659, unitID = "player", caster = "player", filter = "BUFF"},

			-- Healing
			-- Accelerated Mending (Healing Power, Use) [Warp-Scarab Brooch]
			{spellID = 33400, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blessing of Faith (Special, Use) [Lower City Prayerbook]
			{spellID = 37877, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blessing of Life (Special, Use) [Ribbon of Sacrifice]
			{spellID = 38332, unitID = "target", caster = "player", filter = "BUFF"},
			-- Chromatic Infusion (Healing Power, Use) [Draconic Infused Emblem]
			{spellID = 27675, unitID = "player", caster = "player", filter = "BUFF"},
			-- Deep Meditation (Spirit, Use) [Earring of Soulful Meditation]
			{spellID = 40402, unitID = "player", caster = "player", filter = "BUFF"},
			-- Diabolic Remedy (Healing Power, Use) [Tome of Diabolic Remedy]
			{spellID = 43710, unitID = "player", caster = "player", filter = "BUFF"},
			-- Endless Blessings (Spirit, Use) [Bangle of Endless Blessings]
			{spellID = 34210, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of the Martyr (Healing Power, Use) [Essence of the Martyr]
			{spellID = 35165, unitID = "player", caster = "player", filter = "BUFF"},
			-- Evocation (Mana Regeneration, Use) [Glimmering Naaru Sliver]
			{spellID = 45052, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Focused Mind (Special, Use) [Auslese's Light Channeler]
			{spellID = 31794, unitID = "player", caster = "player", filter = "BUFF"},
			-- Healing of the Ages (Healing Power, Use) [Hibernation Crystal]
			{spellID = 24998, unitID = "player", caster = "player", filter = "BUFF"},
			-- Healing Power (Healing Power, Use) [Heavenly Inspiration]
			{spellID = 36347, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Holy Energy (Special, Use) [Vial of the Sunwell]
			{spellID = 45062, unitID = "player", caster = "player", filter = "BUFF"},
			-- Hopped Up (Healing Power, Use) [Direbrew Hops]
			{spellID = 51954, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mar'li's Brain Boost (Mp5, Use) [Mar'li's Eye]
			{spellID = 24268, unitID = "player", caster = "player", filter = "BUFF"},
			-- Meditation (Special, Proc) [Bangle of Endless Blessings]
			{spellID = 38346, unitID = "player", caster = "player", filter = "BUFF"},
			-- Persistent Shield (Absorb, Use) [Scarab Brooch]
			{spellID = 26467, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Power of Prayer (Healing Power, Use) [Oshu'gun Relic]
			{spellID = 32367, unitID = "player", caster = "player", filter = "BUFF"},
			-- Seaspray Albatross (Mana Regeneration, Use) [Figurine - Seaspray Albatross]
			{spellID = 46785, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spell Haste (Spell Haste, Proc) [Scarab of the Infinite Cycle]
			-- {spellID = 33370, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Talasite Owl (Mana Regeneration, Use) [Figurine - Talasite Owl]
			{spellID = 31045, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Eye of the Dead (Special, Use) [Eye of the Dead]
			{spellID = 28780, unitID = "player", caster = "player", filter = "BUFF"},
			-- Wisdom (Mana Regeneration, Proc) [Memento of Tyrande]
			{spellID = 37656, unitID = "player", caster = "player", filter = "BUFF"},

			-- Helms
			-- Arcane Might (Spell Power, Proc) [Circlet of Arcane Might]
			{spellID = 31037, unitID = "player", caster = "player", filter = "BUFF"},

			-- Necks
			-- Arcane Insight (Expertise, Proc) [Shattered Sun Pendant of Resolve - Scryer]
			{spellID = 45431, unitID = "player", caster = "player", filter = "BUFF"},
			-- Light's Salvation (Healing Power, Proc) [Shattered Sun Pendant of Restoration - Aldor]
			{spellID = 45478, unitID = "player", caster = "player", filter = "BUFF"},
			-- Light's Strength (Attack Power, Proc) [Shattered Sun Pendant of Might - Aldor]
			{spellID = 45480, unitID = "player", caster = "player", filter = "BUFF"},
			-- Light's Wrath (Spell Power, Proc) [Shattered Sun Pendant of Acumen - Aldor]
			{spellID = 45479, unitID = "player", caster = "player", filter = "BUFF"},

			-- Rings
			-- Band of the Eternal Champion (Attack Power, Proc) [Band of the Eternal Champion]
			{spellID = 35081, unitID = "player", caster = "player", filter = "BUFF"},
			-- Band of the Eternal Restorer (Healing Power, Proc) [Band of the Eternal Restorer]
			{spellID = 35087, unitID = "player", caster = "player", filter = "BUFF"},
			-- Band of the Eternal Sage (Spell Power, Proc) [Band of the Eternal Sage]
			{spellID = 35084, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spell Blasting (Spell Power, Proc) [Wrath of Cenarius]
			{spellID = 25906, unitID = "player", caster = "player", filter = "BUFF"},

			-- Weapons
			-- Bladestorm (Physical Haste, Proc) [The Bladefist]
			{spellID = 35131, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Blinding Speed (Physical Haste, Proc) [Blackout Truncheon]
			{spellID = 33489, unitID = "player", caster = "player", filter = "BUFF"},
			-- Haste (Physical Haste, Proc) [Manual Crowd Pummeler]
			{spellID = 13494, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Haste (Physical Haste, Proc) [Empyrean Demolisher / Drakefist Hammer / Dragonmaw / Dragonstrike]
			{spellID = 21165, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Heartrazor (Attack Power, Proc) [Heartrazor]
			{spellID = 36041, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mental Protection Field (Immunity, Use) [Staff of Disintegration]
			{spellID = 36480, unitID = "player", caster = "all", filter = "BUFF"},
			-- Speed Infusion (Movement Speed, Physical Attack Speed, Proc) [Devastation / Warp Slicer]
			{spellID = 36479, unitID = "player", caster = "player", filter = "BUFF"},
			-- World Breaker (Physical Critical Strike, Proc) [World Breaker]
			{spellID = 36111, unitID = "player", caster = "player", filter = "BUFF"},

			-- Meta Gems
			-- Focus (Spell Haste, Proc) [Mystical Skyfire Diamond]
			{spellID = 18803, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Skyfire Swiftness (Physical Haste, Proc) [Thundering Skyfire Diamond]
			{spellID = 39959, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Executioner [Enchant Weapon - Executioner]
			{spellID = 42976, unitID = "player", caster = "player", filter = "BUFF"},
			-- Holy Strength (Strength) [Enchant Weapon - Crusader]
			{spellID = 20007, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lightning Speed (Agility and Physical Attack Speed) [Enchant Weapon - Mongoose]
			{spellID = 28093, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spellsurge (Mana Regeneration to Party) [Enchant Weapon - Spellsurge]
			{spellID = 27996, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = C.filger.buffs_space,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Earthbind
			{spellID = 3600, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Flame Shock
			{spellID = 8050, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Frost Shock r1
			{spellID = 8056, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Frost Shock r2
			{spellID = 8058, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Frost Shock r3
			{spellID = 10472, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Frost Shock r4
			{spellID = 10473, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Frost Shock r5
			{spellID = 25464, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Frostbrand Attack
			{spellID = 8034, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Stoneclaw Totem
			{spellID = 39796, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Stormstrike
			{spellID = 17364, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Trinket Effects

			-- Enchants
			-- Chilled [Enchant Weapon - Icy Chill]
			{spellID = 20005, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Deathfrost [Enchant Weapon - Deathfrost]
			{spellID = 46629, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Smite Demon [Enchant Weapon - Demonslaying]
			{spellID = 13907, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Unholy Curse [Enchant Weapon - Unholy Weapon]
			{spellID = 20006, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Venomhide Poison
			{spellID = 14795, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {"LEFT", T_DE_BUFF_BAR_Anchor},

			-- Ancestral Fortitude
			{spellID = 16177, unitID = "target", caster = "player", filter = "BUFF"},
			-- Earth Shield
			{spellID = 974, unitID = "target", caster = "player", filter = "BUFF"},
			-- Healing Way
			{spellID = 29203, unitID = "target", caster = "player", filter = "BUFF"},
			-- Lightning Shield (Special, Proc) [The Ten Storms]
			-- {spellID = 23552, unitID = "target", caster = "player", filter = "BUFF", absID = true},
			-- Totemic Power (Armor, Proc) [The Earthshatterer]
			{spellID = 28827, unitID = "target", caster = "player", filter = "BUFF", absID = true},
			-- Totemic Power (Attack Power, Proc) [The Earthshatterer]
			{spellID = 28826, unitID = "target", caster = "player", filter = "BUFF", absID = true},
			-- Totemic Power (Mp5, Proc) [The Earthshatterer]
			{spellID = 28824, unitID = "target", caster = "player", filter = "BUFF", absID = true},
			-- Totemic Power (Spell Power, Proc) [The Earthshatterer]
			{spellID = 28825, unitID = "target", caster = "player", filter = "BUFF", absID = true},
			-- Gladiator's Totem of the Third Wind
			{spellID = 34132, unitID = "target", caster = "player", filter = "BUFF"},
			-- Merciless Totem of the Third Wind
			{spellID = 42371, unitID = "target", caster = "player", filter = "BUFF"},
			-- Vengeful Totem of the Third Wind
			{spellID = 43729, unitID = "target", caster = "player", filter = "BUFF"},
			-- Brutal Totem of the Third Wind
			{spellID = 46099, unitID = "target", caster = "player", filter = "BUFF"},

			-- Trinket Effects
			-- Fecundity (Special, Use) [Ribbon of Sacrifice]
			{spellID = 38333, unitID = "target", caster = "player", filter = "BUFF"},
			-- Persistent Shield (Absorb, Use) [Scarab Brooch]
			{spellID = 26470, unitID = "target", caster = "player", filter = "BUFF", absID = true},
			-- Regeneration (HoT, Proc) [Fel Reaver's Piston]
			{spellID = 38324, unitID = "target", caster = "player", filter = "BUFF", absID = true},
		},
		--[[
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {"LEFT", PVE_PVP_CC_Anchor},
		},
		--]]
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = C.filger.cooldown_space,
			Alpha = 1,
			IconSize = C.filger.cooldown_size,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Self
			-- Bloodlust
			{spellID = 2825, filter = "CD"},
			-- Chain Lightning
			{spellID = 421, filter = "CD"},
			-- Earth Elemental Totem
			{spellID = 2062, filter = "CD"},
			-- Earth Shock
			{spellID = 8042, filter = "CD"},
			-- Earthbind Totem
			{spellID = 2484, filter = "CD"},
			-- Elemental Mastery
			{spellID = 16166, filter = "CD"},
			-- Fire Nova Totem
			{spellID = 1535, filter = "CD"},
			-- Flame Shock
			{spellID = 8050, filter = "CD"},
			-- Frost Shock
			{spellID = 8056, filter = "CD"},
			-- Grounding Totem
			{spellID = 8177, filter = "CD"},
			-- Heroism
			{spellID = 32182, filter = "CD"},
			-- Mana Tide Totem
			{spellID = 16190, filter = "CD"},
			-- Nature's Swiftness
			{spellID = 16188, filter = "CD"},
			-- Reincarnation
			{spellID = 20608, filter = "CD"},
			-- Shamanistic Rage
			{spellID = 30823, filter = "CD"},
			-- Stoneclaw Totem
			{spellID = 5730, filter = "CD"},
			-- Stormstrike
			{spellID = 17364, filter = "CD"},

			-- Racial
			-- Berserking (Mana)
			{spellID = 20554, filter = "CD", absID = true},
			-- Blood Fury (Physical)
			{spellID = 20572, filter = "CD", absID = true},
			-- Blood Fury (Both)
			{spellID = 33697, filter = "CD", absID = true},
			-- Blood Fury (Spell)
			{spellID = 33702, filter = "CD", absID = true},
			-- Gift of the Naaru (Draenei)
			{spellID = 28880, filter = "CD"},
			-- War Stomp (Tauren)
			{spellID = 20549, filter = "CD", absID = true},

			-- Items
			-- Back
			{slotID = 15, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Neck
			{slotID = 2, filter = "CD"},
			-- Rings
			{slotID = 11, filter = "CD"},
			{slotID = 12, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},
		},
	},
	["WARLOCK"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = C.filger.buffs_space,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Amplify Curse
			{spellID = 18288, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blood Pact (Imp)
			-- {spellID = 6307, unitID = "player", caster = "all", filter = "BUFF"},
			-- Consume Shadows (Voidwalker)
			-- {spellID = 17767, unitID = "pet", caster = "all", filter = "BUFF"},
			-- Demonic Circle: Summon
			-- {spellID = 48018, unitID = "player", caster = "player", filter = "BUFF"},
			-- Eye of Kilrogg
			-- {spellID = 126, unitID = "player", caster = "player", filter = "BUFF"},
			--[[
			-- Fire Shield r1 (Imp)
			{spellID = 2947, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- Fire Shield r2 (Imp)
			{spellID = 8316, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- Fire Shield r3 (Imp)
			{spellID = 8317, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- Fire Shield r4 (Imp)
			{spellID = 11770, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- Fire Shield r5 (Imp)
			{spellID = 11771, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- Fire Shield r6 (Imp)
			{spellID = 27269, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			--]]
			-- Health Funnel
			-- {spellID = 755, unitID = "player", caster = "player", filter = "BUFF"},
			-- Hellfire
			-- {spellID = 1949, unitID = "player", caster = "player", filter = "BUFF"},
			--[[
			-- Master Demonologist (Imp - Reduced Threat)
			{spellID = 23759, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Master Demonologist (Voidwalker - Reduced Physical Taken)
			{spellID = 23760, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Master Demonologist (Succubus - Increased Damage)
			{spellID = 23761, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Master Demonologist (Felhunter - Increased Resistance)
			{spellID = 23762, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Master Demonologist (Felguard - Increased Damage/Resistance)
			{spellID = 35702, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			--]]
			-- Paranoia (Felhunter)
			-- {spellID = 19480, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- Phase Shift (Imp)
			-- {spellID = 4511, unitID = "pet", caster = "all", filter = "BUFF"},
			-- Sacrifice (Voidwalker)
			{spellID = 7812, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadow Ward
			{spellID = 6229, unitID = "player", caster = "player", filter = "BUFF"},
			-- Soul Link
			-- {spellID = 25228, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tainted Blood (Felhunter)
			-- {spellID = 19478, unitID = "pet", caster = "all", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = C.filger.buffs_space,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Buffs
			-- Backlash
			{spellID = 34936, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nether Protection
			{spellID = 30300, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadow Trance
			{spellID = 17941, unitID = "player", caster = "player", filter = "BUFF"},

			-- Item Sets
			-- Flameshadow (Spell Power, Proc) [Voidheart Raiment]
			{spellID = 37379, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Insight (Spell Power, Proc) [Mana-Etched Regalia]
			{spellID = 37620, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Lesser Spell Blasting (Spell Power, Proc) [Spellstrike Infusion]
			{spellID = 32108, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadowflame (Spell Power, Proc) [Voidheart Raiment]
			{spellID = 37378, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- Trinkets
			-- Class
			-- Blessing of the Black Book (Special, Use) [The Black Book]
			{spellID = 23720, unitID = "pet", caster = "player", filter = "BUFF"},
			-- Massive Destruction (Spell Critical Strike, Use) [Hazza'rah's Charm of Destruction]
			{spellID = 24543, unitID = "player", caster = "player", filter = "BUFF"},
			-- Power of the Ashtongue (Spell Power, Proc) [Ashtongue Talisman of Shadows]
			{spellID = 40480, unitID = "player", caster = "player", filter = "BUFF"},

			-- Darkmoon Cards
			-- Aura of the Blue Dragon (Special, Proc) [Darkmoon Card: Blue Dragon]
			{spellID = 23684, unitID = "player", caster = "player", filter = "BUFF"},
			-- Aura of the Crusader (Spell Power, Proc) [Darkmoon Card: Crusade]
			{spellID = 39441, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Aura of Wrath (Critical Strike, Proc) [Darkmoon Card: Wrath]
			{spellID = 39443, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dementia (Special Power, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin
			{spellID = 41404, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Dementia +5% (Special Power, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin
			{spellID = 41406, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Dementia -5% (Special Power, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin
			{spellID = 41409, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Manic (Haste, Proc) [Darkmoon Card: Madness] - All classes except Hunter
			{spellID = 41005, unitID = "player", caster = "player", filter = "BUFF"},
			-- Martyr Complex (Stamina, Proc) [Darkmoon Card: Madness] - All classes
			{spellID = 41011, unitID = "player", caster = "player", filter = "BUFF"},
			-- Megalomania (Spell Power, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin
			{spellID = 40999, unitID = "player", caster = "player", filter = "BUFF"},
			-- Narcissism (Intellect, Proc) [Darkmoon Card: Madness] - Druid, Shaman, Priest, Warlock, Mage, Paladin, Hunter
			{spellID = 41009, unitID = "player", caster = "player", filter = "BUFF"},
			-- Paranoia (Critical Strike, Proc) [Darkmoon Card: Madness] - All classes except Hunter
			{spellID = 41002, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- PvP Trinkets
			-- Aura of Protection (Absorb, Use) [Arena Grand Master]
			{spellID = 23506, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage Absorb (Absorb, Use) [Arathi Basin Trinket]
			{spellID = 25750, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tremendous Fortitude (Health, Use) [Battlemaster]
			{spellID = 44055, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shell of Deterrence (Absorb, Use) [Runed Fungalcap]
			{spellID = 31771, unitID = "player", caster = "player", filter = "BUFF"},

			-- Universal
			-- Arcane Shroud (Threat Reduction, Use) [Fetish of the Sand Reaver]
			{spellID = 26400, unitID = "player", caster = "player", filter = "BUFF"},
			-- Chitinous Spikes (Special, Use) [Fetish of Chitinous Spikes]
			{spellID = 26168, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of the Scale (Special, Use) [Heart of the Scale]
			{spellID = 17275, unitID = "player", caster = "player", filter = "BUFF"},
			-- Loatheb's Reflection (Magic Resistance, Use) [Loatheb's Reflection]
			{spellID = 28778, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mercurial Shield (Magic Resistance, Use) [Petrified Scarab]
			{spellID = 26464, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Burrower's Shell (Absorb, Use) [The Burrower's Shell]
			{spellID = 29506, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Lion Horn of Stormwind (Special, Proc) [The Lion Horn of Stormwind]
			{spellID = 18946, unitID = "player", caster = "player", filter = "BUFF"},

			-- Damage [Magic]
			-- Arcane Energy (Healing Power, Use) [Ancient Draenei Arcane Relic / Vengeance of the Illidari]
			{spellID = 33662, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ascendance (Spell Power, Use) [Talisman of Ascendance]
			{spellID = 28204, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Blessing of the Silver Crescent (Spell Power, Use) [Icon of the Silver Crescent]
			{spellID = 35163, unitID = "player", caster = "player", filter = "BUFF"},
			-- Call of the Nexus (Spell Power, Proc) [Shiffar's Nexus-Horn]
			{spellID = 34321, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combat Gallantry (Spell Power, Proc) [Airman's Ribbon of Gallantry]
			{spellID = 41263, unitID = "player", caster = "player", filter = "BUFF"},
			-- Consume Essence (Special, Use) [Oculus of the Hidden Eye]
			{spellID = 33013, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Crimson Serpent (Spell Power, Use) [Figurine - Crimson Serpent]
			{spellID = 46783, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dark Iron Pipeweed (Spell Power, Use) [Dark Iron Smoking Pipe]
			{spellID = 51953, unitID = "player", caster = "player", filter = "BUFF"},
			-- Electrical Charge (Special, Proc) [The Lightning Capacitor]
			{spellID = 37658, unitID = "player", caster = "player", filter = "BUFF"},
			-- Enlightenment (Mana Regeneration, Use) [Pendant of the Violet Eye]
			{spellID = 35095, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Ephemeral Power (Spell Power, Use) [Talisman of Ephemeral Power]
			{spellID = 23271, unitID = "player", caster = "player", filter = "BUFF"},
			-- Essence of Sapphiron (Spell Power, Use) [The Restrained Essence of Sapphiron]
			{spellID = 28779, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fel Infusion (Spell Haste, Use) [The Skull of Gul'dan]
			{spellID = 40396, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Focused Power (Spell Power, Use) [Ancient Crystal Talisman / Glowing Crystal Insignia]
			{spellID = 32355, unitID = "player", caster = "player", filter = "BUFF"},
			-- Living Ruby Serpent (Spell Power, Use) [Figurine - Living Ruby Serpent]
			{spellID = 31040, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mojo Madness (Spell Power, Use) [Hex Shrunken Head]
			{spellID = 43712, unitID = "player", caster = "player", filter = "BUFF"},
			-- Obsidian Insight (Spell Power, Special, Use) [Eye of Moam]
			{spellID = 26166, unitID = "player", caster = "player", filter = "BUFF"},
			-- Pagle's Broken Reel (Spell Hit, Use) [Nat Pagle's Broken Reel]
			{spellID = 24610, unitID = "player", caster = "player", filter = "BUFF"},
			-- Power Circle (Spell Power, Use) [Shifting Naaru Sliver]
			{spellID = 45043, unitID = "player", caster = "player", filter = "BUFF"},
			-- Recurring Power (Spell Power, Proc) [Eye of Magtheridon]
			{spellID = 34747, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spell Haste (Spell Haste, Proc) [Quagmirran's Eye]
			{spellID = 33370, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Spell Power (Spell Power, Use) [Scryer's Bloodgem / Xi'ri's Gift]
			{spellID = 35337, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			--[[
			-- Spell Power (Spell Power, Use) [Starkiller's Bauble]
			{spellID = 36432, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Spell Power (Spell Power, Use) [Terokkar Tablet of Vim]
			{spellID = 39201, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			--]]
			-- The Arcanist's Stone (Spell Power, Use) [Arcanist's Stone]
			{spellID = 34000, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Eye of Diminution (Special, Use) [Eye of Diminution]
			{spellID = 28862, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unstable Currents (Spell Power, Proc) [Sextant of Unstable Currents]
			{spellID = 38348, unitID = "player", caster = "player", filter = "BUFF"},
			-- Unstable Power (Spell Power, Use) [Zandalarian Hero Charm]
			{spellID = 24659, unitID = "player", caster = "player", filter = "BUFF"},

			-- Helms
			-- Arcane Might (Spell Power, Proc) [Circlet of Arcane Might]
			{spellID = 31037, unitID = "player", caster = "player", filter = "BUFF"},

			-- Necks
			-- Light's Wrath (Spell Power, Proc) [Shattered Sun Pendant of Acumen - Aldor]
			{spellID = 45479, unitID = "player", caster = "player", filter = "BUFF"},

			-- Rings
			-- Band of the Eternal Sage (Spell Power, Proc) [Band of the Eternal Sage]
			{spellID = 35084, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spell Blasting (Spell Power, Proc) [Wrath of Cenarius]
			{spellID = 25906, unitID = "player", caster = "player", filter = "BUFF"},

			-- Weapons
			-- Mental Protection Field (Immunity, Use) [Staff of Disintegration]
			{spellID = 36480, unitID = "player", caster = "all", filter = "BUFF"},

			-- Meta Gems
			-- Focus (Spell Haste, Proc) [Mystical Skyfire Diamond]
			{spellID = 18803, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- Enchants
			-- Spellsurge (Mana Regeneration to Party) [Enchant Weapon - Spellsurge]
			{spellID = 27996, unitID = "player", caster = "all", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = C.filger.buffs_space,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Aftermath
			{spellID = 18118, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Corruption r1
			{spellID = 172, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Corruption r2
			{spellID = 6222, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Corruption r3
			{spellID = 6223, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Corruption r4
			{spellID = 7648, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Corruption r5
			{spellID = 11671, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Corruption r6
			{spellID = 11672, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Corruption r7
			{spellID = 25311, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Corruption r8
			{spellID = 27216, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Cripple (Doomguard)
			{spellID = 20812, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Curse of Agony
			{spellID = 980, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Curse of Doom
			{spellID = 603, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Curse of Exhaustion
			{spellID = 18223, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Curse of Idiocy
			{spellID = 1010, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Curse of Recklessness
			{spellID = 704, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Curse of Tongues
			{spellID = 1714, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Curse of Weakness r1
			{spellID = 702, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Curse of Weakness r2
			{spellID = 1108, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Curse of Weakness r3
			{spellID = 6205, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Curse of Weakness r4
			{spellID = 7646, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Curse of Weakness r5
			{spellID = 11707, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Curse of Weakness r6
			{spellID = 11708, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Curse of Weakness r7
			{spellID = 27224, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Curse of Weakness r8
			{spellID = 30909, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Curse of the Elements
			{spellID = 1490, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Death Coil
			{spellID = 6789, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Drain Life
			{spellID = 689, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Drain Mana
			{spellID = 5138, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Drain Soul
			{spellID = 1120, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Enslave Demon
			{spellID = 1098, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Howl of Terror
			{spellID = 5484, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Immolate
			{spellID = 348, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Intercept Stun (Felguard)
			{spellID = 30153, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Pyroclasm
			{spellID = 18093, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Rain of Fire
			-- {spellID = 5740, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Seed of Corruption
			{spellID = 27243, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Seduction (Succubus)
			{spellID = 6358, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Shadowburn
			-- {spellID = 29341, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Shadowfury
			{spellID = 30283, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Shadow Embrace
			{spellID = 32386, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Shadow Vulnerability r1 (Improved Shadow Bolt)
			{spellID = 17794, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Shadow Vulnerability r2 (Improved Shadow Bolt)
			{spellID = 17798, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Shadow Vulnerability r3 (Improved Shadow Bolt)
			{spellID = 17797, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Shadow Vulnerability r4 (Improved Shadow Bolt)
			{spellID = 17799, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Shadow Vulnerability r5 (Improved Shadow Bolt)
			{spellID = 17800, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Siphon Life
			{spellID = 18265, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Spell Lock (Felhunter)
			{spellID = 24259, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Rend (Doomguard)
			{spellID = 21949, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Tainted Blood Effect (Felhunter)
			{spellID = 19479, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Unstable Affliction r1
			{spellID = 30108, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Unstable Affliction r2
			{spellID = 30404, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Unstable Affliction r3
			{spellID = 30405, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Unstable Affliction (Silence)
			{spellID = 31117, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},

			-- Item Sets
			-- Corrupted Fear (Special, Proc) [Dreadmist Raiment / Deathmist Raiment]
			{spellID = 32108, unitID = "target", caster = "player", filter = "DEBUFF"},

			-- Trinket Effects

			-- Enchants
			-- Deathfrost [Enchant Weapon - Deathfrost]
			{spellID = 46629, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
		--[[
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {"LEFT", T_DE_BUFF_BAR_Anchor},
		},
		--]]
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {"LEFT", PVE_PVP_CC_Anchor},

			-- Banish
			{spellID = 710, unitID = "focus", caster = "player", filter = "DEBUFF"},
			-- Fear
			{spellID = 5782, unitID = "focus", caster = "player", filter = "DEBUFF"},
		},
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = C.filger.cooldown_space,
			Alpha = 1,
			IconSize = C.filger.cooldown_size,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Self
			-- Amplify Curse
			{spellID = 18288, filter = "CD"},
			-- Conflagrate
			{spellID = 17962, filter = "CD"},
			-- Curse of Doom
			{spellID = 603, filter = "CD"},
			-- Death Coil
			{spellID = 6789, filter = "CD"},
			-- Fel Domination
			{spellID = 18708, filter = "CD"},
			-- Howl of Terror
			{spellID = 5484, filter = "CD"},
			-- Inferno
			{spellID = 1122, filter = "CD", absID = true},
			-- Ritual of Doom
			{spellID = 18540, filter = "CD"},
			-- Ritual of Souls
			{spellID = 29893, filter = "CD"},
			-- Shadow Ward
			{spellID = 6229, filter = "CD"},
			-- Shadowburn
			{spellID = 17877, filter = "CD"},
			-- Shadowfury
			{spellID = 30283, filter = "CD"},
			-- Soul Fire
			{spellID = 6353, filter = "CD"},
			-- Soulshatter
			{spellID = 29858, filter = "CD"},

			-- Pets
			-- Intercept (Felguard)
			{spellID = 30151, filter = "CD"},
			-- Rain of Fire (Doomguard)
			{spellID = 4629, filter = "CD", absID = true},
			-- Spell Lock (Felhunter)
			{spellID = 19244, filter = "CD"},
			-- Suffering (Voidwalker)
			{spellID = 17735, filter = "CD"},

			-- Racial
			-- Arcane Torrent (Mana)
			{spellID = 28730, filter = "CD", absID = true},
			-- Blood Fury (Both)
			{spellID = 33697, filter = "CD", absID = true},
			-- Blood Fury (Spell)
			{spellID = 33702, filter = "CD", absID = true},
			-- Cannibalize (Forsaken)
			{spellID = 20577, filter = "CD"},
			-- Escape Artist (Gnome)
			{spellID = 20589, filter = "CD"},
			-- Perception (Human)
			{spellID = 20600, filter = "CD"},
			-- Will of the Forsaken (Forsaken)
			{spellID = 7744, filter = "CD"},

			-- Items
			-- Back
			{slotID = 15, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Neck
			{slotID = 2, filter = "CD"},
			-- Rings
			{slotID = 11, filter = "CD"},
			{slotID = 12, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},
		},
	},
	["WARRIOR"] = {
		{
			Name = "P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = C.filger.buffs_space,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_BUFF_ICON_Anchor},

			-- Battle Shout
			{spellID = 6673, unitID = "player", caster = "all", filter = "BUFF"},
			-- Berserker Rage
			{spellID = 18499, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bloodrage
			{spellID = 29131, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bloodthirst
			{spellID = 23885, unitID = "player", caster = "player", filter = "BUFF"},
			-- Commanding Shout
			{spellID = 469, unitID = "player", caster = "all", filter = "BUFF"},
			-- Death Wish
			{spellID = 12292, unitID = "player", caster = "player", filter = "BUFF"},
			-- Flurry
			{spellID = 12966, unitID = "player", caster = "player", filter = "BUFF"},
			-- Last Stand
			{spellID = 12975, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rampage (Base)
			-- {spellID = 29801, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Rampage (Stack) r1
			{spellID = 30029, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Rampage (Stack) r2
			{spellID = 30030, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Rampage (Stack) r3
			{spellID = 30031, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Recklessness
			{spellID = 1719, unitID = "player", caster = "player", filter = "BUFF"},
			-- Retaliation
			{spellID = 20230, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shield Wall
			{spellID = 871, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spell Reflection
			{spellID = 23920, unitID = "player", caster = "player", filter = "BUFF"},
			-- Sweeping Strikes
			{spellID = 12328, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "P_PROC_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = C.filger.buffs_space,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", P_PROC_ICON_Anchor},

			-- Buffs
			-- Blood Craze
			{spellID = 16488, unitID = "player", caster = "player", filter = "BUFF"},
			-- Enrage
			{spellID = 12880, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Second Wind
			{spellID = 29841, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- Item Sets
			-- Battle Rush (Physical Haste, Proc) [Destroyer Armor]
			{spellID = 37526, unitID = "player", caster = "player", filter = "BUFF"},
			-- Blade Turning (Absorb, Proc) [Warbringer Armor]
			{spellID = 37515, unitID = "player", caster = "player", filter = "BUFF"},
			-- Cheat Death (Special, Proc) [Dreadnaught's Battlegear]
			{spellID = 28846, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heroic Resolution (Attack Power, Proc) [Desolation Battlegear / Doomplate Battlegear / Wastewalker Armor]
			{spellID = 37612, unitID = "player", caster = "player", filter = "BUFF"},
			-- Overpower (Special, Proc) [Destroyer Battlegear]
			{spellID = 37529, unitID = "player", caster = "player", filter = "BUFF"},
			-- Parry (Parry, Proc) [Battlegear of Wrath]
			{spellID = 23547, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Reinforced Shield (Block Value, Proc) [Destroyer Armor]
			{spellID = 37523, unitID = "player", caster = "player", filter = "BUFF"},
			-- Revenge (Special, Proc) [Warbringer Armor]
			{spellID = 37517, unitID = "player", caster = "player", filter = "BUFF"},
			-- Spirits of the Lost (Special, Proc) [Dreadnaught Battlegear]
			{spellID = 61571, unitID = "player", caster = "player", filter = "BUFF"},
			-- Warrior's Wrath (Special, Proc) [Battlegear of Wrath]
			{spellID = 21887, unitID = "player", caster = "player", filter = "BUFF"},

			-- Ranged
			-- Santos' Blessing (Attack Power, Proc) [Don Santos' Famous Hunting Rifle]
			{spellID = 38293, unitID = "player", caster = "player", filter = "BUFF"},

			-- Trinkets
			-- Class
			-- Fire Blood (Strength, Proc) [Ashtongue Talisman of Valor]
			{spellID = 40459, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gift of Life (Health, Use) [Lifegiving Gem]
			{spellID = 23725, unitID = "player", caster = "player", filter = "BUFF"},

			-- Darkmoon Cards
			-- Aura of the Blue Dragon (Special, Proc) [Darkmoon Card: Blue Dragon]
			{spellID = 23684, unitID = "player", caster = "player", filter = "BUFF"},
			-- Aura of the Crusader (Attack Power, Proc) [Darkmoon Card: Crusade]
			{spellID = 39439, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Aura of Wrath (Critical Strike, Proc) [Darkmoon Card: Wrath]
			{spellID = 39443, unitID = "player", caster = "player", filter = "BUFF"},
			-- Delusional (Attack Power, Proc) [Darkmoon Card: Madness] - Rogue, Hunter, Paladin, Warrior, Druid, Shaman
			{spellID = 40997, unitID = "player", caster = "player", filter = "BUFF"},
			-- Kleptomania (Agility, Proc) [Darkmoon Card: Madness] - Warrior, Rogue, Paladin, Hunter, Druid
			{spellID = 40998, unitID = "player", caster = "player", filter = "BUFF"},
			-- Manic (Haste, Proc) [Darkmoon Card: Madness] - All classes except Hunter
			{spellID = 41005, unitID = "player", caster = "player", filter = "BUFF"},
			-- Martyr Complex (Stamina, Proc) [Darkmoon Card: Madness] - All classes
			{spellID = 41011, unitID = "player", caster = "player", filter = "BUFF"},
			-- Paranoia (Critical Strike, Proc) [Darkmoon Card: Madness] - All classes except Hunter
			{spellID = 41002, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Sociopath (Strength, Proc) [Darkmoon Card: Madness] - Paladin, Rogue, Druid, Warrior
			{spellID = 39511, unitID = "player", caster = "player", filter = "BUFF"},

			-- PvP Trinkets
			-- Aura of Protection (Absorb, Use) [Arena Grand Master]
			{spellID = 23506, unitID = "player", caster = "player", filter = "BUFF"},
			-- Damage Absorb (Absorb, Use) [Arathi Basin Trinket]
			{spellID = 25750, unitID = "player", caster = "player", filter = "BUFF"},
			-- Tremendous Fortitude (Health, Use) [Battlemaster]
			{spellID = 44055, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shell of Deterrence (Absorb, Use) [Runed Fungalcap]
			{spellID = 31771, unitID = "player", caster = "player", filter = "BUFF"},

			-- Universal
			-- Arcane Shroud (Threat Reduction, Use) [Fetish of the Sand Reaver]
			{spellID = 26400, unitID = "player", caster = "player", filter = "BUFF"},
			-- Chitinous Spikes (Special, Use) [Fetish of Chitinous Spikes]
			{spellID = 26168, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heart of the Scale (Special, Use) [Heart of the Scale]
			{spellID = 17275, unitID = "player", caster = "player", filter = "BUFF"},
			-- Loatheb's Reflection (Magic Resistance, Use) [Loatheb's Reflection]
			{spellID = 28778, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mercurial Shield (Magic Resistance, Use) [Petrified Scarab]
			{spellID = 26464, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Burrower's Shell (Absorb, Use) [The Burrower's Shell]
			{spellID = 29506, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Lion Horn of Stormwind (Special, Proc) [The Lion Horn of Stormwind]
			{spellID = 18946, unitID = "player", caster = "player", filter = "BUFF"},

			-- Tanking
			-- Adamantine Shell (Armor, Use) [Adamantine Figurine]
			{spellID = 33479, unitID = "player", caster = "player", filter = "BUFF"},
			-- Argussian Compass (Absorb, Use) [Argussian Compass]
			{spellID = 39228, unitID = "player", caster = "player", filter = "BUFF"},
			-- Avoidance (Dodge, Use) [Charm of Alacrity]
			{spellID = 32600, unitID = "player", caster = "player", filter = "BUFF"},
			-- Brittle Armor (Special, Use) [Zandalarian Hero Badge]
			{spellID = 24575, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dark Iron Luck (Block Value, Use) [Coren's Lucky Coin]
			{spellID = 51952, unitID = "player", caster = "player", filter = "BUFF"},
			-- Dawnstone Crab (Dodge, Use) [Figurine - Dawnstone Crab]
			{spellID = 31039, unitID = "player", caster = "player", filter = "BUFF"},
			-- Displacement (Defense Rating, Use) [Scarab of Displacement]
			{spellID = 38351, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Empyrean Tortoise (Dodge, Use) [Figurine - Empyrean Tortoise]
			{spellID = 46780, unitID = "player", caster = "player", filter = "BUFF"},
			-- Evasive Maneuvers (Dodge, Proc) [Commendation of Kael'thas]
			{spellID = 45058, unitID = "player", caster = "player", filter = "BUFF"},
			-- Force of Will (Special, Proc) [Force of Will]
			{spellID = 15595, unitID = "player", caster = "player", filter = "BUFF"},
			-- Glyph of Deflection (Block Value, Use) [Glyph of Deflection]
			{spellID = 28773, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gnome Ingenuity (Block Value, Use) [Gnomeregan Auto-Blocker 600]
			{spellID = 35169, unitID = "player", caster = "player", filter = "BUFF"},
			-- Hardened Skin (Armor, Use) [Ancient Aqir Artifact]
			{spellID = 43713, unitID = "player", caster = "player", filter = "BUFF"},
			-- Phalanx (Block Rating, Use) [Dabiri's Enigma]
			{spellID = 36372, unitID = "player", caster = "player", filter = "BUFF"},
			-- Protector's Vigor (Health, Use) [Shadowmoon Insignia]
			{spellID = 40464, unitID = "player", caster = "player", filter = "BUFF"},
			-- Regeneration (HoT, Use) [Spyglass of the Hidden Fleet]
			-- {spellID = 38325, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Tenacity (Health, Use) [Brooch of the Immortal King]
			-- {spellID = 40538, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Tenacity (Health, Use) [Regal Protectorate]
			{spellID = 33668, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Tenacity (Health, Use) [Steely Naaru Sliver]
			-- {spellID = 45049, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Time's Favor (Dodge, Use) [Moroes' Lucky Pocket Watch]
			{spellID = 34519, unitID = "player", caster = "player", filter = "BUFF"},
			-- Vigilance of the Colossus (Special, Use) [Figurine of the Colossus]
			{spellID = 33089, unitID = "player", caster = "player", filter = "BUFF"},

			-- Damage [Physical]
			-- Ancient Power (Attack Power, Use) [Core of Ar'kelos]
			{spellID = 35733, unitID = "player", caster = "player", filter = "BUFF"},
			-- Armor Penetration (Armor Penetration, Use) [Icon of Unyielding Courage]
			{spellID = 34106, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Battle Trance (Attack Power, Proc) [Blackened Naaru Sliver]
			{spellID = 45040, unitID = "player", caster = "player", filter = "BUFF"},
			-- Burning Hatred (Attack Power, Use) [Ogre Mauler's Badge / Uniting Charm]
			{spellID = 32362, unitID = "player", caster = "player", filter = "BUFF"},
			-- Call of the Berserker (Attack Power, Use) [Berserker's Call]
			{spellID = 43716, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combat Insight (Attack Power, Proc) [Blackened Naaru Sliver]
			{spellID = 45041, unitID = "player", caster = "player", filter = "BUFF"},
			-- Combat Valor (Attack Power, Proc) [Skyguard Silver Cross]
			{spellID = 41261, unitID = "player", caster = "player", filter = "BUFF"},
			-- Consume Life (Special, Use) [Fetish of the Fallen]
			{spellID = 33015, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Dire Drunkard (Attack Power, Use) [Empty Mug of Direbrew]
			{spellID = 51955, unitID = "player", caster = "player", filter = "BUFF"},
			-- Disdain (Attack Power, Proc) [Shard of Contempt]
			{spellID = 45053, unitID = "player", caster = "player", filter = "BUFF"},
			-- Earthstrike (Attack Power, Use) [Earthstrike]
			{spellID = 25891, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ferocity (Attack Power, Use) [Ancient Draenei War Talisman / Bladefist's Breadth]
			{spellID = 33667, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Forceful Strike (Armor Penetration, Proc) [Madness of the Betrayer]
			{spellID = 40477, unitID = "player", caster = "player", filter = "BUFF"},
			-- Fury of the Crashing Waves (Attack Power, Proc) [Tsunami Talisman]
			{spellID = 42084, unitID = "player", caster = "player", filter = "BUFF"},
			--[[
			-- Haste (Physical Haste, Use) [Abacus of Violent Odds]
			{spellID = 33807, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Haste (Physical Haste, Proc) [Dragonspine Trophy]
			{spellID = 34775, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			--]]
			-- Heightened Reflexes (Agility, Use) [Badge of Tenacity]
			{spellID = 40729, unitID = "player", caster = "player", filter = "BUFF"},
			-- Heroism (Attack Power, Use) [Terokkar Tablet of Precision]
			-- {spellID = 39200, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Insight of the Qiraji (Armor Penetration, Use) [Badge of the Swarmguard]
			{spellID = 26481, unitID = "player", caster = "player", filter = "BUFF"},
			-- Jom Gabbar (Attack Power, Use) [Jom Gabbar]
			{spellID = 29604, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Kiss of the Spider (Physical Haste, Use) [Kiss of the Spider]
			{spellID = 28866, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lust for Battle (Attack Power, Use) [Bloodlust Brooch]
			{spellID = 35166, unitID = "player", caster = "player", filter = "BUFF"},
			-- Nightseye Panther (Attack Power, Use) [Figurine - Nightseye Panther]
			{spellID = 31047, unitID = "player", caster = "player", filter = "BUFF"},
			-- Rage of the Unraveller (Attack Power, Proc) [Hourglass of the Unraveller]
			{spellID = 33649, unitID = "player", caster = "player", filter = "BUFF"},
			-- Restless Strength (Special, Use) [Zandalarian Hero Medallion]
			{spellID = 24662, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadowsong Panther (Attack Power, Use) [Figurine - Shadowsong Panther]
			{spellID = 46784, unitID = "player", caster = "player", filter = "BUFF"},
			-- Slayer's Crest (Attack Power, Use) [Slayer's Crest]
			{spellID = 28777, unitID = "player", caster = "player", filter = "BUFF"},
			-- Valor (Attack Power, Use) [Crystalforged Trinket]
			{spellID = 40724, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- Necks
			-- Arcane Insight (Expertise, Proc) [Shattered Sun Pendant of Resolve - Scryer]
			{spellID = 45431, unitID = "player", caster = "player", filter = "BUFF"},
			-- Light's Strength (Attack Power, Proc) [Shattered Sun Pendant of Might - Aldor]
			{spellID = 45480, unitID = "player", caster = "player", filter = "BUFF"},
			-- Light's Ward (Dodge, Proc) [Shattered Sun Pendant of Resolve - Aldor]
			{spellID = 45432, unitID = "player", caster = "player", filter = "BUFF"},

			-- Chest
			-- Valor (Health, Strength, Use) [Bulwark of Kings / Bulwark of the Ancient Kings]
			-- {spellID = 34511, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- Rings
			-- Band of the Eternal Champion (Attack Power, Proc) [Band of the Eternal Champion]
			{spellID = 35081, unitID = "player", caster = "player", filter = "BUFF"},
			-- Band of the Eternal Defender (Armor, Proc) [Band of the Eternal Defender]
			{spellID = 35078, unitID = "player", caster = "player", filter = "BUFF"},

			-- Weapons
			-- Armor Buff (Armor, Proc) [Greatsword of Forlorn Visions]
			{spellID = 34199, unitID = "player", caster = "player", filter = "BUFF"},
			-- Bladestorm (Physical Haste, Proc) [The Bladefist]
			{spellID = 35131, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Blinding Speed (Physical Haste, Proc) [Blackout Truncheon]
			{spellID = 33489, unitID = "player", caster = "player", filter = "BUFF"},
			-- Haste (Physical Haste, Proc) [Manual Crowd Pummeler]
			{spellID = 13494, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Haste (Physical Haste, Proc) [Empyrean Demolisher / Drakefist Hammer / Dragonmaw / Dragonstrike]
			{spellID = 21165, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Heartrazor (Attack Power, Proc) [Heartrazor]
			{spellID = 36041, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mental Protection Field (Immunity, Use) [Staff of Disintegration]
			{spellID = 36480, unitID = "player", caster = "all", filter = "BUFF"},
			-- Speed Infusion (Movement Speed, Physical Attack Speed, Proc) [Devastation / Warp Slicer]
			{spellID = 36479, unitID = "player", caster = "player", filter = "BUFF"},
			-- Strength of the Champion (Strength, Proc) [Arcanite Champion / Khorium Champion]
			{spellID = 16916, unitID = "player", caster = "player", filter = "BUFF"},
			-- The Twin Blades of Azzinoth (Physical Haste, Proc) [The Twin Blades of Azzinoth]
			{spellID = 41435, unitID = "player", caster = "player", filter = "BUFF"},
			-- World Breaker (Physical Critical Strike, Proc) [World Breaker]
			{spellID = 36111, unitID = "player", caster = "player", filter = "BUFF"},

			-- Meta Gems
			-- Skyfire Swiftness (Physical Haste, Proc) [Thundering Skyfire Diamond]
			{spellID = 39959, unitID = "player", caster = "player", filter = "BUFF"},

			-- Enchants
			-- Executioner [Enchant Weapon - Executioner]
			{spellID = 42976, unitID = "player", caster = "player", filter = "BUFF"},
			-- Holy Strength (Strength) [Enchant Weapon - Crusader]
			{spellID = 20007, unitID = "player", caster = "player", filter = "BUFF"},
			-- Lightning Speed (Agility and Physical Attack Speed) [Enchant Weapon - Mongoose]
			{spellID = 28093, unitID = "player", caster = "player", filter = "BUFF"},
		},
		{
			Name = "T_DEBUFF_ICON",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = C.filger.buffs_space,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", T_DEBUFF_ICON_Anchor},

			-- Blood Frenzy
			{spellID = 30069, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Challenging Shout
			{spellID = 1161, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Charge Stun
			{spellID = 7922, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Concussion Blow
			{spellID = 12809, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Demoralizing Shout
			{spellID = 1160, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Disarm
			{spellID = 676, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Hamstring r1
			{spellID = 1715, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Hamstring r2
			{spellID = 7372, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Hamstring r3
			{spellID = 7373, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Hamstring r4
			{spellID = 25212, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Improved Hamstring
			{spellID = 23694, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Intercept Stun
			{spellID = 20253, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Intimidating Shout (Cower)
			{spellID = 20511, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Intimidating Shout (Fear)
			{spellID = 5246, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Mocking Blow
			{spellID = 694, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Mortal Strike
			{spellID = 12294, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Piercing Howl
			{spellID = 12323, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Rend r1
			{spellID = 772, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Rend r2
			{spellID = 6546, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Rend r3
			{spellID = 6547, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Rend r4
			{spellID = 6548, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Rend r5
			{spellID = 11572, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Rend r6
			{spellID = 11573, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Rend r7
			{spellID = 11574, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Rend r8
			{spellID = 25208, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Revenge Stun
			{spellID = 11574, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Shield Bash - Silenced
			{spellID = 18498, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Sunder Armor
			{spellID = 7386, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Thunder Clap r1
			{spellID = 6343, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Thunder Clap r2
			{spellID = 8198, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Thunder Clap r3
			{spellID = 8204, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Thunder Clap r4
			{spellID = 8205, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Thunder Clap r5
			{spellID = 11580, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Thunder Clap r6
			{spellID = 11581, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Thunder Clap r7
			{spellID = 25264, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},

			-- Mace Specialization
			-- Mace Stun Effect
			{spellID = 5530, unitID = "target", caster = "player", filter = "DEBUFF"},

			-- Trinket Effects

			-- Enchants
			-- Chilled [Enchant Weapon - Icy Chill]
			{spellID = 20005, unitID = "target", caster = "player", filter = "DEBUFF", absID = true},
			-- Deathfrost [Enchant Weapon - Deathfrost]
			{spellID = 46629, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Smite Demon [Enchant Weapon - Demonslaying]
			{spellID = 13907, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Unholy Curse [Enchant Weapon - Unholy Weapon]
			{spellID = 20006, unitID = "target", caster = "player", filter = "DEBUFF"},
			-- Venomhide Poison
			{spellID = 14795, unitID = "target", caster = "player", filter = "DEBUFF"},
		},
		--[[
		{
			Name = "T_DE/BUFF_BAR",
			Direction = "UP",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 186,
			Position = {"LEFT", T_DE_BUFF_BAR_Anchor},
		},
		--]]
		--[[
		{
			Name = "PVE/PVP_CC",
			Direction = "DOWN",
			IconSide = "LEFT",
			Mode = "BAR",
			Interval = 3,
			Alpha = 1,
			IconSize = 25,
			BarWidth = 189,
			Position = {"LEFT", PVE_PVP_CC_Anchor},
		},
		--]]
		{
			Name = "COOLDOWN",
			Direction = "RIGHT",
			Mode = "ICON",
			Interval = C.filger.cooldown_space,
			Alpha = 1,
			IconSize = C.filger.cooldown_size,
			Position = {"TOP", COOLDOWN_Anchor},

			-- Self
			-- Berserker Rage
			{spellID = 18499, filter = "CD"},
			-- Bloodrage
			{spellID = 2687, filter = "CD"},
			-- Bloodthirst
			{spellID = 23881, filter = "CD"},
			-- Challenging Shout
			{spellID = 1161, filter = "CD"},
			-- Charge
			{spellID = 100, filter = "CD"},
			-- Concussion Blow
			{spellID = 12809, filter = "CD"},
			-- Death Wish
			{spellID = 12292, filter = "CD"},
			-- Disarm
			{spellID = 676, filter = "CD", absID = true},
			-- Heroic Strike
			{spellID = 78, filter = "CD"},
			-- Intercept
			{spellID = 20252, filter = "CD"},
			-- Intervene
			{spellID = 3411, filter = "CD"},
			-- Intimidating Shout
			{spellID = 5246, filter = "CD"},
			-- Last Stand
			{spellID = 12975, filter = "CD"},
			-- Mocking Blow
			{spellID = 694, filter = "CD"},
			-- Mortal Strike
			{spellID = 12294, filter = "CD"},
			-- Overpower
			{spellID = 7384, filter = "CD"},
			-- Pummel
			{spellID = 6552, filter = "CD", absID = true},
			-- Recklessness
			{spellID = 1719, filter = "CD"},
			-- Retaliation
			{spellID = 20230, filter = "CD"},
			-- Revenge
			{spellID = 6572, filter = "CD"},
			-- Shield Bash
			{spellID = 72, filter = "CD"},
			-- Shield Block
			{spellID = 2565, filter = "CD"},
			-- Shield Slam
			{spellID = 23922, filter = "CD"},
			-- Shield Wall
			{spellID = 871, filter = "CD"},
			-- Spell Reflection
			{spellID = 23920, filter = "CD"},
			-- Sweeping Strikes
			{spellID = 12328, filter = "CD"},
			-- Taunt
			{spellID = 355, filter = "CD"},
			-- Thunder Clap
			{spellID = 6343, filter = "CD", absID = true},
			-- Whirlwind
			{spellID = 1680, filter = "CD", absID = true},

			-- Racial
			-- Berserking (Rage)
			{spellID = 26296, filter = "CD", absID = true},
			-- Blood Fury (Physical)
			{spellID = 20572, filter = "CD", absID = true},
			-- Blood Fury (Both)
			{spellID = 33697, filter = "CD", absID = true},
			-- Cannibalize (Forsaken)
			{spellID = 20577, filter = "CD"},
			-- Escape Artist (Gnome)
			{spellID = 20589, filter = "CD"},
			-- Gift of the Naaru (Draenei)
			{spellID = 28880, filter = "CD"},
			-- Perception (Human)
			{spellID = 20600, filter = "CD"},
			-- Shadowmeld (Night Elf)
			{spellID = 20580, filter = "CD"},
			-- Stoneform (Dwarf)
			{spellID = 20594, filter = "CD"},
			-- War Stomp (Tauren)
			{spellID = 20549, filter = "CD", absID = true},
			-- Will of the Forsaken (Forsaken)
			{spellID = 7744, filter = "CD"},

			-- Items
			-- Back
			{slotID = 15, filter = "CD"},
			-- Belt
			{slotID = 6, filter = "CD"},
			-- Gloves
			{slotID = 10, filter = "CD"},
			-- Neck
			{slotID = 2, filter = "CD"},
			-- Rings
			{slotID = 11, filter = "CD"},
			{slotID = 12, filter = "CD"},
			-- Trinkets
			{slotID = 13, filter = "CD"},
			{slotID = 14, filter = "CD"},
		},
	},
	["ALL"] = {
		{
			Name = "SPECIAL_P_BUFF_ICON",
			Direction = "LEFT",
			Mode = "ICON",
			Interval = C.filger.buffs_space,
			Alpha = 1,
			IconSize = C.filger.buffs_size,
			Position = {"TOP", SPECIAL_P_BUFF_ICON_Anchor},

			-- Potions: Burning Crusade Classic
			-- Destruction Potion
			{spellID = 28508, unitID = "player", caster = "player", filter = "BUFF"},
			-- Haste Potion
			{spellID = 28507, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Heroic Potion
			{spellID = 28506, unitID = "player", caster = "player", filter = "BUFF"},
			-- Insane Strength Potion
			{spellID = 28494, unitID = "player", caster = "player", filter = "BUFF"},
			-- Ironshield Potion
			{spellID = 28515, unitID = "player", caster = "player", filter = "BUFF"},
			-- Major Dreamless Sleep Potion
			{spellID = 28504, unitID = "player", caster = "player", filter = "DEBUFF"},
			-- Major Arcane Protection Potion
			{spellID = 28536, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Major Fire Protection Potion
			{spellID = 28511, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Major Frost Protection Potion
			{spellID = 28512, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Major Nature Protection Potion
			{spellID = 28513, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Major Shadow Protection Potion
			{spellID = 28537, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Major Holy Protection Potion
			{spellID = 28538, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- Potions: Classic
			-- Greater Stoneshield Potion
			{spellID = 17540, unitID = "player", caster = "player", filter = "BUFF"},
			-- Mighty Rage Potion
			{spellID = 17528, unitID = "player", caster = "player", filter = "BUFF"},
			-- Magic Resistance Potion
			{spellID = 11364, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Greater Arcane Protection Potion
			{spellID = 17549, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Greater Fire Protection Potion
			{spellID = 17543, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Greater Frost Protection Potion
			{spellID = 17544, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Greater Nature Protection Potion
			{spellID = 17546, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Greater Shadow Protection Potion
			{spellID = 17548, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Greater Holy Protection Potion
			{spellID = 17545, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- Potions: Miscellaneous
			-- Swiftness Potion
			{spellID = 2379, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Lesser Invisibility Potion
			{spellID = 3680, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Invisibility Potion
			{spellID = 11392, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Free Action Potion
			{spellID = 6615, unitID = "player", caster = "player", filter = "BUFF"},
			-- Living Action Potion
			{spellID = 24364, unitID = "player", caster = "player", filter = "BUFF"},
			-- Swim Speed Potion
			{spellID = 7840, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Restorative Potion
			{spellID = 11359, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Sneaking Potion
			{spellID = 28492, unitID = "player", caster = "player", filter = "BUFF"},

			-- Runes
			-- Greater Rune of Warding
			-- {spellID = 32278, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Greater Ward of Shielding
			{spellID = 29719, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Lesser Rune of Warding
			-- {spellID = 29503, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Lesser Ward of Shielding
			{spellID = 29674, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- Miscellaneous
			-- Nightmare Seed
			{spellID = 28726, unitID = "player", caster = "player", filter = "BUFF"},
			-- Oil of Immolation
			{spellID = 11350, unitID = "player", caster = "player", filter = "BUFF", absID = true},

			-- Karazhan Tomes
			-- Legacy of the Mountain King
			-- {spellID = 30559, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Torment of the Worgen
			-- {spellID = 30564, unitID = "player", caster = "player", filter = "BUFF"},

			-- Weapon Coatings
			-- Righteous Weapon Coating
			{spellID = 45401, unitID = "player", caster = "player", filter = "BUFF"},

			-- Raid Amplifiers
			-- Bloodlust
			{spellID = 2825, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- Heroism
			{spellID = 32182, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- Drums of Battle
			{spellID = 35476, unitID = "player", caster = "all", filter = "BUFF"},
			-- Drums of War
			{spellID = 35475, unitID = "player", caster = "all", filter = "BUFF"},
			-- Greater Drums of Battle
			{spellID = 351355, unitID = "player", caster = "all", filter = "BUFF"},
			-- Greater Drums of War
			{spellID = 351360, unitID = "player", caster = "all", filter = "BUFF"},

			-- Professions
			-- Fel Blossom
			{spellID = 28527, unitID = "player", caster = "player", filter = "BUFF"},
			-- Goblin Rocket Boots
			{spellID = 8892, unitID = "player", caster = "player", filter = "BUFF"},
			-- Gnomish Rocket Boots
			{spellID = 13141, unitID = "player", caster = "player", filter = "BUFF"},
			-- Hyper-Vision Goggles
			{spellID = 30249, unitID = "player", caster = "player", filter = "BUFF"},
			-- Parachute
			{spellID = 12438, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Rocket Boots Xtreme / Rocket Boots Xtreme Lite
			{spellID = 30452, unitID = "player", caster = "player", filter = "BUFF"},

			-- Racial
			-- Berserking (Mana)
			{spellID = 20554, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Berserking (Rage)
			{spellID = 26296, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Berserking (Energy)
			{spellID = 26297, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Blood Fury (Physical)
			{spellID = 20572, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Blood Fury (Both)
			{spellID = 33697, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Blood Fury (Spell)
			{spellID = 33702, unitID = "player", caster = "player", filter = "BUFF", absID = true},
			-- Gift of the Naaru (Draenei)
			{spellID = 28880, unitID = "player", caster = "all", filter = "BUFF"},
			-- Perception (Human)
			{spellID = 20600, unitID = "player", caster = "player", filter = "BUFF"},
			-- Shadowmeld (Night Elf)
			{spellID = 20580, unitID = "player", caster = "player", filter = "BUFF"},
			-- Stoneform (Dwarf)
			{spellID = 20594, unitID = "player", caster = "player", filter = "BUFF"},
			-- Will of the Forsaken (Forsaken)
			{spellID = 7744, unitID = "player", caster = "player", filter = "BUFF"},

			-- Zone Buffs
			-- Inactive (Battlegrounds)
			{spellID = 43681, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Speed (Battlegrounds)
			{spellID = 23451, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- Alliance Battle Standard
			{spellID = 23034, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- Horde Battle Standard
			{spellID = 23035, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- Stormpike Battle Standard
			{spellID = 23539, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- Frostwolf Battle Standard
			{spellID = 23538, unitID = "player", caster = "all", filter = "BUFF", absID = true},

			-- Damage Reduction
			-- Blessing of Protection
			{spellID = 1022, unitID = "player", caster = "all", filter = "BUFF"},
			-- Blessing of Sacrifice
			{spellID = 6940, unitID = "player", caster = "all", filter = "BUFF"},
			-- Lay on Hands (Armor Bonus)
			{spellID = 20233, unitID = "player", caster = "all", filter = "BUFF"},
			-- Pain Suppression
			{spellID = 33206, unitID = "player", caster = "all", filter = "BUFF"},

			-- Other
			-- Innervate
			{spellID = 29166, unitID = "player", caster = "all", filter = "BUFF"},
			-- Symbol of Hope
			{spellID = 32548, unitID = "player", caster = "all", filter = "BUFF"},
			-- Mana Tide
			{spellID = 16191, unitID = "player", caster = "all", filter = "BUFF"},
			-- Blessing of Freedom
			{spellID = 1044, unitID = "player", caster = "all", filter = "BUFF"},
			-- Fear Ward
			{spellID = 6346, unitID = "player", caster = "all", filter = "BUFF"},
			-- Grounding Totem Effect
			{spellID = 8178, unitID = "player", caster = "all", filter = "BUFF"},
			-- Divine Intervention
			{spellID = 19752, unitID = "player", caster = "all", filter = "BUFF"},
			-- Slow Fall
			{spellID = 130, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- Levitate
			{spellID = 1706, unitID = "player", caster = "all", filter = "BUFF", absID = true},
			-- Power Infusion
			{spellID = 10060, unitID = "player", caster = "all", filter = "BUFF"},
			-- Earth Shield
			{spellID = 974, unitID = "player", caster = "all", filter = "BUFF"},
			-- Soulstone Resurrection
			-- {spellID = 20707, unitID = "player", caster = "all", filter = "BUFF"},
			-- Intervene
			{spellID = 3411, unitID = "player", caster = "all", filter = "BUFF"},
			-- Drums of Restoration
			{spellID = 35478, unitID = "player", caster = "all", filter = "BUFF"},
			-- Drums of Speed
			{spellID = 35477, unitID = "player", caster = "all", filter = "BUFF"},
			-- Greater Drums of Restoration
			{spellID = 351358, unitID = "player", caster = "all", filter = "BUFF"},
			-- Greater Drums of Speed
			{spellID = 351359, unitID = "player", caster = "all", filter = "BUFF"},

			-- Trinket Effects
			-- Fecundity (Special, Use) [Ribbon of Sacrifice]
			{spellID = 38333, unitID = "player", caster = "all", filter = "BUFF"},
			-- Persistent Shield (Absorb, Use) [Scarab Brooch]
			{spellID = 26470, unitID = "player", caster = "all", filter = "BUFF", absID = true},

			-- Raids: Burning Crusade Classic
			-- Breath: Haste [Kil'jaeden]
			{spellID = 45856, unitID = "player", caster = "all", filter = "BUFF"},
			-- Breath: Revitalize [Kil'jaeden]
			{spellID = 45860, unitID = "player", caster = "all", filter = "BUFF"},
			-- Shield of the Blue [Kil'jaeden]
			{spellID = 45848, unitID = "player", caster = "all", filter = "BUFF"},

			-- Raids: Classic
		},
		{
			Name = "PVE/PVP_DEBUFF",
			Direction = "UP",
			Mode = "ICON",
			Interval = C.filger.pvp_space,
			Alpha = 1,
			IconSize = C.filger.pvp_size,
			Position = {"TOP", PVE_PVP_DEBUFF_Anchor},

			-- Crowd Controls
			-- Druid
			-- Bash r1
			{spellID = 5211, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Bash r2
			{spellID = 6798, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Bash r3
			{spellID = 8983, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Celestial Focus (Starfire Stun)
			{spellID = 16922, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Cyclone
			{spellID = 33786, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Hibernate
			{spellID = 2637, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Maim
			{spellID = 22570, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Pounce r1
			{spellID = 9005, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Pounce r2
			{spellID = 9823, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Pounce r3
			{spellID = 9827, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Pounce r4
			{spellID = 27006, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},

			-- Hunter
			-- Charge (Boar)
			{spellID = 25999, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Freezing Trap Effect
			{spellID = 3355, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Improved Concussive Shot
			{spellID = 19410, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Intimidation
			{spellID = 24394, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Scatter Shot
			{spellID = 19503, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},

			-- Mage
			-- Dragon's Breath
			{spellID = 31661, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Impact
			{spellID = 12355, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Polymorph r1
			{spellID = 118, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Polymorph r2
			{spellID = 12824, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Polymorph r3
			{spellID = 12825, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Polymorph r4
			{spellID = 12826, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Polymorph: Pig
			{spellID = 28272, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Polymorph: Turtle
			{spellID = 28271, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},

			-- Paladin
			-- Hammer of Justice r1
			{spellID = 853, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Hammer of Justice r2
			{spellID = 5588, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Hammer of Justice r3
			{spellID = 5589, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Hammer of Justice r4
			{spellID = 10308, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Repentance
			{spellID = 20066, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Seal of Justice (Stun)
			{spellID = 20170, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Turn Undead r1
			{spellID = 2878, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Turn Undead r2
			{spellID = 5627, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Turn Evil
			{spellID = 10326, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},

			-- Priest
			-- Blackout
			{spellID = 15269, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Mind Control r1
			{spellID = 605, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Mind Control r2
			{spellID = 10911, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Mind Control r3
			{spellID = 10912, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Psychic Scream r1
			{spellID = 8122, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Psychic Scream r2
			{spellID = 8124, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Psychic Scream r3
			{spellID = 10888, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Psychic Scream r4
			{spellID = 10890, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Shackle Undead
			{spellID = 9484, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Rogue
			-- Blind
			{spellID = 2094, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Cheap Shot
			{spellID = 1833, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Gouge r1
			{spellID = 1776, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Gouge r2
			{spellID = 1777, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Gouge r3
			{spellID = 8629, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Gouge r4
			{spellID = 11285, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Gouge r5
			{spellID = 11286, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Gouge r6
			{spellID = 38764, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Kidney Shot r1
			{spellID = 408, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Kidney Shot r2
			{spellID = 8643, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Riposte
			{spellID = 14251, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Sap
			{spellID = 6770, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Shaman
			-- Stoneclaw Totem
			{spellID = 39796, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Warlock
			-- Banish r1
			{spellID = 710, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Banish r2
			{spellID = 18647, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Death Coil r1
			{spellID = 6789, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Death Coil r2
			{spellID = 17925, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Death Coil r3
			{spellID = 17926, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Death Coil r4
			{spellID = 27223, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Fear r1
			{spellID = 5782, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Fear r2
			{spellID = 6213, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Fear r3
			{spellID = 6215, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Howl of Terror
			{spellID = 5484, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Intercept Stun (Felguard)
			{spellID = 30153, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Pyroclasm
			{spellID = 18093, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Seduction (Succubus)
			{spellID = 6358, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Shadowfury
			{spellID = 30283, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},

			-- Warrior
			-- Charge Stun
			{spellID = 7922, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Concussion Blow
			{spellID = 12809, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Disarm
			{spellID = 676, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Intercept Stun r1
			{spellID = 20253, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Intercept Stun r2
			{spellID = 20614, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Intercept Stun r3
			{spellID = 20615, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Intimidating Shout (Cower)
			{spellID = 20511, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Intimidating Shout (Fear)
			{spellID = 5246, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Revenge Stun
			{spellID = 12798, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Mace Specialization
			-- Mace Stun Effect
			{spellID = 5530, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},

			-- Racial
			-- War Stomp
			{spellID = 20549, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},

			-- Silences
			-- Silencing Shot
			{spellID = 34490, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Silenced - Improved Counterspell
			{spellID = 18469, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Silence
			{spellID = 15487, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Garrote - Silence
			{spellID = 1330, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Kick - Silenced
			{spellID = 18425, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Spell Lock (Felhunter)
			{spellID = 24259, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Unstable Affliction (Silence)
			{spellID = 31117, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Shield Bash - Silenced
			{spellID = 18498, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Arcane Torrent (Mana)
			{spellID = 28730, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Arcane Torrent (Energy)
			{spellID = 25046, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Maim Interrupt (incorrect spellID)
			-- {spellID = 44835, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Deadly Interrupt Effect
			{spellID = 32747, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Roots
			-- Entangling Roots r1
			{spellID = 339, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Entangling Roots r2
			{spellID = 1062, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Entangling Roots r3
			{spellID = 5195, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Entangling Roots r4
			{spellID = 5196, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Entangling Roots r5
			{spellID = 9852, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Entangling Roots r6
			{spellID = 9853, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Entangling Roots r7
			{spellID = 26989, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Entangling Roots r1 (Nature's Grasp)
			{spellID = 19975, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Entangling Roots r2 (Nature's Grasp)
			{spellID = 19974, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Entangling Roots r3 (Nature's Grasp)
			{spellID = 19973, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Entangling Roots r4 (Nature's Grasp)
			{spellID = 19972, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Entangling Roots r5 (Nature's Grasp)
			{spellID = 19971, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Entangling Roots r6 (Nature's Grasp)
			{spellID = 19970, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Entangling Roots r7 (Nature's Grasp)
			{spellID = 27010, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Feral Charge Effect
			{spellID = 45334, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Counterattack
			{spellID = 19306, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Entrapment
			{spellID = 19185, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Improved Wing Clip
			{spellID = 19229, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Freeze (Water Elemental)
			{spellID = 33395, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Frost Nova r1
			{spellID = 122, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Frost Nova r2
			{spellID = 865, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Frost Nova r3
			{spellID = 6131, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Frost Nova r4
			{spellID = 10230, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Frost Nova r5
			{spellID = 27088, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Frostbite
			{spellID = 12494, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Chastise
			{spellID = 44041, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Improved Hamstring
			{spellID = 23694, unitID = "player", caster = "all", filter = "DEBUFF"},

			-- Slows
			-- Concussive Barrage
			{spellID = 35101, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Concussive Shot
			{spellID = 5116, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frost Trap Aura
			{spellID = 13810, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Wing Clip r1
			{spellID = 2974, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Wing Clip r2
			{spellID = 14267, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Wing Clip r3
			{spellID = 14268, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Blast Wave r1
			{spellID = 11113, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Blast Wave r2
			{spellID = 13018, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Blast Wave r3
			{spellID = 13019, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Blast Wave r4
			{spellID = 13020, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Blast Wave r5
			{spellID = 13021, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Blast Wave r6
			{spellID = 27133, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Blast Wave r7
			{spellID = 33933, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			--[[
			-- Chilled r1 (Blizzard)
			{spellID = 12484, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Chilled r2 (Blizzard)
			{spellID = 12485, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Chilled r3 (Blizzard)
			{spellID = 12486, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			--]]
			-- Chilled (Frost Armor)
			-- {spellID = 6136, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Chilled (Ice Armor)
			-- {spellID = 7321, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Cone of Cold r1
			{spellID = 120, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Cone of Cold r2
			{spellID = 8492, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Cone of Cold r3
			{spellID = 10159, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Cone of Cold r4
			{spellID = 10160, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Cone of Cold r5
			{spellID = 10161, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Cone of Cold r6
			{spellID = 27087, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Frostbolt r1
			{spellID = 116, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Frostbolt r2
			{spellID = 205, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Frostbolt r3
			{spellID = 837, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Frostbolt r4
			{spellID = 7322, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Frostbolt r5
			{spellID = 8406, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Frostbolt r6
			{spellID = 8407, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Frostbolt r7
			{spellID = 8408, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Frostbolt r8
			{spellID = 10179, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Frostbolt r9
			{spellID = 10180, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Frostbolt r10
			{spellID = 10181, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Frostbolt r11
			{spellID = 25304, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Frostbolt r12
			{spellID = 27071, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Frostbolt r13
			{spellID = 27072, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Frostbolt r14
			{spellID = 38697, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Slow
			{spellID = 31589, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Avenger's Shield
			{spellID = 31935, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Mind Flay r1
			{spellID = 15407, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Mind Flay r2
			{spellID = 17311, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Mind Flay r3
			{spellID = 17312, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Mind Flay r4
			{spellID = 17313, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Mind Flay r5
			{spellID = 17314, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Mind Flay r6
			{spellID = 18807, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Mind Flay r7
			{spellID = 25387, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Blade Twisting (Dazed)
			{spellID = 31125, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Crippling Poison r1
			{spellID = 3409, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Crippling Poison r2
			{spellID = 11201, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Deadly Throw
			{spellID = 26679, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Earthbind
			{spellID = 3600, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Frost Shock r1
			{spellID = 8056, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Frost Shock r2
			{spellID = 8058, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Frost Shock r3
			{spellID = 10472, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Frost Shock r4
			{spellID = 10473, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Frost Shock r5
			{spellID = 25464, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Frostbrand Attack
			{spellID = 8034, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Aftermath
			{spellID = 18118, unitID = "player", caster = "all", filter = "DEBUFF"},
			-- Cripple (Doomguard)
			{spellID = 20812, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Curse of Exhaustion
			{spellID = 18223, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Hamstring r1
			{spellID = 1715, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Hamstring r2
			{spellID = 7372, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Hamstring r3
			{spellID = 7373, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Hamstring r4
			{spellID = 25212, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},
			-- Piercing Howl
			{spellID = 12323, unitID = "player", caster = "all", filter = "DEBUFF", absID = true},

			-- Raids: Burning Crusade Classic

			-- Raids: Classic

		},
		--[[
		{
			Name = "T_BUFF",
			Direction = "UP",
			Mode = "ICON",
			Interval = C.filger.pvp_space,
			Alpha = 1,
			IconSize = C.filger.pvp_size,
			Position = {"TOP", T_BUFF_Anchor},

			-- Druid
			-- Barkskin
			{spellID = 22812, unitID = "target", caster = "all", filter = "BUFF"},
			-- Barkskin
			{spellID = 22812, unitID = "target", caster = "all", filter = "BUFF"},
			-- Ironbark
			{spellID = 102342, unitID = "target", caster = "all", filter = "BUFF"},
			-- Nature's Grasp
			{spellID = 170856, unitID = "target", caster = "all", filter = "BUFF"},
			-- Stampeding Roar
			{spellID = 77764, unitID = "target", caster = "all", filter = "BUFF"},
			-- Incarnation: Tree of Life
			{spellID = 117679, unitID = "target", caster = "all", filter = "BUFF"},
			-- Berserk
			{spellID = 106951, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Cyclone
			{spellID = 33786, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Mighty Bash
			{spellID = 5211, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Rake
			{spellID = 163505, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Maim
			{spellID = 22570, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Incapacitating Roar
			{spellID = 99, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Solar Beam
			{spellID = 78675, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Entangling Roots
			{spellID = 339, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Hunter
			-- Aspect of the Turtle
			{spellID = 186265, unitID = "target", caster = "all", filter = "BUFF"},
			-- Feign Death
			{spellID = 5384, unitID = "target", caster = "all", filter = "BUFF"},
			-- Posthaste
			{spellID = 118922, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Freezing Trap
			{spellID = 3355, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Wyvern Sting
			{spellID = 19386, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Binding Shot
			{spellID = 117526, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Intimidation
			{spellID = 24394, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Mage
			-- Ice Block
			{spellID = 45438, unitID = "target", caster = "all", filter = "BUFF"},
			-- Invisibility
			{spellID = 66, unitID = "target", caster = "all", filter = "BUFF"},
			-- Greater Invisibility
			{spellID = 113862, unitID = "target", caster = "all", filter = "BUFF"},
			-- Temporal Shield
			{spellID = 198111, unitID = "target", caster = "all", filter = "BUFF"},
			-- Evanesce
			{spellID = 157913, unitID = "target", caster = "all", filter = "BUFF"},
			-- Evocation
			{spellID = 12051, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Cauterize
			{spellID = 87023, unitID = "target", caster = "target", filter = "DEBUFF"},
			-- Polymorph
			{spellID = 118, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Ring of Frost
			{spellID = 82691, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Dragon's Breath
			{spellID = 31661, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Paladin
			-- Divine Shield
			{spellID = 642, unitID = "target", caster = "all", filter = "BUFF"},
			-- Guardian of Ancient Kings
			{spellID = 86659, unitID = "target", caster = "all", filter = "BUFF"},
			-- Blessing of Protection
			{spellID = 1022, unitID = "target", caster = "all", filter = "BUFF"},
			-- Divine Protection
			{spellID = 498, unitID = "target", caster = "all", filter = "BUFF"},
			-- Ardent Defender
			{spellID = 31850, unitID = "target", caster = "all", filter = "BUFF"},
			-- Aura Mastery
			{spellID = 31821, unitID = "target", caster = "all", filter = "BUFF"},
			-- Blessing of Spellwarding
			{spellID = 204018, unitID = "target", caster = "all", filter = "BUFF"},
			-- Blessing of Sacrifice
			{spellID = 6940, unitID = "target", caster = "all", filter = "BUFF"},
			-- Blessing of Freedom
			{spellID = 1044, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Repentance
			{spellID = 20066, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Hammer of Justice
			{spellID = 853, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Blinding Light
			{spellID = 105421, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Avenger's Shield
			{spellID = 31935, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Priest
			-- Dispersion
			{spellID = 47585, unitID = "target", caster = "all", filter = "BUFF"},
			-- Pain Suppression
			{spellID = 33206, unitID = "target", caster = "all", filter = "BUFF"},
			-- Guardian Spirit
			{spellID = 47788, unitID = "target", caster = "all", filter = "BUFF"},
			-- Spectral Guise
			{spellID = 119030, unitID = "target", caster = "all", filter = "BUFF"},
			-- Phantasm
			{spellID = 114239, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Dominate Mind
			{spellID = 605, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Psychic Horror
			{spellID = 64044, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Psychic Scream
			{spellID = 8122, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Silence
			{spellID = 15487, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Rogue
			-- Cloak of Shadows
			{spellID = 31224, unitID = "target", caster = "all", filter = "BUFF"},
			-- Cheating Death
			{spellID = 45182, unitID = "target", caster = "all", filter = "BUFF"},
			-- Evasion
			{spellID = 5277, unitID = "target", caster = "all", filter = "BUFF"},
			-- Combat Insight
			{spellID = 74002, unitID = "target", caster = "all", filter = "BUFF"},
			-- Shadow Dance
			{spellID = 185313, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Sap
			{spellID = 6770, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Blind
			{spellID = 2094, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Cheap Shot
			{spellID = 1833, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Kidney Shot
			{spellID = 408, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Between the Eyes
			{spellID = 199804, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Garrote
			{spellID = 1330, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Smoke Bomb
			{spellID = 76577, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Shaman
			-- Grounding Totem Effect
			{spellID = 8178, unitID = "target", caster = "all", filter = "BUFF"},
			-- Spiritwalker's Grace
			{spellID = 79206, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Hex
			{spellID = 51514, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Static Charge
			{spellID = 118905, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Pulverize (Earth Elemental)
			{spellID = 118345, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Warlock
			-- Soulstone
			{spellID = 20707, unitID = "target", caster = "all", filter = "BUFF"},
			-- Unending Resolve
			{spellID = 104773, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Banish
			{spellID = 710, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Axe Toss (Felguard)
			{spellID = 89766, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Fear
			{spellID = 118699, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Seduction (Succubus)
			{spellID = 6358, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Mesmerize (Shivarra)
			{spellID = 115268, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Howl of Terror
			{spellID = 5484, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Mortal Coil
			{spellID = 6789, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Shadowfury
			{spellID = 30283, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Meteor Strike (Abyssal)
			{spellID = 171156, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Debilitate (Terrorguard)
			{spellID = 170996, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Unstable Affliction
			{spellID = 31117, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},

			-- Warrior
			-- Bladestorm
			{spellID = 46924, unitID = "target", caster = "all", filter = "BUFF"},
			-- Spell Reflection
			{spellID = 23920, unitID = "target", caster = "all", filter = "BUFF"},
			-- Mass Spell Reflection
			{spellID = 114028, unitID = "target", caster = "all", filter = "BUFF"},
			-- Shield Wall
			{spellID = 871, unitID = "target", caster = "all", filter = "BUFF"},
			-- Die by the Sword
			{spellID = 118038, unitID = "target", caster = "all", filter = "BUFF"},
			-- Last Stand
			{spellID = 12975, unitID = "target", caster = "all", filter = "BUFF"},
			-- Berserker Rage
			{spellID = 18499, unitID = "target", caster = "all", filter = "BUFF"},
			-- Debuffs
			-- Intimidating Shout
			{spellID = 5246, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Storm Bolt
			{spellID = 132169, unitID = "target", caster = "all", filter = "DEBUFF", absID = true},
			-- Shockwave
			{spellID = 132168, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Racial
			-- Arcane Torrent
			{spellID = 28730, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Quaking Palm
			{spellID = 107079, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- War Stomp
			{spellID = 20549, unitID = "target", caster = "all", filter = "DEBUFF"},

			-- Professions
			-- Shieldtronic Shield
			{spellID = 173260, unitID = "target", caster = "all", filter = "BUFF"},

			-- Player vs. Player
			-- Ashran
			-- Ancient Artifact
			{spellID = 168506, unitID = "target", caster = "all", filter = "BUFF"},
			-- Boulder Shield
			{spellID = 169373, unitID = "target", caster = "all", filter = "BUFF"},
			-- Scroll of Protection
			{spellID = 171249, unitID = "target", caster = "all", filter = "BUFF"},
			-- Star Root Tuber
			{spellID = 161495, unitID = "target", caster = "all", filter = "BUFF"},
			-- Battlegrounds
			-- Netherstorm Flag
			{spellID = 34976, unitID = "target", caster = "all", filter = "BUFF"},
			-- Orb of Power
			{spellID = 121175, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Warsong Flag
			{spellID = 23333, unitID = "target", caster = "all", filter = "BUFF"},
			{spellID = 23335, unitID = "target", caster = "all", filter = "BUFF"},
			-- Seaforium Bombs
			{spellID = 66271, unitID = "target", caster = "all", filter = "DEBUFF"},
			-- Drinking in Arena
			-- Ba'ruun's Bountiful Bloom
			{spellID = 167268, unitID = "target", caster = "all", filter = "BUFF"},
			-- Drinking
			{spellID = 80167, unitID = "target", caster = "all", filter = "BUFF"},
			-- Mage Food
			{spellID = 167152, unitID = "target", caster = "all", filter = "BUFF"},
		},
		--]]
	},
}

T.CustomFilgerSpell = T.CustomFilgerSpell or {}
T.FilgerIgnoreSpell = T.FilgerIgnoreSpell or {}