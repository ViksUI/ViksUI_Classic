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
	[SpellName(99)] = true,		-- Demoralizing Roar
	[SpellName(339)] = true,	-- Entangling Roots
	-- [SpellName(19975)] = true,	-- Entangling Roots (Nature's Grasp)
	[SpellName(770)] = true,	-- Faerie Fire
	[SpellName(16857)] = true,	-- Faerie Fire (Feral)
	[SpellName(19675)] = true,	-- Feral Charge Effect
	[SpellName(2637)] = true,	-- Hibernate
	-- [SpellName(16914)] = true,	-- Hurricane
	[SpellName(5570)] = true,	-- Insect Swarm
	[SpellName(414644)] = true,	-- Lacerate [Season of Discovery]
	[SpellName(407995)] = true,	-- Mangle (Bear) [Season of Discovery]
	[SpellName(407993)] = true,	-- Mangle (Cat) [Season of Discovery]
	[SpellName(8921)] = true,	-- Moonfire
	[SpellName(9005)] = true,	-- Pounce
	[SpellName(9007)] = true,	-- Pounce Bleed
	[SpellName(1822)] = true,	-- Rake
	[SpellName(1079)] = true,	-- Rip
	[SpellName(2908)] = true,	-- Soothe Animal
	[SpellName(414684)] = true,	-- Sunfire [Season of Discovery]
	-- [SpellName(414687)] = true,	-- Sunfire (Bear) [Season of Discovery]
	-- [SpellName(414689)] = true,	-- Sunfire (Cat) [Season of Discovery]

	-- Hunter
	-- [SpellName(1462)] = true,	-- Beast Lore
	[SpellName(3674)] = true,	-- Black Arrow
	[SpellName(25999)] = true,	-- Charge (Boar)
	[SpellName(409495)] = true,	-- Chimera Shot - Scorpid [Season of Discovery]
	[SpellName(5116)] = true,	-- Concussive Shot
	[SpellName(19306)] = true,	-- Counterattack
	[SpellName(19185)] = true,	-- Entrapment
	[SpellName(409552)] = true,	-- Explosive Shot [Season of Discovery]
	[SpellName(13812)] = true,	-- Explosive Trap Effect
	[SpellName(409507)] = true,	-- Expose Weakness [Season of Discovery]
	[SpellName(1543)] = true,	-- Flare
	[SpellName(3355)] = true,	-- Freezing Trap Effect
	[SpellName(13810)] = true,	-- Frost Trap Aura
	[SpellName(1130)] = true,	-- Hunter's Mark
	[SpellName(13797)] = true,	-- Immolation Trap Effect
	[SpellName(19410)] = true,	-- Improved Concussive Shot
	[SpellName(19229)] = true,	-- Improved Wing Clip
	[SpellName(24394)] = true,	-- Intimidation
	[SpellName(444678)] = true,	-- Lava Breath [Season of Discovery]
	[SpellName(1513)] = true,	-- Scare Beast
	[SpellName(19503)] = true,	-- Scatter Shot
	[SpellName(24640)] = true,	-- Scorpid Poison (Scorpid)
	[SpellName(3043)] = true,	-- Scorpid Sting
	[SpellName(24423)] = true,	-- Screech (Bat / Bird of Prey / Carrion Bird)
	[SpellName(1978)] = true,	-- Serpent Sting
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
	[SpellName(18469)] = true,	-- Counterspell - Silenced
	[SpellName(428739)] = true,	-- Deep Freeze [Season of Discovery]
	[SpellName(133)] = true,	-- Fireball
	[SpellName(22959)] = true,	-- Fire Vulnerability (Improved Scorch)
	[SpellName(2120)] = true,	-- Flamestrike
	[SpellName(122)] = true,	-- Frost Nova
	[SpellName(12494)] = true,	-- Frostbite
	[SpellName(116)] = true,	-- Frostbolt
	[SpellName(401502)] = true,	-- Frostfire Bolt [Season of Discovery]
	[SpellName(12654)] = true,	-- Ignite
	[SpellName(12355)] = true,	-- Impact
	[SpellName(400613)] = true,	-- Living Bomb [Season of Discovery]
	-- [SpellName(401558)] = true,	-- Living Flame [Season of Discovery]
	[SpellName(118)] = true,	-- Polymorph
	[SpellName(11366)] = true,	-- Pyroblast
	[SpellName(412532)] = true,	-- Spellfrost Bolt [Season of Discovery]
	[SpellName(12579)] = true,	-- Winter's Chill

	-- Paladin
	[SpellName(407669)] = true,	-- Avenger's Shield [Season of Discovery]
	[SpellName(26573)] = true,	-- Consecration
	[SpellName(853)] = true,	-- Hammer of Justice
	[SpellName(407631)] = true,	-- Hand of Reckoning [Season of Discovery]
	[SpellName(20184)] = true,	-- Judgement of Justice
	[SpellName(20185)] = true,	-- Judgement of Light
	[SpellName(20186)] = true,	-- Judgement of Wisdom
	[SpellName(21183)] = true,	-- Judgement of the Crusader
	[SpellName(20066)] = true,	-- Repentance
	[SpellName(20170)] = true,	-- Seal of Justice (Stun)
	[SpellName(2878)] = true,	-- Turn Undead
	[SpellName(67)] = true,		-- Vindication

	-- Priest
	[SpellName(15269)] = true,	-- Blackout
	[SpellName(402808)] = true,	-- Cripple (Homunculi) [Season of Discovery]
	[SpellName(402792)] = true,	-- Curse of the Elements (Eye of the Void) [Season of Discovery]
	[SpellName(402791)] = true,	-- Curse of Shadow (Eye of the Void) [Season of Discovery]
	[SpellName(402794)] = true,	-- Curse of Tongues (Eye of the Void) [Season of Discovery]
	[SpellName(402818)] = true,	-- Degrade (Homunculi) [Season of Discovery]
	[SpellName(402811)] = true,	-- Demoralize (Homunculi) [Season of Discovery]
	[SpellName(2944)] = true,	-- Devouring Plague
	[SpellName(9035)] = true,	-- Hex of Weakness
	[SpellName(14914)] = true,	-- Holy Fire
	[SpellName(605)] = true,	-- Mind Control
	[SpellName(15407)] = true,	-- Mind Flay
	[SpellName(413259)] = true,	-- Mind Sear [Season of Discovery]
	[SpellName(453)] = true,	-- Mind Soothe
	[SpellName(2096)] = true,	-- Mind Vision
	[SpellName(8122)] = true,	-- Psychic Scream
	[SpellName(9484)] = true,	-- Shackle Undead
	[SpellName(15258)] = true,	-- Shadow Vulnerability (Shadow Weaving)
	[SpellName(589)] = true,	-- Shadow Word: Pain
	[SpellName(15487)] = true,	-- Silence
	[SpellName(10797)] = true,	-- Starshards
	[SpellName(2943)] = true,	-- Touch of Weakness
	[SpellName(15286)] = true,	-- Vampiric Embrace
	[SpellName(425204)] = true,	-- Void Plague [Season of Discovery]
	[SpellName(431681)] = true,	-- Void Zone [Season of Discovery]

	-- Rogue
	[SpellName(439473)] = true,	-- Atrophic Poison [Season of Discovery]
	[SpellName(400009)] = true,	-- Between the Eyes [Season of Discovery]
	[SpellName(2094)] = true,	-- Blind
	[SpellName(1833)] = true,	-- Cheap Shot
	[SpellName(3409)] = true,	-- Crippling Poison
	[SpellName(2818)] = true,	-- Deadly Poison
	[SpellName(8647)] = true,	-- Expose Armor
	[SpellName(703)] = true,	-- Garrote
	[SpellName(1776)] = true,	-- Gouge
	[SpellName(16511)] = true,	-- Hemorrhage
	[SpellName(18425)] = true,	-- Kick - Silenced
	[SpellName(408)] = true,	-- Kidney Shot
	[SpellName(5760)] = true,	-- Mind-numbing Poison
	[SpellName(439472)] = true,	-- Numbing Poison [Season of Discovery]
	[SpellName(398196)] = true,	-- Quick Draw [Season of Discovery]
	[SpellName(14251)] = true,	-- Riposte
	[SpellName(1943)] = true,	-- Rupture
	[SpellName(424785)] = true,	-- Saber Lash [Season of Discovery]
	[SpellName(6770)] = true,	-- Sap
	[SpellName(439471)] = true,	-- Sebacious Poison [Season of Discovery]
	[SpellName(415725)] = true,	-- Waylay [Season of Discovery]
	[SpellName(13218)] = true,	-- Wound Poison

	-- Shaman
	[SpellName(3600)] = true,	-- Earthbind
	[SpellName(408681)] = true,	-- Earth Shock (Way of Earth) [Season of Discovery]
	[SpellName(8050)] = true,	-- Flame Shock
	[SpellName(8056)] = true,	-- Frost Shock
	[SpellName(8034)] = true,	-- Frostbrand Attack
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
	[SpellName(17862)] = true,	-- Curse of Shadow
	[SpellName(1714)] = true,	-- Curse of Tongues
	[SpellName(702)] = true,	-- Curse of Weakness
	[SpellName(1490)] = true,	-- Curse of the Elements
	[SpellName(6789)] = true,	-- Death Coil
	[SpellName(412789)] = true,	-- Demonic Howl (Metamorphosis) [Season of Discovery]
	[SpellName(689)] = true,	-- Drain Life
	[SpellName(5138)] = true,	-- Drain Mana
	[SpellName(1120)] = true,	-- Drain Soul
	[SpellName(1098)] = true,	-- Enslave Demon
	[SpellName(5782)] = true,	-- Fear
	[SpellName(403501)] = true,	-- Haunt [Season of Discovery]
	[SpellName(5484)] = true,	-- Howl of Terror
	[SpellName(348)] = true,	-- Immolate
	[SpellName(412758)] = true,	-- Incinerate [Season of Discovery]
	-- [SpellName(403650)] = true,	-- Lake of Fire [Season of Discovery]
	[SpellName(403828)] = true,	-- Menace (Metamorphosis) [Season of Discovery]
	[SpellName(18093)] = true,	-- Pyroclasm
	-- [SpellName(5740)] = true,	-- Rain of Fire
	[SpellName(6358)] = true,	-- Seduction (Succubus)
	[SpellName(426325)] = true,	-- Shadowflame [Season of Discovery]
	[SpellName(17794)] = true,	-- Shadow Vulnerability (Improved Shadow Bolt)
	[SpellName(18265)] = true,	-- Siphon Life
	[SpellName(24259)] = true,	-- Spell Lock (Felhunter)
	[SpellName(21949)] = true,	-- Rend (Doomguard)
	[SpellName(19479)] = true,	-- Tainted Blood Effect (Felhunter)
	[SpellName(427717)] = true,	-- Unstable Affliction [Season of Discovery]
	-- [SpellName(427719)] = true,	-- Unstable Affliction (Silence) [Season of Discovery]

	-- Warrior
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
	[SpellName(417141)] = true,	-- Berserk [Season of Discovery]
	[SpellName(1850)] = true,	-- Dash
	-- [SpellName(408261)] = true,	-- Dreamstate [Season of Discovery]
	[SpellName(417147)] = true,	-- Efflorescence [Season of Discovery]
	[SpellName(5229)] = true,	-- Enrage
	[SpellName(22842)] = true,	-- Frenzied Regeneration
	[SpellName(414800)] = true,	-- Fury of Stormrage [Season of Discovery]
	[SpellName(29166)] = true,	-- Innervate
	-- [SpellName(24932)] = true,	-- Leader of the Pack
	[SpellName(408124)] = true,	-- Lifebloom [Season of Discovery]
	[SpellName(414680)] = true,	-- Living Seed [Season of Discovery]
	-- [SpellName(16886)] = true,	-- Nature's Grace
	[SpellName(16689)] = true,	-- Nature's Grasp
	[SpellName(17116)] = true,	-- Nature's Swiftness
	-- [SpellName(16870)] = true,	-- Omen of Clarity (Clearcasting)
	-- [SpellName(5215)] = true,	-- Prowl
	[SpellName(8936)] = true,	-- Regrowth
	[SpellName(774)] = true,	-- Rejuvenation
	[SpellName(407988)] = true,	-- Savage Roar [Season of Discovery]
	[SpellName(408024)] = true,	-- Survival Instincts [Season of Discovery]
	[SpellName(5217)] = true,	-- Tiger's Fury
	-- [SpellName(5225)] = true,	-- Track Humanoids
	[SpellName(740)] = true,	-- Tranquility

	-- Hunter
	-- [SpellName(13161)] = true,	-- Aspect of the Beast
	[SpellName(5118)] = true,	-- Aspect of the Cheetah
	-- [SpellName(13165)] = true,	-- Aspect of the Hawk
	-- [SpellName(13163)] = true,	-- Aspect of the Monkey
	[SpellName(13159)] = true,	-- Aspect of the Pack
	-- [SpellName(20043)] = true,	-- Aspect of the Wild
	[SpellName(19574)] = true,	-- Bestial Wrath
	[SpellName(25077)] = true,	-- Cobra Reflexes (Pet)
	[SpellName(425714)] = true,	-- Cobra Strikes (Pet) [Season of Discovery]
	[SpellName(23099)] = true,	-- Dash (Pet)
	[SpellName(19263)] = true,	-- Deterrence
	[SpellName(23145)] = true,	-- Dive (Pet)
	[SpellName(6197)] = true,	-- Eagle Eye
	[SpellName(1002)] = true,	-- Eyes of the Beast
	-- [SpellName(1539)] = true,	-- Feed Pet Effect
	[SpellName(5384)] = true,	-- Feign Death
	[SpellName(415320)] = true,	-- Flanking Strike [Season of Discovery]
	[SpellName(428726)] = true,	-- Focus Fire [Season of Discovery]
	[SpellName(19615)] = true,	-- Frenzy Effect
	[SpellName(24604)] = true,	-- Furious Howl (Wolf)
	[SpellName(409418)] = true,	-- Kill Command (Pet) [Season of Discovery]
	[SpellName(415414)] = true,	-- Lock and Load [Season of Discovery]
	[SpellName(136)] = true,	-- Mend Pet
	-- [SpellName(24450)] = true,	-- Prowl (Cat)
	[SpellName(6150)] = true,	-- Quick Shots
	[SpellName(3045)] = true,	-- Rapid Fire
	[SpellName(415407)] = true,	-- Rapid Killing [Season of Discovery]
	[SpellName(415362)] = true,	-- Raptor Fury [Season of Discovery]
	[SpellName(26064)] = true,	-- Shell Shield (Turtle)
	[SpellName(415401)] = true,	-- Sniper Training [Season of Discovery]
	-- [SpellName(19579)] = true,	-- Spirit Bond
	-- [SpellName(1515)] = true,	-- Tame Beast
	-- [SpellName(1494)] = true,	-- Track Beasts
	-- [SpellName(19878)] = true,	-- Track Demons
	-- [SpellName(19879)] = true,	-- Track Dragonkin
	-- [SpellName(19880)] = true,	-- Track Elementals
	-- [SpellName(19882)] = true,	-- Track Giants
	-- [SpellName(19885)] = true,	-- Track Hidden
	-- [SpellName(19883)] = true,	-- Track Humanoids
	-- [SpellName(19884)] = true,	-- Track Undead
	-- [SpellName(19506)] = true,	-- Trueshot Aura

	-- Mage
	-- [SpellName(400573)] = true,	-- Arcane Blast [Season of Discovery]
	-- [SpellName(12536)] = true,	-- Arcane Concentration (Clearcasting)
	[SpellName(12042)] = true,	-- Arcane Power
	[SpellName(425124)] = true,	-- Arcane Surge [Season of Discovery]
	-- [SpellName(428878)] = true,	-- Balefire Bolt [Season of Discovery]
	[SpellName(436516)] = true,	-- Chronostatic Preservation[Season of Discovery]
	[SpellName(28682)] = true,	-- Combustion
	[SpellName(412326)] = true,	-- Enlightenment [Season of Discovery]
	[SpellName(400669)] = true,	-- Fingers of Frost [Season of Discovery]
	[SpellName(543)] = true,	-- Fire Ward
	[SpellName(6143)] = true,	-- Frost Ward
	[SpellName(400624)] = true,	-- Hot Streak [Season of Discovery]
	[SpellName(11426)] = true,	-- Ice Barrier
	[SpellName(11958)] = true,	-- Ice Block
	[SpellName(429125)] = true,	-- Icy Veins [Season of Discovery]
	[SpellName(1463)] = true,	-- Mana Shield
	[SpellName(412510)] = true,	-- Mass Regeneration [Season of Discovery]
	[SpellName(400589)] = true,	-- Missile Barrage [Season of Discovery]
	[SpellName(12043)] = true,	-- Presence of Mind
	[SpellName(401460)] = true,	-- Rapid Regeneration [Season of Discovery]
	[SpellName(401417)] = true,	-- Regeneration [Season of Discovery]
	[SpellName(130)] = true,	-- Slow Fall
	[SpellName(428885)] = true,	-- Temporal Anomaly [Season of Discovery]
	[SpellName(400735)] = true,	-- Temporal Beacon [Season of Discovery]

	-- Paladin
	-- [SpellName(425585)] = true,	-- Aegis [Season of Discovery]
	[SpellName(1044)] = true,	-- Blessing of Freedom
	[SpellName(1022)] = true,	-- Blessing of Protection
	[SpellName(6940)] = true,	-- Blessing of Sacrifice
	-- [SpellName(19746)] = true,	-- Concentration Aura
	-- [SpellName(465)] = true,	-- Devotion Aura
	[SpellName(20216)] = true,	-- Divine Favor
	-- [SpellName(19752)] = true,	-- Divine Intervention
	[SpellName(498)] = true,	-- Divine Protection
	[SpellName(642)] = true,	-- Divine Shield
	-- [SpellName(19891)] = true,	-- Fire Resistance Aura
	-- [SpellName(19888)] = true,	-- Frost Resistance Aura
	[SpellName(20925)] = true,	-- Holy Shield
	[SpellName(425600)] = true,	-- Horn of Lordaeron [Season of Discovery]
	[SpellName(6346)] = true,	-- Inspiration Exemplar [Season of Discovery]
	[SpellName(20233)] = true,	-- Lay on Hands (Armor Bonus)
	-- [SpellName(428909)] = true,	-- Light's Grace [Season of Discovery]
	-- [SpellName(20178)] = true,	-- Reckoning
	-- [SpellName(20128)] = true,	-- Redoubt
	-- [SpellName(7294)] = true,	-- Retribution Aura
	-- [SpellName(20218)] = true,	-- Sanctity Aura
	[SpellName(20375)] = true,	-- Seal of Command
	[SpellName(20164)] = true,	-- Seal of Justice
	[SpellName(20165)] = true,	-- Seal of Light
	[SpellName(407798)] = true,	-- Seal of Martyrdom [Season of Discovery]
	[SpellName(21084)] = true,	-- Seal of Righteousness
	[SpellName(20166)] = true,	-- Seal of Wisdom
	[SpellName(21082)] = true,	-- Seal of the Crusader
	-- [SpellName(5502)] = true,	-- Sense Undead
	-- [SpellName(19876)] = true,	-- Shadow Resistance Aura
	[SpellName(426162)] = true,	-- Sheath of Light [Season of Discovery]
	[SpellName(53489)] = true,	-- The Art of War [Season of Discovery]
	[SpellName(20050)] = true,	-- Vengeance

	-- Priest
	[SpellName(552)] = true,	-- Abolish Disease
	[SpellName(27813)] = true,	-- Blessed Recovery
	[SpellName(425294)] = true,	-- Dispersion [Season of Discovery]
	[SpellName(431624)] = true,	-- Divine Aegis [Season of Discovery]
	[SpellName(2651)] = true,	-- Elune's Grace
	-- [SpellName(586)] = true,		-- Fade
	[SpellName(6346)] = true,	-- Fear Ward
	[SpellName(13896)] = true,	-- Feedback
	[SpellName(588)] = true,	-- Inner Fire
	[SpellName(14751)] = true,	-- Inner Focus
	[SpellName(14893)] = true,	-- Inspiration
	[SpellName(1706)] = true,	-- Levitate
	[SpellName(7001)] = true,	-- Lightwell Renew
	-- [SpellName(14743)] = true,	-- Martyrdom (Focused Casting)
	[SpellName(431655)] = true,	-- Mind Spike [Season of Discovery]
	[SpellName(402004)] = true,	-- Pain Suppression [Season of Discovery]
	[SpellName(10060)] = true,	-- Power Infusion
	[SpellName(425205)] = true,	-- Power Word: Barrier [Season of Discovery]
	[SpellName(17)] = true,		-- Power Word: Shield
	[SpellName(401859)] = true,	-- Prayer of Mending [Season of Discovery]
	[SpellName(425284)] = true,	-- Spirit of the Redeemer [Season of Discovery]
	[SpellName(139)] = true,	-- Renew
	-- [SpellName(413247)] = true,	-- Serendipity [Season of Discovery]
	-- [SpellName(15473)] = true,	-- Shadowform
	[SpellName(18137)] = true,	-- Shadowguard
	[SpellName(27827)] = true,	-- Spirit of Redemption
	[SpellName(15271)] = true,	-- Spirit Tap
	[SpellName(431666)] = true,	-- Surge of Ligh [Season of Discovery]
	[SpellName(2652)] = true,	-- Touch of Weakness
	-- [SpellName(15290)] = true,	-- Vampiric Embrace

	-- Rogue
	[SpellName(13750)] = true,	-- Adrenaline Rush
	[SpellName(400012)] = true,	-- Blade Dance [Season of Discovery]
	[SpellName(13877)] = true,	-- Blade Flurry
	[SpellName(14177)] = true,	-- Cold Blood
	[SpellName(5277)] = true,	-- Evasion
	[SpellName(14278)] = true,	-- Ghostly Strike
	[SpellName(424919)] = true,	-- Main Gauche [Season of Discovery]
	[SpellName(425098)] = true,	-- Master of Subtlety [Season of Discovery]
	[SpellName(400015)] = true,	-- Rolling with the Punches [Season of Discovery]
	[SpellName(406722)] = true,	-- Shadowstep [Season of Discovery]
	[SpellName(5171)] = true,	-- Slice and Dice
	[SpellName(2983)] = true,	-- Sprint
	-- [SpellName(1784)] = true,	-- Stealth
	[SpellName(14143)] = true,	-- Remorseless Attacks

	-- Shaman
	[SpellName(425876)] = true,	-- Decoy Totem (Redirect) [Season of Discovery]
	-- [SpellName(436391)] = true,	-- Decoy Totem (Immunity) [Season of Discovery]
	[SpellName(974)] = true,	-- Earth Shield [Season of Discovery]
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
	[SpellName(324)] = true,	-- Lightning Shield
	[SpellName(409946)] = true,	-- Maelstrom Weapon [Season of Discovery]
	-- [SpellName(5677)] = true,	-- Mana Spring Totem
	[SpellName(16191)] = true,	-- Mana Tide Totem
	-- [SpellName(415144)] = true,	-- Mental Dexterity [Season of Discovery]
	[SpellName(16188)] = true,	-- Nature's Swiftness
	-- [SpellName(10596)] = true,	-- Nature Resistance Totem
	[SpellName(415105)] = true,	-- Power Surge [Season of Discovery]
	[SpellName(408521)] = true,	-- Riptide [Season of Discovery]
	-- [SpellName(6495)] = true,	-- Sentry Totem
	[SpellName(425336)] = true,	-- Shamanistic Rage [Season of Discovery]
	-- [SpellName(408525)] = true,	-- Shield Mastery [Season of Discovery]
	-- [SpellName(408696)] = true,	-- Spirit of the Alpha [Season of Discovery]
	-- [SpellName(8072)] = true,	-- Stoneskin Totem
	-- [SpellName(8076)] = true,	-- Strength of Earth
	[SpellName(432041)] = true,	-- Tidal Waves [Season of Discovery]
	-- [SpellName(436365)] = true,	-- Two-Handed Mastery [Season of Discovery]
	[SpellName(30803)] = true,	-- Unleashed Rage
	[SpellName(408510)] = true,	-- Water Shield [Season of Discovery]
	-- [SpellName(15108)] = true,	-- Windwall Totem
	-- [SpellName(2895)] = true,	-- Wrath of Air Totem

	-- Warlock
	[SpellName(18288)] = true,	-- Amplify Curse
	[SpellName(427713)] = true,	-- Backdraft [Season of Discovery]
	-- [SpellName(6307)] = true,	-- Blood Pact (Imp)
	[SpellName(17767)] = true,	-- Consume Shadows (Voidwalker)
	[SpellName(412800)] = true,	-- Dance of the Wicked [Season of Discovery]
	[SpellName(425463)] = true,	-- Demonic Grace [Season of Discovery]
	-- [SpellName(412735)] = true,	-- Demonic Knowledge [Season of Discovery]
	-- [SpellName(425467)] = true,	-- Demonic Pact [Season of Discovery]
	[SpellName(126)] = true,	-- Eye of Kilrogg
	[SpellName(2947)] = true,	-- Fire Shield (Imp)
	[SpellName(755)] = true,	-- Health Funnel
	[SpellName(1949)] = true,	-- Hellfire
	[SpellName(427726)] = true,	-- Immolation Aura [Seasonf of Discovery]
	-- [SpellName(7870)] = true,	-- Lesser Invisibility (Succubus)
	-- [SpellName(23759)] = true,	-- Master Demonologist (Imp - Reduced Threat)
	-- [SpellName(23760)] = true,	-- Master Demonologist (Voidwalker - Reduced Physical Taken)
	-- [SpellName(23761)] = true,	-- Master Demonologist (Succubus - Increased Damage)
	-- [SpellName(23762)] = true,	-- Master Demonologist (Felhunter - Increased Resistance)
	-- [SpellName(19480)] = true,	-- Paranoia (Felhunter)
	-- [SpellName(4511)] = true,	-- Phase Shift (Imp)
	[SpellName(7812)] = true,	-- Sacrifice (Voidwalker)
	-- [SpellName(5500)] = true,	-- Sense Demons
	[SpellName(426311)] = true,	-- Shadow and Flame [Season of Discovery]
	[SpellName(17941)] = true,	-- Shadow Trance
	[SpellName(6229)] = true,	-- Shadow Ward
	[SpellName(25228)] = true,	-- Soul Link
	[SpellName(20707)] = true,	-- Soulstone Resurrection
	[SpellName(19478)] = true,	-- Tainted Blood (Felhunter)
	[SpellName(426195)] = true,	-- Vengeance [Season of Discovery]

	-- Warrior
	[SpellName(6673)] = true,	-- Battle Shout
	[SpellName(18499)] = true,	-- Berserker Rage
	[SpellName(29131)] = true,	-- Bloodrage
	[SpellName(23885)] = true,	-- Bloodthirst
	[SpellName(16488)] = true,	-- Blood Craze
	[SpellName(413399)] = true,	-- Blood Surge [Season of Discovery]
	[SpellName(403215)] = true,	-- Commanding Shout [Season of Discovery]
	[SpellName(12328)] = true,	-- Death Wish
	[SpellName(12880)] = true,	-- Enrage
	[SpellName(425415)] = true,	-- Enrage (Consumed By Rage) [Season of Discovery]
	[SpellName(427066)] = true,	-- Enrage (Wrecking Crew) [Season of Discovery]
	[SpellName(402913)] = true,	-- Enraged Regeneration [Season of Discovery]
	[SpellName(402906)] = true,	-- Flagellation [Season of Discovery]
	[SpellName(12966)] = true,	-- Flurry
	[SpellName(403338)] = true,	-- Intervene [Season of Discovery]
	[SpellName(12975)] = true,	-- Last Stand
	--FIXME [SpellName(426942)] = true,	-- Rampage [Season of Discovery]
	[SpellName(1719)] = true,	-- Recklessness
	[SpellName(20230)] = true,	-- Retaliation
	[SpellName(871)] = true,	-- Shield Wall
	[SpellName(12292)] = true,	-- Sweeping Strikes

	-- Racial
	[SpellName(20554)] = true,	-- Berserking (Mana)
	-- [SpellName(26296)] = true,	-- Berserking (Rage)
	-- [SpellName(26297)] = true,	-- Berserking (Energy)
	[SpellName(23234)] = true,	-- Blood Fury
	-- [SpellName(2481)] = true,	-- Find Treasure
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
	-- ["NPCID"] = true,	-- NPC Name
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
		-- Blackfathom Deeps [Season of Discovery]
		["207457"] = color,		-- Corrupted Lightning Shield Totem
		-- Zul'Gurub
		["15112"] = color,		-- Brain Wash Totem
		-- Naxxramas
		["16385"] = color,		-- Lightning Totem
	-- Dungeons
}
