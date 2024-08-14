--[[----------------------------------------------------------------------

	████████╗░█████╗░░█████╗░██████╗░
	╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗
	░░░██║░░░██║░░██║██║░░██║██║░░██║
	░░░██║░░░██║░░██║██║░░██║██║░░██║
	░░░██║░░░╚█████╔╝╚█████╔╝██████╔╝
	░░░╚═╝░░░░╚════╝░░╚════╝░╚═════╝░

	Support: discord.gg/YSzU6MY2Yb

--]]----------------------------------------------------------------------

T_WOS = T_WOS || {} -- Don't touch.
T_WOS.Config = T_WOS.Config || {} -- Don't touch.

-- What model should the lootbox use.
T_WOS.Config.LootboxModel = "models/Items/ammocrate_ar2.mdl"

-- This is the time it takes to despawn, in seconds.
T_WOS.Config.LootboxDespawn = 30

-- How much of the NPC's max health does the player need to damage to qualify for the loot.
-- So if 5 then that's 5% of the NPC's max health, 7 = 7%, 30 = 30% etc.
T_WOS.Config.DamagePercent = 2

-- What NPC's have a chance of dropping the lootbox.
T_WOS.Config.AllowedNPCs = {
	["npc_antlion"] = true,
    ["npc_combine_s"] = true,
    ["npc_stalker"] = true,
}

-- How much XP should the player get for opening the lootbox.
-- Set to false if no XP should be given.
T_WOS.Config.GiveXP = false