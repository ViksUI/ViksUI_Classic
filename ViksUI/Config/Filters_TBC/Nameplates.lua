local T, C, L = unpack(ViksUI)
if C.nameplate.enable ~= true then return end

----------------------------------------------------------------------------------------
--	The best way to add or delete spell is to go at www.wowhead.com, search for a spell.
--	Example: Polymorph -> http://www.wowhead.com/spell=118
--	Take the number ID at the end of the URL, and add it to the list
----------------------------------------------------------------------------------------
local function SpellName(id)
	local name = GetSpellInfo(id)
	if name then
		return name
	else
		print("|cffff0000ViksUI: spell ID ["..tostring(id).."] no longer exists!|r")
		return "Empty"
	end
end

T.DebuffWhiteList = {
	-- Druid
	[SpellName(5211)] = true,	-- Bash
	[SpellName(16922)] = true,	-- Celestial Focus (Starfire Stun)
	[SpellName(5209)] = true,	-- Challenging Roar
	[SpellName(33786)] = true,	-- Cyclone
	[SpellName(99)] = true,		-- Demoralizing Roar
	[SpellName(339)] = true,	-- Entangling Roots
	-- [SpellName(19975)] = true,	-- Entangling Roots (Nature's Grasp)
	[SpellName(770)] = true,	-- Faerie Fire
	[SpellName(16857)] = true,	-- Faerie Fire (Feral)
	[SpellName(45334)] = true,	-- Feral Charge Effect
	[SpellName(2637)] = true,	-- Hibernate
	-- [SpellName(16914)] = true,	-- Hurricane
	[SpellName(5570)] = true,	-- Insect Swarm
	[SpellName(33745)] = true,	-- Lacerate
	[SpellName(22570)] = true,	-- Maim
	[SpellName(33878)] = true,	-- Mangle (Bear)
	[SpellName(33876)] = true,	-- Mangle (Cat)
	[SpellName(8921)] = true,	-- Moonfire
	[SpellName(9005)] = true,	-- Pounce
	[SpellName(9007)] = true,	-- Pounce Bleed
	[SpellName(1822)] = true,	-- Rake
	[SpellName(1079)] = true,	-- Rip
	[SpellName(2908)] = true,	-- Soothe Animal

	-- Hunter
	[SpellName(19434)] = true,	-- Aimed Shot
	-- [SpellName(1462)] = true,	-- Beast Lore
	[SpellName(3674)] = true,	-- Black Arrow
	[SpellName(25999)] = true,	-- Charge (Boar)
	[SpellName(35101)] = true,	-- Concussive Barrage
	[SpellName(5116)] = true,	-- Concussive Shot
	[SpellName(19306)] = true,	-- Counterattack
	[SpellName(19185)] = true,	-- Entrapment
	[SpellName(13812)] = true,	-- Explosive Trap Effect
	[SpellName(34501)] = true,	-- Expose Weakness
	[SpellName(34889)] = true,	-- Fire Breath (Dragonhawk)
	[SpellName(1543)] = true,	-- Flare
	[SpellName(3355)] = true,	-- Freezing Trap Effect
	[SpellName(13810)] = true,	-- Frost Trap Aura
	[SpellName(1130)] = true,	-- Hunter's Mark
	[SpellName(13797)] = true,	-- Immolation Trap Effect
	[SpellName(19410)] = true,	-- Improved Concussive Shot
	[SpellName(19229)] = true,	-- Improved Wing Clip
	[SpellName(24394)] = true,	-- Intimidation
	[SpellName(35387)] = true,	-- Poison Spit (Serpent)
	[SpellName(1513)] = true,	-- Scare Beast
	[SpellName(19503)] = true,	-- Scatter Shot
	[SpellName(24640)] = true,	-- Scorpid Poison (Scorpid)
	[SpellName(3043)] = true,	-- Scorpid Sting
	[SpellName(24423)] = true,	-- Screech (Bat / Bird of Prey / Carrion Bird)
	[SpellName(1978)] = true,	-- Serpent Sting
	[SpellName(34490)] = true,	-- Silencing Shot
	[SpellName(3034)] = true,	-- Viper Sting
	[SpellName(2974)] = true,	-- Wing Clip
	[SpellName(19386)] = true,	-- Wyvern Sting

	-- Mage
	[SpellName(11113)] = true,	-- Blast Wave
	-- [SpellName(10)] = true,	-- Blizzard
	-- [SpellName(12484)] = true,	-- Chilled (Blizzard)
	[SpellName(6136)] = true,	-- Chilled (Frost Armor)
	-- [SpellName(7321)] = true,	-- Chilled (Ice Armor)
	[SpellName(120)] = true,	-- Cone of Cold
	[SpellName(31661)] = true,	-- Dragon's Breath
	[SpellName(133)] = true,	-- Fireball
	[SpellName(22959)] = true,	-- Fire Vulnerability (Improved Scorch)
	[SpellName(2120)] = true,	-- Flamestrike
	[SpellName(122)] = true,	-- Frost Nova
	[SpellName(12494)] = true,	-- Frostbite
	[SpellName(116)] = true,	-- Frostbolt
	[SpellName(12654)] = true,	-- Ignite
	[SpellName(12355)] = true,	-- Impact
	[SpellName(118)] = true,	-- Polymorph
	[SpellName(11366)] = true,	-- Pyroblast
	[SpellName(18469)] = true,	-- Silenced - Improved Counterspell
	[SpellName(31589)] = true,	-- Slow
	[SpellName(12579)] = true,	-- Winter's Chill

	-- Paladin
	[SpellName(31935)] = true,	-- Avenger's Shield
	[SpellName(356110)] = true,	-- Blood Corruption
	[SpellName(26573)] = true,	-- Consecration
	[SpellName(853)] = true,	-- Hammer of Justice
	[SpellName(31803)] = true,	-- Holy Vengeance
	[SpellName(20184)] = true,	-- Judgement of Justice
	[SpellName(20185)] = true,	-- Judgement of Light
	[SpellName(20186)] = true,	-- Judgement of Wisdom
	[SpellName(21183)] = true,	-- Judgement of the Crusader
	[SpellName(20066)] = true,	-- Repentance
	[SpellName(20170)] = true,	-- Seal of Justice (Stun)
	[SpellName(10326)] = true,	-- Turn Evil
	[SpellName(2878)] = true,	-- Turn Undead
	[SpellName(67)] = true,		-- Vindication

	-- Priest
	[SpellName(15269)] = true,	-- Blackout
	[SpellName(44041)] = true,	-- Chastise
	[SpellName(2944)] = true,	-- Devouring Plague
	[SpellName(9035)] = true,	-- Hex of Weakness
	[SpellName(14914)] = true,	-- Holy Fire
	[SpellName(605)] = true,	-- Mind Control
	[SpellName(15407)] = true,	-- Mind Flay
	[SpellName(453)] = true,	-- Mind Soothe
	[SpellName(2096)] = true,	-- Mind Vision
	[SpellName(33196)] = true,	-- Misery
	[SpellName(8122)] = true,	-- Psychic Scream
	[SpellName(9484)] = true,	-- Shackle Undead
	[SpellName(15258)] = true,	-- Shadow Vulnerability (Shadow Weaving)
	[SpellName(589)] = true,	-- Shadow Word: Pain
	[SpellName(15487)] = true,	-- Silence
	[SpellName(10797)] = true,	-- Starshards
	[SpellName(2943)] = true,	-- Touch of Weakness
	[SpellName(15286)] = true,	-- Vampiric Embrace
	[SpellName(34914)] = true,	-- Vampiric Touch

	-- Rogue
	[SpellName(31125)] = true,	-- Blade Twisting (Dazed)
	[SpellName(2094)] = true,	-- Blind
	[SpellName(1833)] = true,	-- Cheap Shot
	[SpellName(3409)] = true,	-- Crippling Poison
	[SpellName(2818)] = true,	-- Deadly Poison
	[SpellName(26679)] = true,	-- Deadly Throw
	[SpellName(32747)] = true,	-- Deadly Interrupt Effect
	[SpellName(8647)] = true,	-- Expose Armor
	[SpellName(703)] = true,	-- Garrote
	[SpellName(1330)] = true,	-- Garrote - Silence
	[SpellName(1776)] = true,	-- Gouge
	[SpellName(16511)] = true,	-- Hemorrhage
	[SpellName(18425)] = true,	-- Kick - Silenced
	[SpellName(408)] = true,	-- Kidney Shot
	[SpellName(5760)] = true,	-- Mind-numbing Poison
	[SpellName(14251)] = true,	-- Riposte
	[SpellName(1943)] = true,	-- Rupture
	[SpellName(6770)] = true,	-- Sap
	[SpellName(13218)] = true,	-- Wound Poison

	-- Shaman
	[SpellName(3600)] = true,	-- Earthbind
	[SpellName(8050)] = true,	-- Flame Shock
	[SpellName(8056)] = true,	-- Frost Shock
	[SpellName(8034)] = true,	-- Frostbrand Attack
	[SpellName(39796)] = true,	-- Stoneclaw Totem
	[SpellName(17364)] = true,	-- Stormstrike

	-- Warlock
	[SpellName(18118)] = true,	-- Aftermath
	[SpellName(710)] = true,	-- Banish
	[SpellName(172)] = true,	-- Corruption
	[SpellName(20812)] = true,	-- Cripple (Doomguard)
	[SpellName(980)] = true,	-- Curse of Agony
	[SpellName(603)] = true,	-- Curse of Doom
	[SpellName(18223)] = true,	-- Curse of Exhaustion
	[SpellName(1010)] = true,	-- Curse of Idiocy
	[SpellName(704)] = true,	-- Curse of Recklessness
	[SpellName(1714)] = true,	-- Curse of Tongues
	[SpellName(702)] = true,	-- Curse of Weakness
	[SpellName(1490)] = true,	-- Curse of the Elements
	[SpellName(6789)] = true,	-- Death Coil
	[SpellName(689)] = true,	-- Drain Life
	[SpellName(5138)] = true,	-- Drain Mana
	[SpellName(1120)] = true,	-- Drain Soul
	[SpellName(1098)] = true,	-- Enslave Demon
	[SpellName(5782)] = true,	-- Fear
	[SpellName(5484)] = true,	-- Howl of Terror
	[SpellName(348)] = true,	-- Immolate
	[SpellName(30153)] = true,	-- Intercept Stun (Felguard)
	[SpellName(18093)] = true,	-- Pyroclasm
	-- [SpellName(5740)] = true,	-- Rain of Fire
	[SpellName(27243)] = true,	-- Seed of Corruption
	[SpellName(6358)] = true,	-- Seduction (Succubus)
	-- [SpellName(29341)] = true,	-- Shadowburn
	[SpellName(30283)] = true,	-- Shadowfury
	[SpellName(32386)] = true,	-- Shadow Embrace
	[SpellName(17794)] = true,	-- Shadow Vulnerability (Improved Shadow Bolt)
	[SpellName(18265)] = true,	-- Siphon Life
	[SpellName(24259)] = true,	-- Spell Lock (Felhunter)
	[SpellName(21949)] = true,	-- Rend (Doomguard)
	[SpellName(19479)] = true,	-- Tainted Blood Effect (Felhunter)
	[SpellName(30108)] = true,	-- Unstable Affliction
	-- [SpellName(31117)] = true,	-- Unstable Affliction (Silence)

	-- Warrior
	[SpellName(30069)] = true,	-- Blood Frenzy
	[SpellName(1161)] = true,	-- Challenging Shout
	[SpellName(7922)] = true,	-- Charge Stun
	[SpellName(12809)] = true,	-- Concussion Blow
	[SpellName(1160)] = true,	-- Demoralizing Shout
	[SpellName(676)] = true,	-- Disarm
	[SpellName(1715)] = true,	-- Hamstring
	[SpellName(23694)] = true,	-- Improved Hamstring
	[SpellName(20253)] = true,	-- Intercept Stun
	[SpellName(20511)] = true,	-- Intimidating Shout (Cower)
	[SpellName(5246)] = true,	-- Intimidating Shout (Fear)
	[SpellName(694)] = true,	-- Mocking Blow
	[SpellName(12294)] = true,	-- Mortal Strike
	[SpellName(12323)] = true,	-- Piercing Howl
	[SpellName(772)] = true,	-- Rend
	[SpellName(12798)] = true,	-- Revenge Stun
	[SpellName(18498)] = true,	-- Shield Bash - Silenced
	[SpellName(7386)] = true,	-- Sunder Armor
	[SpellName(6343)] = true,	-- Thunder Clap

	-- Mace Specialization
	[SpellName(5530)] = true,	-- Mace Stun Effect (Rogue / Warrior)

	-- Racial
	[SpellName(25046)] = true,	-- Arcane Torrent
	[SpellName(20549)] = true,	-- War Stomp
}

for _, spell in pairs(C.nameplate.debuffs_list) do
	T.DebuffWhiteList[SpellName(spell)] = true
end

T.DebuffBlackList = {
	-- [SpellName(spellID)] = true,	-- Spell Name
}

T.BuffWhiteList = {
	-- Druid
	[SpellName(2893)] = true,	-- Abolish Poison
	[SpellName(22812)] = true,	-- Barkskin
	[SpellName(1850)] = true,	-- Dash
	[SpellName(5229)] = true,	-- Enrage
	[SpellName(22842)] = true,	-- Frenzied Regeneration
	[SpellName(29166)] = true,	-- Innervate
	-- [SpellName(24932)] = true,	-- Leader of the Pack
	[SpellName(33763)] = true,	-- Lifebloom
	-- [SpellName(45281)] = true,	-- Natural Perfection
	-- [SpellName(16886)] = true,	-- Nature's Grace
	[SpellName(16689)] = true,	-- Nature's Grasp
	[SpellName(17116)] = true,	-- Nature's Swiftness
	-- [SpellName(16870)] = true,	-- Omen of Clarity (Clearcasting)
	-- [SpellName(5215)] = true,	-- Prowl
	[SpellName(8936)] = true,	-- Regrowth
	[SpellName(774)] = true,	-- Rejuvenation
	-- [SpellName(34123)] = true,	-- Tree of Life
	[SpellName(5217)] = true,	-- Tiger's Fury
	-- [SpellName(5225)] = true,	-- Track Humanoids
	[SpellName(740)] = true,	-- Tranquility

	-- Hunter
	-- [SpellName(13161)] = true,	-- Aspect of the Beast
	[SpellName(5118)] = true,	-- Aspect of the Cheetah
	-- [SpellName(13165)] = true,	-- Aspect of the Hawk
	-- [SpellName(13163)] = true,	-- Aspect of the Monkey
	[SpellName(13159)] = true,	-- Aspect of the Pack
	[SpellName(34074)] = true,	-- Aspect of the Viper
	-- [SpellName(20043)] = true,	-- Aspect of the Wild
	[SpellName(19574)] = true,	-- Bestial Wrath
	[SpellName(25077)] = true,	-- Cobra Reflexes (Pet)
	[SpellName(23099)] = true,	-- Dash (Pet)
	[SpellName(19263)] = true,	-- Deterrence
	[SpellName(23145)] = true,	-- Dive (Pet)
	[SpellName(6197)] = true,	-- Eagle Eye
	[SpellName(1002)] = true,	-- Eyes of the Beast
	-- [SpellName(1539)] = true,	-- Feed Pet Effect
	[SpellName(5384)] = true,	-- Feign Death
	-- [SpellName(34456)] = true,	-- Ferocious Inspiration
	[SpellName(19615)] = true,	-- Frenzy Effect
	[SpellName(24604)] = true,	-- Furious Howl (Wolf)
	[SpellName(34833)] = true,	-- Master Tactician
	[SpellName(136)] = true,	-- Mend Pet
	-- [SpellName(24450)] = true,	-- Prowl (Cat)
	[SpellName(6150)] = true,	-- Quick Shots
	[SpellName(3045)] = true,	-- Rapid Fire
	[SpellName(35098)] = true,	-- Rapid Killing
	[SpellName(26064)] = true,	-- Shell Shield (Turtle)
	-- [SpellName(19579)] = true,	-- Spirit Bond
	-- [SpellName(1515)] = true,	-- Tame Beast
	[SpellName(34471)] = true,	-- The Beast Within
	-- [SpellName(1494)] = true,	-- Track Beasts
	-- [SpellName(19878)] = true,	-- Track Demons
	-- [SpellName(19879)] = true,	-- Track Dragonkin
	-- [SpellName(19880)] = true,	-- Track Elementals
	-- [SpellName(19882)] = true,	-- Track Giants
	-- [SpellName(19885)] = true,	-- Track Hidden
	-- [SpellName(19883)] = true,	-- Track Humanoids
	-- [SpellName(19884)] = true,	-- Track Undead
	-- [SpellName(19506)] = true,	-- Trueshot Aura
	[SpellName(35346)] = true,	-- Warp (Warp Stalker)

	-- Mage
	-- [SpellName(12536)] = true,	-- Arcane Concentration (Clearcasting)
	[SpellName(12042)] = true,	-- Arcane Power
	[SpellName(31643)] = true,	-- Blazing Speed
	[SpellName(28682)] = true,	-- Combustion
	[SpellName(543)] = true,	-- Fire Ward
	[SpellName(6143)] = true,	-- Frost Ward
	[SpellName(11426)] = true,	-- Ice Barrier
	[SpellName(45438)] = true,	-- Ice Block
	[SpellName(12472)] = true,	-- Icy Veins
	[SpellName(47000)] = true,	-- Improved Blink
	-- [SpellName(66)] = true,		-- Invisibility
	[SpellName(1463)] = true,	-- Mana Shield
	[SpellName(12043)] = true,	-- Presence of Mind
	[SpellName(130)] = true,	-- Slow Fall

	-- Paladin
	[SpellName(31884)] = true,	-- Avenging Wrath
	[SpellName(1044)] = true,	-- Blessing of Freedom
	[SpellName(1022)] = true,	-- Blessing of Protection
	[SpellName(6940)] = true,	-- Blessing of Sacrifice
	-- [SpellName(19746)] = true,	-- Concentration Aura
	-- [SpellName(32223)] = true,	-- Crusader Aura
	-- [SpellName(465)] = true,	-- Devotion Aura
	[SpellName(20216)] = true,	-- Divine Favor
	[SpellName(31842)] = true,	-- Divine Illumination
	-- [SpellName(19752)] = true,	-- Divine Intervention
	[SpellName(498)] = true,	-- Divine Protection
	[SpellName(642)] = true,	-- Divine Shield
	-- [SpellName(19891)] = true,	-- Fire Resistance Aura
	-- [SpellName(19888)] = true,	-- Frost Resistance Aura
	[SpellName(20925)] = true,	-- Holy Shield
	[SpellName(20233)] = true,	-- Lay on Hands (Armor Bonus)
	-- [SpellName(31834)] = true,	-- Light's Grace
	-- [SpellName(20178)] = true,	-- Reckoning
	-- [SpellName(20128)] = true,	-- Redoubt
	-- [SpellName(7294)] = true,	-- Retribution Aura
	-- [SpellName(20218)] = true,	-- Sanctity Aura
	[SpellName(31892)] = true,	-- Seal of Blood
	[SpellName(20375)] = true,	-- Seal of Command
	[SpellName(348704)] = true,	-- Seal of Corruption
	[SpellName(20164)] = true,	-- Seal of Justice
	[SpellName(20165)] = true,	-- Seal of Light
	[SpellName(21084)] = true,	-- Seal of Righteousness
	[SpellName(31801)] = true,	-- Seal of Vengeance
	[SpellName(20166)] = true,	-- Seal of Wisdom
	[SpellName(21082)] = true,	-- Seal of the Crusader
	[SpellName(348700)] = true,	-- Seal of the Martyr
	-- [SpellName(5502)] = true,	-- Sense Undead
	-- [SpellName(19876)] = true,	-- Shadow Resistance Aura
	[SpellName(20050)] = true,	-- Vengeance

	-- Priest
	[SpellName(552)] = true,	-- Abolish Disease
	[SpellName(27813)] = true,	-- Blessed Recovery
	[SpellName(33143)] = true,	-- Blessed Resilience
	[SpellName(2651)] = true,	-- Elune's Grace
	-- [SpellName(586)] = true,		-- Fade
	[SpellName(6346)] = true,	-- Fear Ward
	[SpellName(13896)] = true,	-- Feedback
	-- [SpellName(45237)] = true,	-- Focused Will
	-- [SpellName(34754)] = true,	-- Holy Concentration (Clearcasting)
	[SpellName(588)] = true,	-- Inner Fire
	[SpellName(14751)] = true,	-- Inner Focus
	[SpellName(14893)] = true,	-- Inspiration
	[SpellName(1706)] = true,	-- Levitate
	[SpellName(7001)] = true,	-- Lightwell Renew
	-- [SpellName(14743)] = true,	-- Martyrdom (Focused Casting)
	[SpellName(10060)] = true,	-- Power Infusion
	[SpellName(33206)] = true,	-- Pain Suppression
	[SpellName(17)] = true,		-- Power Word: Shield
	[SpellName(41635)] = true,	-- Prayer of Mending
	[SpellName(139)] = true,	-- Renew
	-- [SpellName(15473)] = true,	-- Shadowform
	[SpellName(18137)] = true,	-- Shadowguard
	[SpellName(27827)] = true,	-- Spirit of Redemption
	[SpellName(15271)] = true,	-- Spirit Tap
	-- [SpellName(33151)] = true,	-- Surge of Light
	[SpellName(32548)] = true,	-- Symbol of Hope
	[SpellName(2652)] = true,	-- Touch of Weakness
	-- [SpellName(15290)] = true,	-- Vampiric Embrace
	-- [SpellName(34919)] = true,	-- Vampiric Touch

	-- Rogue
	[SpellName(13750)] = true,	-- Adrenaline Rush
	[SpellName(13877)] = true,	-- Blade Flurry
	[SpellName(31224)] = true,	-- Cloak of Shadows
	[SpellName(14177)] = true,	-- Cold Blood
	[SpellName(5277)] = true,	-- Evasion
	[SpellName(31234)] = true,	-- Find Weakness
	[SpellName(14278)] = true,	-- Ghostly Strike
	[SpellName(14143)] = true,	-- Remorseless Attacks
	[SpellName(36563)] = true,	-- Shadowstep
	[SpellName(5171)] = true,	-- Slice and Dice
	[SpellName(2983)] = true,	-- Sprint
	-- [SpellName(1784)] = true,	-- Stealth
	-- [SpellName(31621)] = true,	-- Stealth (Vanish)

	-- Shaman
	[SpellName(2825)] = true,	-- Bloodlust
	[SpellName(974)] = true,	-- Earth Shield
	[SpellName(30165)] = true,	-- Elemental Devastation
	-- [SpellName(16246)] = true,	-- Elemental Focus (Clearcasting)
	[SpellName(16166)] = true,	-- Elemental Mastery
	-- [SpellName(29063)] = true,	-- Eye of the Storm (Focused Casting)
	[SpellName(6196)] = true,	-- Far Sight
	-- [SpellName(8185)] = true,	-- Fire Resistance Totem
	[SpellName(16257)] = true,	-- Flurry
	-- [SpellName(8182)] = true,	-- Frost Resistance Totem
	-- [SpellName(2645)] = true,	-- Ghost Wolf
	-- [SpellName(8836)] = true,	-- Grace of Air
	[SpellName(8178)] = true,	-- Grounding Totem Effect
	-- [SpellName(5672)] = true,	-- Healing Stream
	[SpellName(29203)] = true,	-- Healing Way
	[SpellName(32182)] = true,	-- Heroism
	[SpellName(324)] = true,	-- Lightning Shield
	-- [SpellName(5677)] = true,	-- Mana Spring Totem
	[SpellName(16191)] = true,	-- Mana Tide Totem
	[SpellName(16188)] = true,	-- Nature's Swiftness
	-- [SpellName(10596)] = true,	-- Nature Resistance Totem
	-- [SpellName(6495)] = true,	-- Sentry Totem
	-- [SpellName(43339)] = true,	-- Shamanistic Focus (Focused)
	[SpellName(30823)] = true,	-- Shamanistic Rage
	-- [SpellName(8072)] = true,	-- Stoneskin Totem
	-- [SpellName(8076)] = true,	-- Strength of Earth
	-- [SpellName(30708)] = true,	-- Totem of Wrath
	[SpellName(30803)] = true,	-- Unleashed Rage
	[SpellName(24398)] = true,	-- Water Shield
	-- [SpellName(15108)] = true,	-- Windwall Totem
	-- [SpellName(2895)] = true,	-- Wrath of Air Totem

	-- Warlock
	[SpellName(18288)] = true,	-- Amplify Curse
	[SpellName(34936)] = true,	-- Backlash
	-- [SpellName(6307)] = true,	-- Blood Pact (Imp)
	[SpellName(17767)] = true,	-- Consume Shadows (Voidwalker)
	-- [SpellName(48018)] = true,	-- Demonic Circle: Summon
	[SpellName(126)] = true,	-- Eye of Kilrogg
	[SpellName(2947)] = true,	-- Fire Shield (Imp)
	[SpellName(755)] = true,	-- Health Funnel
	[SpellName(1949)] = true,	-- Hellfire
	-- [SpellName(7870)] = true,	-- Lesser Invisibility (Succubus)
	-- [SpellName(23759)] = true,	-- Master Demonologist (Imp - Reduced Threat)
	-- [SpellName(23760)] = true,	-- Master Demonologist (Voidwalker - Reduced Physical Taken)
	-- [SpellName(23761)] = true,	-- Master Demonologist (Succubus - Increased Damage)
	-- [SpellName(23762)] = true,	-- Master Demonologist (Felhunter - Increased Resistance)
	-- [SpellName(35702)] = true,	-- Master Demonologist (Felguard - Increased Damage/Resistance)
	[SpellName(30300)] = true,	-- Nether Protection
	-- [SpellName(19480)] = true,	-- Paranoia (Felhunter)
	-- [SpellName(4511)] = true,	-- Phase Shift (Imp)
	[SpellName(7812)] = true,	-- Sacrifice (Voidwalker)
	-- [SpellName(5500)] = true,	-- Sense Demons
	[SpellName(17941)] = true,	-- Shadow Trance
	[SpellName(6229)] = true,	-- Shadow Ward
	[SpellName(25228)] = true,	-- Soul Link
	[SpellName(20707)] = true,	-- Soulstone Resurrection
	[SpellName(19478)] = true,	-- Tainted Blood (Felhunter)

	-- Warrior
	[SpellName(6673)] = true,	-- Battle Shout
	[SpellName(18499)] = true,	-- Berserker Rage
	[SpellName(29131)] = true,	-- Bloodrage
	[SpellName(23885)] = true,	-- Bloodthirst
	[SpellName(16488)] = true,	-- Blood Craze
	[SpellName(469)] = true,	-- Commanding Shout
	[SpellName(12292)] = true,	-- Death Wish
	[SpellName(12880)] = true,	-- Enrage
	[SpellName(12966)] = true,	-- Flurry
	[SpellName(3411)] = true,	-- Intervene
	[SpellName(12975)] = true,	-- Last Stand
	-- [SpellName(29801)] = true,	-- Rampage (Base)
	[SpellName(30029)] = true,	-- Rampage (Stack)
	[SpellName(1719)] = true,	-- Recklessness
	[SpellName(20230)] = true,	-- Retaliation
	[SpellName(29841)] = true,	-- Second Wind
	[SpellName(871)] = true,	-- Shield Wall
	[SpellName(23920)] = true,	-- Spell Reflection
	[SpellName(12328)] = true,	-- Sweeping Strikes

	-- Racial
	[SpellName(20554)] = true,	-- Berserking (Mana)
	-- [SpellName(26296)] = true,	-- Berserking (Rage)
	-- [SpellName(26297)] = true,	-- Berserking (Energy)
	-- [SpellName(20572)] = true,	-- Blood Fury (Physical)
	[SpellName(33697)] = true,	-- Blood Fury (Both)
	-- [SpellName(33702)] = true,	-- Blood Fury (Spell)
	-- [SpellName(2481)] = true,	-- Find Treasure
	[SpellName(28880)] = true,	-- Gift of the Naaru
	[SpellName(20600)] = true,	-- Perception
	-- [SpellName(20580)] = true,	-- Shadowmeld
	[SpellName(20594)] = true,	-- Stoneform
	[SpellName(7744)] = true,	-- Will of the Forsaken
}

for _, spell in pairs(C.nameplate.buffs_list) do
	T.BuffWhiteList[SpellName(spell)] = true
end

T.BuffBlackList = {
	-- [SpellName(spellID)] = true,	-- Spell Name
}

T.PlateBlacklist = {
	-- Hunter Trap
	["19833"] = true,		-- Venomous Snake
	["19921"] = true,		-- Viper
	-- Raid
}

T.InterruptCast = { -- Yellow border for interruptible cast
	-- [SpellID] = true,	-- Spell Name
}

T.ImportantCast = { -- Red border for non-interruptible cast
	-- [SpellID] = true,	-- Spell Name
}

local color = C.nameplate.mob_color
local color_alt = {0, 0.7, 0.6}
T.ColorPlate = {
	-- PvP
		["5925"] = color,		-- Grounding Totem
	-- Raid
		-- Karazhan
		["15547"] = color,		-- Spectral Charger
		["16461"] = color,		-- Concubine
		["16471"] = color,		-- Skeletal Usher
		-- Gruul's Lair
		["21350"] = color,		-- Gronn-Priest
		-- Serpentshrine Cavern
		["22236"] = color,		-- Water Elemental Totem
		["22091"] = color,		-- Spitfire Totem
		-- Tempest Keep
		-- Battle for Mount Hyjal
		-- Black Temple
		["22894"] = color,		-- Cyclone Totem
		-- Zul'Aman
		-- Sunwell
		["25772"] = color,		-- Void Sentinel
		["25370"] = color,		-- Sunblade Dusk Priest
	-- Dungeons
		-- Hellfire Ramparts
		["17478"] = color,		-- Bleeding Hollow Scryer
		-- The Blood Furnace
		["17399"] = color,		-- Seductress
		["17401"] = color,		-- Felhound Manastalker
		-- The Slave Pens
		["17957"] = color,		-- Coilfang Champion
		["17960"] = color,		-- Coilfang Soothsayer
		["21128"] = color,		-- Coilfang Ray
		-- The Underbog
		["17731"] = color,		-- Fen Ray
		-- Mana-Tombs
		["18315"] = color,		-- Ethereal Theurgist
		["18331"] = color,		-- Ethereal Darkcaster
		-- ["19306"] = color,		-- Mana Leech
		["19307"] = color,		-- Nexus Terror
		-- Auchenai Crypts
		["18503"] = color,		-- Phantasmal Possessor
		["18506"] = color,		-- Raging Soul
		-- Sethekk Halls
		["18325"] = color,		-- Sethekk Prophet
		["18327"] = color,		-- Time-Lost Controller
		["20343"] = color_alt,		-- Charming Totem
		-- Old Hillsbrad Foothills
		["17833"] = color,		-- Durnholde Warden
		["18934"] = color,		-- Durnholde Mage
		-- The Black Morass
		["21104"] = color,		-- Rift Keeper
		["21148"] = color,		-- Rift Keeper
		-- The Mechanar
		["20990"] = color,		-- Bloodwarder Physician
		-- Shadow Labyrinth
		["18639"] = color,		-- Cabal Spellbinder
		["18663"] = color,		-- Maiden of Discipline
		["18796"] = color,		-- Fel Overseer
		-- The Shattered Halls
		["17694"] = color,		-- Shadowmoon Darkcaster
		-- The Steamvault
		["17801"] = color,		-- Coilfang Siren
		-- The Arcatraz
		["20883"] = color,		-- Spiteful Temptress
		["20897"] = color,		-- Ethereum Wave-Caster
		-- The Botanica
		["18419"] = color,		-- Bloodwarder Greenkeeper
		["19509"] = color,		-- Sunseeker Harvester
		["19633"] = color,		-- Bloodwarder Mender
		-- Magisters' Terrace
}
