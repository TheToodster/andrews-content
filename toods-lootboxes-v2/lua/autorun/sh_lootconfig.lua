--[[------------------------------------------------------------
    ____________										   ___
    |		   |   									 	  |	  |
    |___	___|	__________   	__________			  |	  |
    	|	|	   /		  \	   /		  \		   	  |	  |
    	|	|	  |			   |  |			   |	  ____|   |
    	|	|	  |			   |  |			   |	 / 		  |
    	|	|	  |			   |  |			   |	|		  |
    	|___|	   \__________/    \__________/		 \________|

    Author: Tood/The Toodster.
    Contact: Discord - The Toodster#0001 || Steam - https://steamcommunity.com/id/freelancertood/
--]]------------------------------------------------------------

Loot = Loot or {}

-- How long, in seconds, do we want to wait before the lootbox disappears after a player presses E on it?
Loot.RemoveLootbox = 20
-- This is global so if 1 person uses the lootbox then it removes that lootbox from everyones screen. I'll work on making it clientside.

-- This determines if we should activate the boss lootbox. If false then it won't spawn from the NPCs of your choosing.
Loot.BossLootActive = true

-- If Loot.BossLootActive = false then ignore this table, if set to true then copy and paste the NPC names for the boss lootbox.
Loot.BossNPCs = {
	["npc_antlionguard"] = true,
	["npc_poisonzombie"] = true,
	["npc_zombie"] = true,
	["npc_fastzombie"] = true,
}

Loot.RareBossItems = { -- This table is the items that are HARDER to gain from the boss lootbox.
	"Corrupted Crystal ( Blue )",
	"Corrupted Crystal ( Green )",
	"Corrupted Crystal ( Purple )",
	"Corrupted Crystal ( Red )",
	"Corrupted Crystal ( White )",
	"Corrupted Crystal ( Yellow )",
	"Unstable Crystal ( Blue )",
	"Unstable Crystal ( Green )",
	"Unstable Crystal ( Purple )",
	"Unstable Crystal ( Red )",
	"Unstable Crystal ( White )",
	"Unstable Crystal ( Yellow )",
	"Hyperball",
	"Proficiency Amplifier",
	"Trident Hilt",
	"Twin Hilt",
}

Loot.CommonBossItems = { -- This table is the items that are EASIER to gain from the boss lootbox.
	"Dark Inner Crystal ( Blue )",
	"Dark Inner Crystal ( Green )",
	"Dark Inner Crystal ( Purple )",
	"Dark Inner Crystal ( Red )",
	"Dark Inner Crystal ( Yellow )",
	"Dark Inner Crystal ( Cyan )",
	"Dark Inner Crystal ( White )",
	"Dani Hilt",
	"Dual Blade 2 Hilt",
	"Dual Blade 3 Hilt",
	"Dual Blade 4 Hilt",
	"Royal 1 Hilt",
	"Royal 2 Hilt",
	"Royal 3 Hilt",
}

Loot.RareBossXP = {
	"220",
	"240",
	"260",
	"280",
	"300",
}

Loot.CommonBossXP = {
	"120",
	"140",
	"160",
	"180",
	"200",
}

-- What NPCs should the random lootbox drop from after killing them. Previously it dropped from ALL NPCs but now you can choose.
Loot.RandomNPCs = {
	["npc_combine_s"] = true,
	["npc_metropolice"] = true,
	["npc_headcrab"] = true,
	["npc_antlion"] = true,
}

--[[------------------------------
All Loot configurations are below.
To add in your own items
Open up your console, type in
wos_listitems
Then copy and paste the NAME inside
The "", without the 2 = or 121 = etc
--]]------------------------------

-- Misc item loot config
------------------------
Loot.MiscItems = {
    "Hyperball",
	"Mossman's Head",
	"Proficiency Amplifier",
	"Refined Steel",
	"Glass",
	"Aluminum Alloy",
}

Loot.MiscSounds = {
    "Sith Assassin Hum",
	"Dark Saber Hum",
	"Dooku's Hum",
	"Feather Stabilizer",
	"Heavish Hum",
	"Heavy Hum",
	"Jedi Hum",
	"Focal Idler",
	"Medium Hum",
	"Sith Hum",
	"Darth Vader Hum",
	"Broken Igniter",
	"Dark Saber Igniter",
	"Heavy Igniter",
	"Jedi Igniter",
	"Jedi 2 Igniter",
	"Kylo Ren's Igniter",
	"Sith Igniter",
	"Torch Igniter",
	"Vader's Igniter",
	"Dark Saber Swing",
	"Jedi Swing",
	"Arc Rectifier",
	"Sith Swing",
}
------------------------

