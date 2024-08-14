--[[----------------------------------------------------------------------

	████████╗░█████╗░░█████╗░██████╗░
	╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗
	░░░██║░░░██║░░██║██║░░██║██║░░██║
	░░░██║░░░██║░░██║██║░░██║██║░░██║
	░░░██║░░░╚█████╔╝╚█████╔╝██████╔╝
	░░░╚═╝░░░░╚════╝░░╚════╝░╚═════╝░

    Author: Tood/The Toodster.
    Support: discord.gg/YSzU6MY2Yb
	Legacy Version v4.0
--]]----------------------------------------------------------------------

-- How long, in seconds, when a player uses the lootbox should it take to despawn.
T_WOSLEGACY.Config.LootboxDespawn = 15

-- How much of the NPC's max health does the player need to damage to qualify for the loot.
-- So if 5 then that's 5% of the NPC's max health, 7 = 7%, 30 = 30% etc.
T_WOSLEGACY.Config.DamagePercent = 5

--[[
    Create your own lootboxes!
    NOTE: If you create a lootbox then remove it from this table then it will no longer be on your server after a restart.
--]]
T_WOSLEGACY.Config.LootTable = {
    ["Common"] = { -- What is the name of this lootbox. This will display above the lootbox when spawned. Can be anything you want. MUST be unique.
        model = "models/Items/ammoCrate_Rockets.mdl", -- What model should this lootbox use.
        rarity = 245, -- How rare is this lootbox. Lower rarity = harder to drop.
        allowed_npcs = { -- What NPC's can the lootbox drop from.
            ["npc_combine_s"] = true,
            ["npc_stalker"] = true,
        },
        item_drops = {
            ["Crystal ( Green )"] = 5, -- Item name and rarity of that item. The name must be an ALCS item name. Lower rarity = harder to get, there is no max.
            ["Crystal ( Blue )"] = 80,
            ["Crystal ( Yellow )"] = 300,
        },
        xp = false, -- Should players gain XP for opening this lootbox, set this to false if NO XP should be given.
        color = Color( 0, 180, 0 ), -- Rarity color, this will be the color of the item/lootbox in the chat message and the text above the lootbox.
    },
--------------------------------------------------------------------------------
    ["Uncommon"] = {
        model = "models/Items/ammocrate_smg1.mdl",
        rarity = 160,
        allowed_npcs = {
            ["npc_antlion"] = true,
            ["npc_headcrab_fast"] = true,
            ["npc_zombie"] = true,
        },
        item_drops = {
            ["Basic 1 Hilt"] = 15,
            ["Basic 2 Hilt"] = 115,
            ["Basic 3 Hilt"] = 260,
        },
        xp = 50,
        color = Color( 0, 0, 180 ),
    },
--------------------------------------------------------------------------------
    ["Rare"] = {
        model = "models/Items/ammocrate_ar2.mdl",
        rarity = 95,
        allowed_npcs = {
            ["npc_combine_s"] = true,
            ["npc_stalker"] = true,
        },
        item_drops = {
            ["Corrupted Crystal ( Dark Inner Green )"] = 3,
            ["Corrupted Crystal ( Dark Inner Blue )"] = 125,
            ["Corrupted Crystal ( Dark Inner Yellow )"] = 230,
        },
        xp = 120,
        color = Color( 165, 0, 255 ),
    },
--------------------------------------------------------------------------------
    ["Legendary"] = {
        model = "models/Items/ammocrate_grenade.mdl",
        rarity = 2,
        allowed_npcs = {
            ["npc_antlion"] = true,
            ["npc_headcrab_fast"] = true,
            ["npc_zombie"] = true,
        },
        item_drops = {
            ["Dual Blade 1 Hilt"] = 20,
            ["Dual Blade 2 Hilt"] = 190,
            ["Dual Blade 3 Hilt"] = 290,
        },
        xp = 5000,
        color = Color( 180, 180, 0 ),
    },
}