T_LSCS = T_LSCS || {}
T_LSCS.Config = T_LSCS.Config || {}

-- What model should the lootbox use.
T_LSCS.Config.LootboxModel = "models/Items/ammocrate_ar2.mdl"

-- How long, in seconds, when a player uses the lootbox should it take to despawn.
T_LSCS.Config.LootboxDespawn = 5

-- How much of the NPC's max health does the player need to damage to qualify for the loot.
-- So if 5 then that's 5% of the NPC's max health, 7 = 7%, 30 = 30% etc.
T_LSCS.Config.DamagePercent = 5

-- What NPC's have a chance of dropping the lootbox.
T_LSCS.Config.NPCTbl = {
	["npc_zombie"] = true,
	["npc_vj_as_droneb"] = true,
	["npc_vj_as_droneb_elite"] = true,
}

T_LSCS.Config.ItemsTbl = {
	["Artifact"] = { -- This name can be anything you like.
		rarity = 0.5, -- The rarity for these items, lower = harder to get, higher = easier to get.
		items = {
			"item_crystal_nanoparticles", -- The class of the item. Can be crystals, hilts, powers or stances.
			"item_force_throw",
		},
	},
---------------------------------------------------
	["Legendary"] = {
		rarity = 5,
		items = {
			"item_force_sense",
			"item_force_push",
		},
	},
---------------------------------------------------
	["Epic"] = {
		rarity = 8,
		items = {
			"item_force_lightning",
			"item_force_replenish",
		},
	},
---------------------------------------------------
	["Rare"] = {
		rarity = 15,
		items = {
			"item_force_jump",
			"item_crystal_citrine",
			"item_saberhilt_guard",
			"item_stance_butterfly",
		},
	},
---------------------------------------------------
	["Uncommon"] = {
		rarity = 50,
		items = {
			"item_force_pull",
			"item_crystal_amethyst",
			"item_saberhilt_nanosword",
			"item_stance_juggernaut",
		},
	},
---------------------------------------------------
	["Common"] = {
		rarity = 200,
		items = {
			"item_force_heal",
			"item_crystal_allnatt",
			"item_saberhilt_katarn",
			"item_stance_yongli",
		},
	},
---------------------------------------------------
}