local T, C, L = unpack(ViksUI)
if C.unitframe.enable ~= true or C.unitframe.show_arena ~= true or C.unitframe.plugins_diminishing ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Sap -> http://www.wowhead.com/spell=6770
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
T.DiminishingSpells = {
	-- Stuns
	[5211] = {"stun"},				-- Bash r1
	[6798] = {"stun"},				-- Bash r2
	[8983] = {"stun"},				-- Bash r3
	[9005] = {"stun"},				-- Pounce r1
	[9823] = {"stun"},				-- Pounce r2
	[9827] = {"stun"},				-- Pounce r3
	[27006] = {"stun"},				-- Pounce r4
	[24394] = {"stun"},				-- Intimidation
	[853] = {"stun"},				-- Hammer of Justice r1
	[5588] = {"stun"},				-- Hammer of Justice r2
	[5589] = {"stun"},				-- Hammer of Justice r3
	[10308] = {"stun"},				-- Hammer of Justice r4
	[1833] = {"stun"},				-- Cheap Shot
	[22703] = {"stun"},				-- Inferno Effect
	[30153] = {"stun"},				-- Intercept Stun (Felguard)
	[30283] = {"stun"},				-- Shadowfury r1
	[30413] = {"stun"},				-- Shadowfury r2
	[30414] = {"stun"},				-- Shadowfury r3
	[7922] = {"stun"},				-- Charge Stun
	[12809] = {"stun"},				-- Concussion Blow
	[20253] = {"stun"},				-- Intercept Stun r1
	[20614] = {"stun"},				-- Intercept Stun r2
	[20615] = {"stun"},				-- Intercept Stun r3
	[25273] = {"stun"},				-- Intercept Stun r4
	[25274] = {"stun"},				-- Intercept Stun r5
	[20549] = {"stun"},				-- War Stomp (Racial)
	[835] = {"stun"},				-- Tidal Charm
	[4064] = {"stun"},				-- Rough Copper Bomb
	[4065] = {"stun"},				-- Large Copper Bomb
	[4066] = {"stun"},				-- Small Bronze Bomb
	[4067] = {"stun"},				-- Big Bronze Bomb
	[4068] = {"stun"},				-- Iron Grenade
	[4069] = {"stun"},				-- Big Iron Bomb
	[12421] = {"stun"},				-- Mithril Frag Bomb
	[12543] = {"stun"},				-- Hi-Explosive Bomb
	[12562] = {"stun"},				-- The Big One
	[13237] = {"stun"},				-- Goblin Mortar
	[13808] = {"stun"},				-- M73 Frag Grenade
	[19769] = {"stun"},				-- Thorium Grenade
	[19784] = {"stun"},				-- Dark Iron Bomb
	[30216] = {"stun"},				-- Fel Iron Bomb
	[30461] = {"stun"},				-- The Bigger One
	[30217] = {"stun"},				-- Adamantite Grenade

	--[[
	-- Stun Procs
	[16922] = {"stunproc"},			-- Celestial Focus
	[19410] = {"stunproc"},			-- Improved Concussive Shot
	[12355] = {"stunproc"},			-- Impact
	[15269] = {"stunproc"},			-- Blackout
	[20170] = {"stunproc"},			-- Seal of Justice
	[39796] = {"stunproc"},			-- Stoneclaw Totem
	-- [18093] = {"stunproc"},			-- Pyroclasm
	[12798] = {"stunproc"},			-- Revenge Stun
	[5530] = {"stunproc"},			-- Mace Specialization
	[56] = {"stunproc"},			-- Stun (The Chief's Enforcer / Bludgeon of the Grinning Dog / The Judge's Gavel / Hammer of the Titans)
	[15283] = {"stunproc"},			-- Stunning Blow (Dark Iron Pulverizer)
	[21152] = {"stunproc"},			-- Earthshaker (Earthshaker)
	--]]

	-- Disorients
	[22570] = {"disorient"},		-- Maim
	[118] = {"disorient"},			-- Polymorph r1
	[12824] = {"disorient"},		-- Polymorph r2
	[12825] = {"disorient"},		-- Polymorph r3
	[12826] = {"disorient"},		-- Polymorph r4
	[28272] = {"disorient"},		-- Polymorph: Pig
	[28271] = {"disorient"},		-- Polymorph: Turtle
	[1776] = {"disorient"},			-- Gouge r1
	[1777] = {"disorient"},			-- Gouge r2
	[8629] = {"disorient"},			-- Gouge r3
	[11285] = {"disorient"},		-- Gouge r4
	[11286] = {"disorient"},		-- Gouge r5
	[38764] = {"disorient"},		-- Gouge r6
	[6770] = {"disorient"},			-- Sap r1
	[2070] = {"disorient"},			-- Sap r2
	[11297] = {"disorient"},		-- Sap r3
	[13327] = {"disorient"},		-- Reckless Charge (Horned Viking Helmet / Goblin Rocket Helmet)
	[26108] = {"disorient"},		-- Glimpse of Madness (Dark Edge of Insanity)

	-- Sleeps
	[2637] = {"sleep"},				-- Hibernate r1
	[18657] = {"sleep"},			-- Hibernate r2
	[18658] = {"sleep"},			-- Hibernate r3
	[19386] = {"sleep"},			-- Wyvern Sting r1
	[24132] = {"sleep"},			-- Wyvern Sting r2
	[24133] = {"sleep"},			-- Wyvern Sting r3
	[27068] = {"sleep"},			-- Wyvern Sting r4

	-- Charms
	[605] = {"charm"},				-- Mind Control r1
	[10911] = {"charm"},			-- Mind Control r2
	[10912] = {"charm"},			-- Mind Control r3
	[13180] = {"charm"},			-- Gnomish Mind Control Cap

	-- Fears
	[1513] = {"fear"},				-- Scare Beast r1
	[14326] = {"fear"},				-- Scare Beast r2
	[14327] = {"fear"},				-- Scare Beast r3
	[8122] = {"fear"},				-- Psychic Scream r1
	[8124] = {"fear"},				-- Psychic Scream r2
	[10888] = {"fear"},				-- Psychic Scream r3
	[10890] = {"fear"},				-- Psychic Scream r4
	[5782] = {"fear"},				-- Fear r1
	[6213] = {"fear"},				-- Fear r2
	[6215] = {"fear"},				-- Fear r3
	[5484] = {"fear"},				-- Howl of Terror r1
	[17928] = {"fear"},				-- Howl of Terror r2
	[6358] = {"fear"},				-- Seduction (Succubus)
	[5246] = {"fear"},				-- Intimidating Shout
	[5134] = {"fear"},				-- Flash Bomb (Flash Bomb)

	-- Horrors
	[6789] = {"horror"},			-- Death Coil r1
	[17925] = {"horror"},			-- Death Coil r2
	[17926] = {"horror"},			-- Death Coil r3
	[27223] = {"horror"},			-- Death Coil r4

	-- Unstable Affliction
	[43523] = {"ua"},				-- Unstable Affliction (Silence)
	[31117] = {"ua"},				-- Unstable Affliction (Silence)

	-- Roots
	-- [45334] = {"root"},				-- Feral Charge Effect
	[339] = {"root"},				-- Entangling Roots r1
	[1062] = {"root"},				-- Entangling Roots r2
	[5195] = {"root"},				-- Entangling Roots r3
	[5196] = {"root"},				-- Entangling Roots r4
	[9852] = {"root"},				-- Entangling Roots r5
	[9853] = {"root"},				-- Entangling Roots r6
	[26989] = {"root"},				-- Entangling Roots r7
	[19975] = {"root"},				-- Entangling Roots r1 (Nature's Grasp)
	[19974] = {"root"},				-- Entangling Roots r2 (Nature's Grasp)
	[19973] = {"root"},				-- Entangling Roots r3 (Nature's Grasp)
	[19972] = {"root"},				-- Entangling Roots r4 (Nature's Grasp)
	[19971] = {"root"},				-- Entangling Roots r5 (Nature's Grasp)
	[19970] = {"root"},				-- Entangling Roots r6 (Nature's Grasp)
	[27010] = {"root"},				-- Entangling Roots r7 (Nature's Grasp)
	[19306] = {"root"},				-- Counterattack r1
	[19306] = {"root"},				-- Counterattack r2
	[20909] = {"root"},				-- Counterattack r3
	[20910] = {"root"},				-- Counterattack r4
	[19185] = {"root"},				-- Entrapment
	-- [19229] = {"root"},				-- Improved Wing Clip
	[33395] = {"root"},				-- Freeze (Water Elemental)
	[122] = {"root"},				-- Frost Nova r1
	[865] = {"root"},				-- Frost Nova r2
	[6131] = {"root"},				-- Frost Nova r3
	[10230] = {"root"},				-- Frost Nova r4
	[27088] = {"root"},				-- Frost Nova r5
	-- [12494] = {"root"},				-- Frostbite
	[44041] = {"root"},				-- Chastise r1
	[44043] = {"root"},				-- Chastise r2
	[44044] = {"root"},				-- Chastise r3
	[44045] = {"root"},				-- Chastise r4
	[44046] = {"root"},				-- Chastise r5
	[44047] = {"root"},				-- Chastise r6
	-- [23694] = {"root"},				-- Improved Hamstring
	-- [27868] = {"root"},				-- Freeze (Magister's Regalia / Sorcerer's Regalia / Deadman's Hand)
	[39965] = {"root"},				-- Frost Grenade

	--[[
	-- Disarms
	[14251] = {"disarm"},			-- Riposte
	[676] = {"disarm"},				-- Disarm
	--]]

	--[[
	-- Silences
	[34490] = {"silence"},			-- Silencing Shot
	[18469] = {"silence"},			-- Silenced - Improved Counterspell
	[15487] = {"silence"},			-- Silence
	[1330] = {"silence"},			-- Garrote - Silence
	[18425] = {"silence"},			-- Kick - Silenced
	[24259] = {"silence"},			-- Spell Lock (Felhunter)
	[18498] = {"silence"},			-- Shield Bash - Silenced
	[28730] = {"silence"},			-- Arcane Torrent (Mana)
	[25046] = {"silence"},			-- Arcane Torrent (Energy)
	-- [44835] = {"silence"},			-- Maim Interrupt (incorrect spellID)
	[32747] = {"silence"},			-- Deadly Interrupt Effect
	--]]

	-- Cyclone / Blind
	[33786] = {"cycloneblind"},		-- Cyclone
	[2094] = {"cycloneblind"},		-- Blind

	-- Freezing Trap
	[3355] = {"freezingtrap"},		-- Freezing Trap r1
	[14308] = {"freezingtrap"},		-- Freezing Trap r2
	[14309] = {"freezingtrap"},		-- Freezing Trap r3

	-- Scatter Shot
	[19503] = {"scattershot"},		-- Scatter Shot

	-- Dragon's Breath
	[31661] = {"dragonsbreath"},	-- Dragon's Breath r1
	[33041] = {"dragonsbreath"},	-- Dragon's Breath r2
	[33042] = {"dragonsbreath"},	-- Dragon's Breath r3
	[33043] = {"dragonsbreath"},	-- Dragon's Breath r4

	-- Repentance
	[20066] = {"repentance"},		-- Repentance

	--[[
	-- Turn Evil / Turn Undead
	[10326] = {"turned"},			-- Turn Evil
	[2878] = {"turned"},			-- Turn Undead r1
	[5627] = {"turned"},			-- Turn Undead r2
	--]]

	--[[
	-- Shackle Undead
	[9484] = {"shackle"},			-- Shackle Undead r1
	[9485] = {"shackle"},			-- Shackle Undead r2
	[10955] = {"shackle"},			-- Shackle Undead r3
	--]]

	-- Kidney Shot
	[408] = {"kidneyshot"},			-- Kidney Shot r1
	[8643] = {"kidneyshot"},		-- Kidney Shot r2

	-- Frost Shock
	[8056] = {"frostshock"},		-- Frost Shock r1
	[8058] = {"frostshock"},		-- Frost Shock r2
	[10472] = {"frostshock"},		-- Frost Shock r3
	[10473] = {"frostshock"},		-- Frost Shock r4
	[25464] = {"frostshock"},		-- Frost Shock r5
}

local function GetIcon(id)
	local _, _, icon = GetSpellInfo(id)
	return icon
end

T.DiminishingIcons = {
	["stun"] = GetIcon(853),
	-- ["stunproc"] = GetIcon(5530),
	["disorient"] = GetIcon(118),
	["sleep"] = GetIcon(19386),
	["charm"] = GetIcon(605),
	["fear"] = GetIcon(8122),
	["horror"] = GetIcon(5782),
	["ua"] = GetIcon(43523),
	["root"] = GetIcon(339),
	-- ["disarm"] = GetIcon(676),
	-- ["silence"] = GetIcon(15487),
	["cycloneblind"] = GetIcon(33786),
	["freezingtrap"] = GetIcon(3355),
	["scattershot"] = GetIcon(19503),
	["dragonsbreath"] = GetIcon(31661),
	["repentance"] = GetIcon(20066),
	-- ["turned"] = GetIcon(10326),
	-- ["shackle"] = GetIcon(9484),
	["kidneyshot"] = GetIcon(408),
	["frostshock"] = GetIcon(8056),
}