-- Crystal loot config
------------------------
Loot.CommonCrystals = {
    "Crystal ( Blue )",
	"Crystal ( Green )",
	"Crystal ( Purple )",
	"Crystal ( Yellow )",
	"Crystal ( Red )",
}

Loot.RareCrystals = {
    "Crystal ( Orange )",
	"Crystal ( White )",
	"Crystal ( Cyan )",
	"Crystal ( Pink )",
	"Crystal ( Light Green )",
}
------------------------

-- Hilt loot config
------------------------
Loot.CommonHilts = {
	"Affiliation Hilt",
	"Basic 1 Hilt",
	"Basic 2 Hilt",
	"Basic 3 Hilt",
	"Basic 4 Hilt",
	"Basic 5 Hilt",
	"Basic 6 Hilt",
	"Basic 7 Hilt",
	"Basic 8 Hilt",
	"Basic 9 Hilt",
	"Byph Hilt",
	"Claw Hilt",
	"Compressed Hilt",
	"Dark Force 1 Hilt",
	"Dark Force 2 Hilt",
	"Dark Knight 1 Hilt",
	"Dark Knight 2 Hilt",
	"Exile Hilt",
	"Felucia 1 Hilt",
	"Felucia 2 Hilt",
	"Forked Hilt",
	"Ganodi Hilt",
	"Gray Hilt",
	"Gungan Hilt",
	"Gungi Hilt",
	"Kashyyyk Hilt",
	"Katooni Hilt",
	"Petro Hilt",
	"Pulsating Hilt",
	"Pulsating Blue Hilt",
	"Reborn Hilt",
	"Royal 1 Hilt",
	"Royal 2 Hilt",
	"Royal 3 Hilt",
	"Samurai Hilt",
	"Sparkling Hilt",
	"Spiralling Hilt",
	"Talz Hilt",
	"Theo Hilt",
	"Unknown Hilt",
	"Unstable Hilt",
	"Zatt Hilt",
	"Zebra Hilt",
}

Loot.RareHilts = {
    "Aayla Secura's Hilt",
	"Ancient Dark Saber Hilt",
	"Adi Galia's Hilt",
	"Anakin Skywalker's Hilt EP2",
	"Anakin Skywalker's Hilt EP3",
	"Asajj Ventress' Hilt",
	"Ahsoka Tano's Hilt",
	"Dark Saber Hilt",
	"Darth Maul's Hilt",
	"Count Dooku's Hilt",
	"Jocastanu Hilt",
	"Kit Fisto's Hilt",
	"Kyle Katarn's Hilt",
	"Kylo Ren's Hilt",
	"Luke Skywalker's Hilt EP6",
	"Luminara Unduli's Hilt",
	"Mace Windu's Hilt",
	"Obi-Wan Kenobi's Hilt EP1",
	"Obi-Wan Kenobi's Hilt EP3",
	"Qui-Gon Gin's Hilt",
	"Saesee Tiin's Hilt",
	"Shaak Ti's Hilt",
	"Darth Sidious' Hilt",
	"Darth Vader's Hilt",
	"Yoda's Hilt",
}
------------------------

-- Staff & Pike loot config
------------------------
Loot.CommonStaffs = {
    "Dual Blade 1 Hilt",
	"Dual Blade 2 Hilt",
	"Dual Blade 3 Hilt",
	"Dual Blade 4 Hilt",
	"Dual Blade 5 Hilt",
	"Dani Hilt",
	"Dante Hilt",
	"Darth Maul",
	"Darth Maul Staff Hilt",
}

Loot.RareStaffs = {
    "Pike 1 Hilt",
	"Pike 2 Hilt",
	"Pike 3 Hilt",
	"Pike 4 Hilt",
	"Snake Hilt",
	"Snake 2 Hilt",
	"Trident Hilt",
	"Twin Hilt",
}
-------------------------

-- Dark-Inner loot config
-------------------------
Loot.CommonDarkInner = {
    "Dark Inner Crystal ( Blue )",
	"Dark Inner Crystal ( Green )",
	"Dark Inner Crystal ( Purple )",
	"Dark Inner Crystal ( Red )",
	"Dark Inner Crystal ( Yellow )",
}

Loot.RareDarkInner = {
    "Dark Inner Crystal ( Cyan )",
	"Dark Inner Crystal ( Light Green )",
	"Dark Inner Crystal ( Orange )",
	"Dark Inner Crystal ( Pink )",
	"Dark Inner Crystal ( White )",
}
-------------------------

-- Unstable loot config
-------------------------
Loot.CommonUnstable = {
    "Unstable Crystal ( Blue )",
	"Unstable Crystal ( Cyan )",
	"Unstable Crystal ( Green )",
	"Unstable Crystal ( Light Green )",
	"Unstable Crystal ( Orange )",
	"Unstable Crystal ( Pink )",
	"Unstable Crystal ( Purple )",
	"Unstable Crystal ( Red )",
	"Unstable Crystal ( White )",
	"Unstable Crystal ( Yellow )",
}

Loot.RareUnstable = {
    "Unstable Crystal ( Dark Inner Blue )",
	"Unstable Crystal ( Dark Inner Cyan )",
	"Unstable Crystal ( Dark Inner Green )",
	"Unstable Crystal ( Dark Inner Light Green )",
	"Unstable Crystal ( Dark Inner Orange )",
	"Unstable Crystal ( Dark Inner Pink )",
	"Unstable Crystal ( Dark Inner Purple )",
	"Unstable Crystal ( Dark Inner Red )",
	"Unstable Crystal ( Dark Inner White )",
	"Unstable Crystal ( Dark Inner Yellow )",
}
-------------------------

-- Corrupted loot config
-------------------------
Loot.CommonCorrupted = {
    "Corrupted Crystal ( Blue )",
	"Corrupted Crystal ( Cyan )",
	"Corrupted Crystal ( Green )",
	"Corrupted Crystal ( Light Green )",
	"Corrupted Crystal ( Orange )",
	"Corrupted Crystal ( Pink )",
	"Corrupted Crystal ( Purple )",
	"Corrupted Crystal ( Red )",
	"Corrupted Crystal ( White )",
	"Corrupted Crystal ( Yellow )",
}

Loot.RareCorrupted = {
    "Corrupted Crystal ( Dark Inner Blue )",
	"Corrupted Crystal ( Dark Inner Cyan )",
	"Corrupted Crystal ( Dark Inner Green )",
	"Corrupted Crystal ( Dark Inner Light Green )",
	"Corrupted Crystal ( Dark Inner Orange )",
	"Corrupted Crystal ( Dark Inner Pink )",
	"Corrupted Crystal ( Dark Inner Purple )",
	"Corrupted Crystal ( Dark Inner Red )",
	"Corrupted Crystal ( Dark Inner White )",
	"Corrupted Crystal ( Dark Inner Yellow )",
}
-------------------------

--[[--------------------------------
	All XP configurations are below.
	If you wish to add more xp amounts
	Simply just add in more
	"",
	"",
	"",
	DON'T FORGET YOUR COMMAS
--]]--------------------------------

-- Misc Item XP config
--------------------------
Loot.CommonMiscXP = {
	"10",
	"20",
	"30",
	"40",
	"50",
}

Loot.RareMiscXP = {
	"60",
	"70",
	"80",
	"90",
	"100",
}
--------------------------

-- Crystal XP config
--------------------------
Loot.CommonCrystalXP = {
	"10",
	"20",
	"30",
	"40",
	"50",
}

Loot.RareCrystalXP = {
	"60",
	"70",
	"80",
	"90",
	"100",
}
---------------------------

-- Hilt XP config
---------------------------
Loot.CommonHiltXP = {
	"20",
	"40",
	"60",
	"80",
	"100",
}

Loot.RareHiltXP = {
	"120",
	"140",
	"160",
	"180",
	"200",
}
----------------------------

-- Staff XP config
----------------------------
Loot.CommonStaffXP = {
	"20",
	"40",
	"60",
	"80",
	"100",
}

Loot.RareStaffXP = {
	"120",
	"140",
	"160",
	"180",
	"200",
}
-----------------------------

-- Dark-Inner XP config
-----------------------------
Loot.CommonDarkInnerXP = {
	"20",
	"40",
	"60",
	"80",
	"100",
}

Loot.RareDarkInnerXP = {
	"120",
	"140",
	"160",
	"180",
	"200",
}
------------------------------

-- Unstable XP config
------------------------------
Loot.CommonUnstableXP = {
	"500",
	"600",
	"700",
}

Loot.RareUnstableXP = {
	"800",
	"900",
	"1000",
}
------------------------------

-- Corrupted XP config
------------------------------
Loot.CommonCorruptedXP = {
	"500",
	"600",
	"700",
}

Loot.RareCorruptedXP = {
	"800",
	"900",
	"1000",
}
-------------------------------